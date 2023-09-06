import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:involys_mobile_app/Features/Home/Provider/appProvider.dart';
import 'package:involys_mobile_app/Features/Notifications/Models/Notifications.dart';
import 'package:provider/provider.dart';
import '../../../Shared/Toasts.dart';
import '../Providers/NotificationProvider.dart';
import '../Services/NotificationService.dart';
import 'TimeNumber.dart';
import 'TimeUnit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RemindDialog {
  static Future<void> showRemindDialog(
      BuildContext context,
      GlobalKey key,
      GeneratedAlert generatedAlert,
      NotificationService notificationService) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        int timeNumber = 0;
        int timeUnit = 1;
        return StatefulBuilder(builder: (context, setState) {
          return WillPopScope(
            onWillPop: () async => false,
            child: Dialog(
                key: key,
                backgroundColor: Provider.of<AppProvider>(context, listen: false).isDarkMode?Color(0xff182F4F):Colors.white,
                child: Container(
                  width: 280.0,
                  height: 280.0,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment(-0.85, -0.85),
                        child: Text(
                          AppLocalizations.of(context)!.remind,
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment(0.9, -0.9),
                        child: IconButton(
                            iconSize: 30,
                            icon:
                                Icon(FontAwesomeIcons.xmark, color: Provider.of<AppProvider>(context, listen: false).isDarkMode?Colors.white:Colors.black),
                            onPressed: () {
                              Provider.of<NotificationProvider>(context,
                                      listen: false)
                                  .updateflag(false);
                              Navigator.of(key.currentContext!,
                                      rootNavigator: true)
                                  .pop();
                              Navigator.of(key.currentContext!,
                                      rootNavigator: true)
                                  .pop();
                            }),
                      ),
                      Align(
                          alignment: Alignment(-0.55, 0),
                          child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                width: 2,
                                color: Color.fromARGB(255, 0, 72, 153),
                              )),
                              height: 80,
                              width: 80,
                              child: ListWheelScrollView.useDelegate(
                                onSelectedItemChanged: (value) {
                                  setState(() {
                                    timeNumber = value;
                                  });
                                },
                                itemExtent: 60,
                                physics: FixedExtentScrollPhysics(),
                                childDelegate: ListWheelChildBuilderDelegate(
                                  childCount: 100,
                                  builder: (context, index) =>
                                      TimeNumber(number: index),
                                ),
                              ))),
                      Align(
                          alignment: Alignment(0.55, 0),
                          child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                width: 2,
                                color: Color.fromARGB(255, 0, 72, 153),
                              )),
                              height: 80,
                              width: 100,
                              child: ListWheelScrollView.useDelegate(
                                onSelectedItemChanged: (value) {
                                  setState(() {
                                    timeUnit = value + 1;
                                  });
                                },
                                itemExtent: 60,
                                physics: FixedExtentScrollPhysics(),
                                childDelegate: ListWheelChildBuilderDelegate(
                                  childCount: 5,
                                  builder: (context, index) =>
                                      TimeUnit(number: index),
                                ),
                              ))),
                      Align(
                        alignment: Alignment(0, 0.8),
                        child: ElevatedButton(
                          onPressed: () async {
                            generatedAlert.timeNumber = timeNumber;
                            generatedAlert.timeUnit = timeUnit;
                            String result = await   Provider.of<NotificationProvider>(context,
                                      listen: false)
                                .remindAlert(generatedAlert);
                            Provider.of<NotificationProvider>(context,
                                      listen: false)
                                  .updateflag(false);
                            Navigator.of(key.currentContext!, rootNavigator: true)
                                .pop();
                            Navigator.of(key.currentContext!, rootNavigator: true)
                                .pop();
                            ShowToast(result);
                          },
                          child: Text(AppLocalizations.of(context)!.repeat,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(200, 40),
                            foregroundColor: Colors.white,
                            backgroundColor: Color.fromARGB(255, 0, 72, 153),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32.0),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )),
          );
        });
      },
    );
  }
}
