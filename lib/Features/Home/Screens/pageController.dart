import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:involys_mobile_app/Features/Authentication/Logic/UserData.dart';
import 'package:involys_mobile_app/Features/Home/Screens/homePage.dart';
import 'package:involys_mobile_app/Features/Home/Screens/settingsPage.dart';
import 'package:involys_mobile_app/Features/Home/Screens/society.dart';
import 'package:involys_mobile_app/Features/Notifications/Logic/NotificationApi.dart';
import 'package:involys_mobile_app/Features/Notifications/Models/Notifications.dart';
import 'package:involys_mobile_app/Features/Notifications/Providers/NotificationProvider.dart';
import 'package:involys_mobile_app/Features/Notifications/Screens/RemindAlertDialog.dart';
import 'package:involys_mobile_app/Shared/SharedPreferencesManagement.dart';
import 'package:provider/provider.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import '../../Dashboard/Provider/DashboardProvider.dart';
import '../../Notifications/Screens/NotificationPage.dart';
import '../../Notifications/Services/NotificationService.dart';
import '../Logic/AppBar.dart';
import '../Logic/NavigationDrawer.dart';
import '../Logic/iconWidget.dart';
import '../Logic/rate_app_init_widget.dart';
import '../Provider/appProvider.dart';
import 'dart:convert';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with WidgetsBindingObserver {
  final GlobalKey<State> _RemindDialog = new GlobalKey<State>();
  final GlobalKey<State> _AlertDialog = new GlobalKey<State>();
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  int notifications = 0;
  NotificationService notificationService = NotificationService();

  int index = 0;


   


  call() async {
    await SharedPreferencesManagement.init();
    await SharedPreferencesManagement.preferences!.reload();
    setState(() {
      notifications = SharedPreferencesManagement.getNotifications(UserData.UserId) ?? 0;
    });
 
  }

  clean() async {
    await SharedPreferencesManagement.init();
    await SharedPreferencesManagement.preferences!.reload();
    SharedPreferencesManagement.setNotifications(UserData.UserId,0);
    setState(() {
      notifications = 0;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      call();
    });
    NotificationApi.init();
    try{
    AwesomeNotifications().actionStream.listen((action) async {
      var payload = action.payload;
      if (payload!["type"] == "notifications") {
         Provider.of<AppProvider>(context, listen: false).indexB=0;
      } else if (payload["type"] == "alert") {
        if (Provider.of<NotificationProvider>(context, listen: false)
                .alertflag !=
            true) {     
          var generatedAlert = jsonDecode(payload["body"]!);
          generatedAlert = GeneratedAlert.fromJson(generatedAlert);
          RemindAlertDialog.showAlertDialog(context, _AlertDialog,
              _RemindDialog, generatedAlert, notificationService);
          Provider.of<NotificationProvider>(context, listen: false)
              .updateflag(true);
        }
      }
    });
    }
    catch(e){

    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        call();
        Provider.of<NotificationProvider>(context, listen: false)
            .getNotifications();
      });
     
    } else if (state == AppLifecycleState.inactive) {
     
    } else if (state == AppLifecycleState.detached) {
      
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _drawerKey,
      appBar: CustomAppBar(drawerKey: _drawerKey),
      drawer: RateAppInitWidget(
        builder: (rateMyApp) => NavigationDrawerC(
          rateMyApp: rateMyApp,
        ),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      bottomNavigationBar:
          Consumer<AppProvider>(builder: (context, appProvider, child) {
        return CurvedNavigationBar(
          items: [
            CustomIcon(icon: Icons.home),
            Badge(
                isLabelVisible: notifications > 0,
                label: Text(
                  notifications.toString(),
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
                child: Icon(
                  Icons.notifications,
                  color: Provider.of<AppProvider>(context, listen: false).isDarkMode?Color(0xff2673DD):Colors.white,
                )),
            CustomIcon(icon: Icons.assured_workload),
            CustomIcon(icon: Icons.settings),
          ],
          height: 55,
          backgroundColor: Colors.transparent,
          color: Theme.of(context).colorScheme.primary,
          index: Provider.of<AppProvider>(context, listen: false).indexB,
          onTap: (index) {
            if (index == 0) {
              appProvider.indexB = index;
              final provider =
                  Provider.of<DataNotifier>(context, listen: false);
              provider.widgetName = "-1";
            } else if (index == 2) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return MyAlertDialog(); // Replace with your dialog widget
                },
              );
            } else if (index == 1) {
              appProvider.indexB = index;
              if (Provider.of<NotificationProvider>(context, listen: false)
                      .status ==
                  "success") {
                FlutterAppBadger.removeBadge();
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  clean();
                  
                });
              }
            } else {
              appProvider.indexB = index;
            }
            setState(() {});
          },
        );
      }),
      body: getSelectedWidget(),
    );
  }

  Widget getSelectedWidget() {
    Widget widget;
    switch (Provider.of<AppProvider>(context, listen: false).indexB) {
      case 0:
        widget = HomePage();
        break;

      case 1:
        widget = NotificationPage();
        break;

      case 3:
        widget = SettingsPage();
        break;
      default:
        widget = HomePage();
        break;
    }
    return widget;
  }
}
