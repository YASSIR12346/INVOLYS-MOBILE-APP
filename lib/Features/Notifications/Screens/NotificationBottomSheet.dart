import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:involys_mobile_app/Features/Home/Provider/appProvider.dart';
import 'package:provider/provider.dart';
import '../../../Shared/Toasts.dart';
import '../Models/Notifications.dart';
import '../Providers/NotificationProvider.dart';
import '../Services/NotificationService.dart';
import 'RemindDialog.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NotificationBottomSheet extends StatefulWidget {
  final BuildContext context;
  final GeneratedAlert generatedAlert;
  final GlobalKey<State> RemindDialog;
  const NotificationBottomSheet( {super.key,required this.context,required this.RemindDialog,required this.generatedAlert});

  @override
  State<NotificationBottomSheet> createState() => _NotificationBottomSheetState();
}

class _NotificationBottomSheetState extends State<NotificationBottomSheet> {

  bool first=false;
  bool second=false;
  bool third =false;



   NotificationService notificationService=NotificationService();
   
  @override
  Widget build(BuildContext context) {
    final notificationProvider = Provider.of<NotificationProvider>(context);
     return Column(
       mainAxisAlignment: MainAxisAlignment.center,
       mainAxisSize: MainAxisSize.min,
       children: <Widget>[
      GestureDetector(
        onTapDown: (Tap)async {    
         setState(() {
           first=true;
         });
         
        },
        onTapUp: (tap)async{
          await Future.delayed(const Duration(milliseconds: 250));
           setState(() {
           first=false;
         });
          
        },
        onTapCancel:()async{
           setState(() {
           first=false;
         });
          
        },
        onTap: () async {
          await Future.delayed(const Duration(milliseconds: 400));
           notificationProvider.readAlertCorrected(widget.generatedAlert.id);
           Navigator.of(context,rootNavigator: true).pop();
           ShowToast("Marked as Read");
        },
        child: Container(
          color:first?Color.fromARGB(255, 212, 212, 212):Provider.of<AppProvider>(context, listen: false).isDarkMode?Colors.black:Colors.white,
            height: 62,
            child: Stack(children: [
              Align(
                alignment: Alignment(-0.92, 0),
                child: Icon(FontAwesomeIcons.check, color: Provider.of<AppProvider>(context, listen: false).isDarkMode?Colors.white:Colors.black),
              ),
              Positioned(
                left:70,
                top:0,
                bottom: 0,
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    textAlign:TextAlign.left,
                    AppLocalizations.of(context)!.markAsRead,
                    style: TextStyle(
                      color: Provider.of<AppProvider>(context, listen: false).isDarkMode?Colors.white:Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ])),
      ),
      GestureDetector(
        onTapDown: (Tap)async {    
         setState(() {
           second=true;
         });
         
        },
        onTapUp: (tap)async{
          await Future.delayed(const Duration(milliseconds: 250));
           setState(() {
           second=false;
         });
          
        },
        onTapCancel:()async{
           setState(() {
           second=false;
         });
          
        },
        onTap: () async{
          await Future.delayed(const Duration(milliseconds: 400));
           String result=await notificationProvider.hideAlert(widget.generatedAlert.id);
            Provider.of<NotificationProvider>(context,listen:false)
          .getNotifications();
           Navigator.of(context,rootNavigator: true).pop();
           ShowToast(result);
        },
        child: Container(
          color:second? Color.fromARGB(255, 212, 212, 212):Provider.of<AppProvider>(context, listen: false).isDarkMode?Colors.black:Colors.white,
            height: 62,
            child: Stack(children: [
              Align(
                alignment: Alignment(-0.92, 0),
                child: Icon(FontAwesomeIcons.eyeSlash, color:  Provider.of<AppProvider>(context, listen: false).isDarkMode?Colors.white:Colors.black),
              ),
              Positioned(
                left:70,
                top:0,
                bottom: 0,
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    textAlign:TextAlign.left,
                    AppLocalizations.of(context)!.hide,
                    style: TextStyle(
                      color:  Provider.of<AppProvider>(context, listen: false).isDarkMode?Colors.white:Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ])),
      ),
      GestureDetector(
     
         onTapDown: (Tap)async {    
         setState(() {
           third=true;
         });
         
        },
        onTapUp: (tap)async{
          await Future.delayed(const Duration(milliseconds: 250));
           setState(() {
           third=false;
         });
          
        },
        onTapCancel:()async{
           setState(() {
           third=false;
         });
          
        },
        onTap: ()async {
          await Future.delayed(const Duration(milliseconds: 400));
          RemindDialog.showRemindDialog(context, widget.RemindDialog,widget.generatedAlert,notificationService);
        },
        child: Container(
          color:third? Color.fromARGB(255, 212, 212, 212):Provider.of<AppProvider>(context, listen: false).isDarkMode?Colors.black:Colors.white,
            height: 62,
            child: Stack(children: [
              Align(
                alignment: Alignment(-0.92, 0),
                child:
                    Icon(FontAwesomeIcons.calendarCheck, color:  Provider.of<AppProvider>(context, listen: false).isDarkMode?Colors.white:Colors.black),
              ),
             Positioned(
                left:70,
                top:0,
                bottom: 0,
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    textAlign:TextAlign.left,
                    AppLocalizations.of(context)!.remindMe,
                    style: TextStyle(
                      color:  Provider.of<AppProvider>(context, listen: false).isDarkMode?Colors.white:Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ])),
      )
       ],
     );
  }
}
