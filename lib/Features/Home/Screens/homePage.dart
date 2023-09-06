import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:involys_mobile_app/Features/Dashboard/Screens/pieChartPage.dart';
import 'package:provider/provider.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import '../../Dashboard/Models/dataModel.dart';
import '../../Dashboard/Provider/DashboardProvider.dart';
import '../../Dashboard/Screens/Card.dart';
import '../../Dashboard/Logic/horizList.dart';
import '../Logic/loadingWidget.dart';
import '../Provider/appProvider.dart';
import 'errorPage.dart';


class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  ScrollController _scrollController = ScrollController();
  var _itemController = ItemScrollController();

  Timer? _timer;
  bool isLoading = true;
  bool firstLoading = true;
  bool isFeetched = true;

  






  Future<void> fetchData() async {
    try {
      isFeetched = true;

      final provider = Provider.of<DataNotifier>(context, listen: false);

      await provider.GetData(provider.idSociety, provider.widgetName);


    } catch (e) {
      print('HomePage: Error fetching data: $e');
    } finally {
      isFeetched = false;
    }

  }



  Future<void> initData() async {

    await fetchData();
    setState(() {
      firstLoading = false;
      isLoading = false;
    });

    startTimer();
    Provider.of<AppProvider>(context, listen: false).listController=_scrollController;

  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    _timer?.cancel();

    super.dispose();
  }

  void startTimer() {
    const duration = Duration(seconds: 30);
    _timer = Timer.periodic(duration, (Timer timer) async {
      if(!isLoading && !isFeetched && !firstLoading
      ){
        await fetchData();

      }

    });
  }




  @override
  void initState() {
    super.initState();
    print("home init state");
    initData();
    _initializeConnectivity();


    if(_scrollController.hasClients && _itemController.isAttached){
      Provider.of<AppProvider>(context, listen: false).itemController=_itemController;
      Provider.of<AppProvider>(context, listen: false).jumpToIndex(0, context);
    }



  }


  late ConnectivityResult _connectivityResult = ConnectivityResult.other;
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  void _initializeConnectivity() async {
    _connectivityResult = await Connectivity().checkConnectivity();
    _connectivitySubscription = Connectivity().onConnectivityChanged.listen((result) {
      setState(() {
        _connectivityResult = result;
      });
    });
  }



  @override
  Widget build(BuildContext context)

  {

    int selectedIndex=0;
    double deviceWidth(BuildContext context) => MediaQuery.of(context).size.width;

    return Scaffold(
      key: _drawerKey,

      body: firstLoading ? Loading()
          :( (_connectivityResult == ConnectivityResult.none || Provider.of<DataNotifier>(context, listen: false).isError)
          ? ConnectionFailedScreen()
          : Padding(
        padding: const EdgeInsets.all(8),
        child:
        Column(
          children: [
            SizedBox(height: 30,),
            SizedBox(
              height: 40,
              child:Consumer2<AppProvider, DataNotifier>(
                  builder: (context,appProvider,dataNotifier, child) {
                    return ScrollSnapList(

                      itemBuilder: (context, index) {
                        final circularIndex = index % dataNotifier.widgets.length;
                        var indice= appProvider.INDEX;
                        return buildListItem(context, circularIndex,dataNotifier.widgets);
                      },
                      itemCount: dataNotifier.widgets.length * 100,
                      itemSize: deviceWidth(context) * 0.80,
                      onItemFocus: (indice) async {
                        selectedIndex =  indice % dataNotifier.widgets.length;
                        setState(() {
                          isLoading = true;
                        });

                        dataNotifier.widgetName =dataNotifier.widgets[selectedIndex];

                        await dataNotifier.GetData(dataNotifier.idSociety, dataNotifier.widgetName);

                        setState(() {
                          isLoading = false;
                        });


                      },
                      dynamicItemSize: true,
                      listController:appProvider.listController ,
                    );
                  }
              ),

            ),
            SizedBox(height: 20,),
            isLoading ?  Loading() : Expanded(
              child: Consumer2<DataNotifier,AppProvider>(
                  builder: (context,dataNotifier,appProvider ,child) {
                    return ScrollablePositionedList.separated(
                      itemScrollController: appProvider.itemController,
                      itemCount: dataNotifier.data!.grapheData.length,
                      separatorBuilder: (context, index) =>
                          Divider(),
                      itemBuilder: (context, index) {
                        dynamic TypeWidget=dataNotifier.data!.typesData[index];


                        switch (TypeWidget) {
                          case 1:
                            print('Typewidget: is Calendar');
                            return Text('');
                            break;
                          case 2:
                            print('Typewidget: is Card');
                            List<Data> donne= dataNotifier.data!.grapheData[index];
                            Data element= donne[0];

                            return InfoCard(colorTitle: element.color, label: element.name, value: element.percent.toString(), color: element.colorOpac,);
                            break;
                          case 3:
                            print('Typewidget: is Pie Chart');
                            return PieChartPage( dataPie:dataNotifier.data!.grapheData[index],title:  dataNotifier.data!.titleData[index]
                            );

                            break;
                          default:
                            print('Selected Type is unknown');
                            return Text("Selected Type is unknown");
                        }





                      },
                    );
                  }
              ),
            ),
          ],
        ),

      )),
    );
  }
}