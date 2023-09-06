import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:involys_mobile_app/Features/Home/Screens/pageController.dart';
import 'package:provider/provider.dart';
import '../../../Shared/colors.dart';
import '../../../Shared/size_config.dart';
import '../../../cache/cacheHelper.dart';
import '../../Authentication/Logic/UserData.dart';
import '../../Dashboard/Models/dataModel.dart';
import '../../Dashboard/Provider/DashboardProvider.dart';
import '../Provider/appProvider.dart';
import '../Logic/loadingWidget.dart';


class MyAlertDialog extends StatefulWidget {
  @override
  _MyAlertDialogState createState() => _MyAlertDialogState();
}

class _MyAlertDialogState extends State<MyAlertDialog> {
  final TextEditingController textController = TextEditingController();

  List<dynamic> COMPANY= [];
  List<companyModel> listCompanies= [];
  bool isLoading = false;
  bool societyChanged = false;

  List<companyModel> filteredList = [];
  List<String> iDs = [];

  void retrieveData() {
    final provider = Provider.of<DataNotifier>(context, listen: false);
    COMPANY=provider.companiesData;


    COMPANY.forEach((element) {

      companyModel company=companyModel(name: element['name'], id: element['id']);
      listCompanies.add(company);
      iDs.add(company.id);

    });
  }


  void filterList(String searchText) {

    setState(() {
      filteredList = listCompanies
          .where((product) =>
          product.name.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
    });
  }

  @override
  void initState() {
    super.initState();
    retrieveData();
    filteredList.addAll(listCompanies);
    textController.addListener(() {
      filterList(textController.text);
    });
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var iconSize= SizeConfig.screenWidth * 0.1;
    var containerIconSize= SizeConfig.screenWidth * 0.14;
    String selectedId='';

    try{
      final provider = Provider.of<DataNotifier>(context, listen: false);
      var cachedID= CacheData.getData(key: 'CompanyId'+UserData.UserId!);


      if(cachedID != null && iDs.contains(cachedID)){
        selectedId = cachedID;


      } else {

        selectedId = listCompanies[0].id;


      }
    }catch(e){
      print("error :  $e");

    }







    return WillPopScope(

      onWillPop: () async {
        Provider.of<DataNotifier>(context, listen: false).widgetName="-1";
        Provider.of<AppProvider>(context, listen: false).indexB=0;

        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => Home()),
              (route) => false,
        );
        return false;
      },
      child: Stack(
        children: [
          AlertDialog(
            backgroundColor: Theme.of(context).colorScheme.onTertiary,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                isLoading ? Loading() :Container(
                  width: containerIconSize,
                  height: containerIconSize,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color:  Theme.of(context).colorScheme.primaryContainer,
                      width: 1,

                    ),
                    shape: BoxShape.circle,
                    color: Colors.transparent,
                  ),
                  child: GestureDetector(
                    onTap: () {

                      if(societyChanged){
                        Provider.of<DataNotifier>(context, listen: false).widgetName="-1";
                        Provider.of<AppProvider>(context, listen: false).indexB=0;
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => Home()),
                              (route) => false,
                        );
                      }

                      else{
                        Navigator.pop(context);
                      }

                    },
                    child: Icon(
                      Icons.close,
                      size: iconSize,
                      color: Theme.of(context).colorScheme.primaryContainer,
                    ),
                  ),
                ),
SizedBox(height: 40,),
                Text(AppLocalizations.of(context)!.society, style: TextStyle(fontSize: 16, color: Theme.of(context).colorScheme.onPrimary)),

              ],
            ),

            content: SizedBox(
              height: SizeConfig.screenHeight * 0.4,
              width: double.maxFinite,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  AnimSearchBar(

                    barHeight: 45,
                    borderRadius: 50,
                    suffixIcon: IconButton(
                      icon: Icon(Icons.clear, color: Theme.of(context).colorScheme.onPrimary),
                      onPressed: () {
                        setState(() {
                          textController.clear();
                          filterList("");
                        });
                      },
                    ),
                    textFieldColor: AppColors.grayT,
                    searchIconColor: Theme.of(context).colorScheme.onPrimary,
                    textFieldIconColor: Colors.black,
                    width: 400,
                    textController: textController,
                    onSuffixTap: () {


                    },

                    color:  Colors.red[200]!,
                    helpText: "",
                    autoFocus: true,
                    closeSearchOnSuffixTap: true,
                    animationDurationInMilli: 2000,
                    rtl: true,
                    onSubmitted: filterList,
                  ),
                  SizedBox(height: 25),
                  Consumer<DataNotifier>(
                      builder: (context,dataNotifier, child) {
                      return Expanded(
                        child: ListView.builder(
                          itemCount: filteredList.length,
                          itemBuilder: (context, index) {
                            final product = filteredList[index];

                            return Column(
                              children: [
                                ListTile(
                                  trailing:selectedId == product.id ? Icon(Icons.check, color: Theme.of(context).colorScheme.primaryContainer) : null,
                                  leading:Container(
                                    width:  SizeConfig.screenWidth * 0.12,
                                    height: SizeConfig.screenWidth * 0.12,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                      border: Border.all(
                                        color: selectedId == product.id ? Theme.of(context).colorScheme.primaryContainer :  Theme.of(context).colorScheme.tertiary,
                                        width: 2.0,
                                      ),

                                    ),
                                    child: ClipOval(
                                      child: SvgPicture.asset(
                                        'assets/society.svg',
                                        color: selectedId == product.id ? Theme.of(context).colorScheme.primaryContainer : Theme.of(context).colorScheme.tertiary,
                                      ),
                                    ),

                                  ) ,
                                  title: Text(product.name,style: TextStyle(color: selectedId == product.id ? Theme.of(context).colorScheme.primaryContainer : Theme.of(context).colorScheme.tertiary),),
                                  onTap: () async {

                                    setState(()  {
                                      selectedId=product.id;

                                      CacheData.setData(key: 'CompanyId'+UserData.UserId!, value: product.id);

                                    });
                                   dataNotifier.idSociety=selectedId;
                                    setState(() {
                                      isLoading = true;
                                    });

                                    await dataNotifier.GetData(dataNotifier.idSociety, dataNotifier.widgetName);

                                    setState(() {
                                      isLoading = false;
                                      societyChanged=true;
                                    });






                                  },
                                ),
                                Divider(
                                  color: Colors.grey,
                                  thickness: 1.0,
                                ),
                              ],
                            );
                          },
                        ),
                      );
                    }
                  ),
                ],
              ),
            ),

          ),

        ],
      ),
    );
  }
}

class AnimSearchBar extends StatelessWidget {
  const AnimSearchBar({
    Key? key,
    required this.textFieldColor,
    required this.searchIconColor,
    required this.textFieldIconColor,
    required this.width,
    required this.textController,
    required this.onSuffixTap,
    required this.color,
    required this.helpText,
    required this.autoFocus,
    required this.closeSearchOnSuffixTap,
    required this.animationDurationInMilli,
    required this.rtl,
    required this.onSubmitted,
    required this.suffixIcon,
    required this.barHeight,
    required this.borderRadius,
  }) : super(key: key);

  final double barHeight;
  final double borderRadius;
  final Color textFieldColor;
  final Color searchIconColor;
  final Color textFieldIconColor;
  final double width;
  final TextEditingController textController;
  final Function onSuffixTap;
  final Color color;
  final String helpText;
  final bool autoFocus;
  final bool closeSearchOnSuffixTap;
  final int animationDurationInMilli;
  final bool rtl;
  final Function onSubmitted;
  final Widget suffixIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: barHeight,
      width: width,
      child: TextField(
        controller: textController,
        autofocus: autoFocus,
        onChanged: onSubmitted as void Function(String)?,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: helpText,
          hintStyle: TextStyle(color: Colors.white),
          filled: true,
          fillColor: textFieldColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide.none,
          ),
          prefixIcon: Icon(
            Icons.search,
            color: searchIconColor,
          ),
          suffixIcon: closeSearchOnSuffixTap
              ? GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
              onSuffixTap();
            },
            child: suffixIcon,
          )
              : null,
        ),
      ),
    );
  }
}