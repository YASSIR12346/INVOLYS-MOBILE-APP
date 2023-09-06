import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:involys_mobile_app/Features/Notifications/Screens/RemindDialog.dart';
import 'package:provider/provider.dart';
import '../../../Shared/Toasts.dart';
import '../Models/Notifications.dart';
import '../Providers/NotificationProvider.dart';
import '../Services/NotificationService.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RemindAlertDialog {
  static Future<void> showAlertDialog(
      BuildContext context,
      GlobalKey key,
      _RemindDialog,
      GeneratedAlert generatedAlert,
      NotificationService notificationService) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return WillPopScope(
            onWillPop: () async => false,
            child: Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(26.0))),
                key: key,
                backgroundColor: Colors.white,
                child: Container(
                  width: 340.0,
                  height: 350.0,
                  child: Stack(
                    children: [
                      Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(26.0),
                                  topRight: Radius.circular(26.0)),
                              color: generatedAlert.alert.priorityLevel == 3
                                  ? Colors.red
                                  : generatedAlert.alert.priorityLevel == 2
                                      ? Colors.yellow
                                      : Colors.green,
                            ),
                            width: 340.0,
                            height: 130.0,
                          )),
                      Align(
                        alignment: Alignment(0.95, -0.95),
                        child: IconButton(
                            iconSize: 30,
                            icon: Icon(
                              FontAwesomeIcons.xmark,
                              color: Colors.white,
                              size: 30,
                            ),
                            onPressed: () {
                              Provider.of<NotificationProvider>(context,
                                      listen: false)
                                  .updateflag(false);
                              Navigator.of(key.currentContext!,
                                      rootNavigator: true)
                                  .pop();
                            }),
                      ),
                      Align(
                        alignment: Alignment(0, -0.8),
                        child: Icon(
                          FontAwesomeIcons.triangleExclamation,
                          color: Colors.white,
                          size: 70,
                        ),
                      ),
                      Positioned(
                        top: 150,
                        left: 110,
                        child: Text(
                          AppLocalizations.of(context)!.remind,
                          style: TextStyle(
                            color: generatedAlert.alert.priorityLevel == 3
                                ? Colors.red
                                : generatedAlert.alert.priorityLevel == 2
                                    ? Colors.yellow
                                    : Colors.green,
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Align(
                          alignment: Alignment(0, 0.39),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 10.0, left: 10.0, right: 10),
                            child: Text(
                              generatedAlert.alertText,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          )),
                      Positioned(
                        left: 10,
                        bottom: 15,
                        child: ElevatedButton(
                          onPressed: () async {
                            String result = await  Provider.of<NotificationProvider>(context,
                                    listen: false)
                                .readAlert(generatedAlert.id);
                            Provider.of<NotificationProvider>(context,
                                    listen: false)
                                .updateflag(false);
                            Navigator.of(key.currentContext!, rootNavigator: true)
                                .pop();
                            ShowToast(result);
                          },
                          child: Text(AppLocalizations.of(context)!.markAsRead,
                              style: TextStyle(fontSize: 16)),
                          style: ElevatedButton.styleFrom(
                            fixedSize: Size(120, 40),
                            foregroundColor:
                                generatedAlert.alert.priorityLevel == 3
                                    ? Colors.red
                                    : generatedAlert.alert.priorityLevel == 2
                                        ? Colors.yellow
                                        : Colors.green,
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: generatedAlert.alert.priorityLevel == 3
                                    ? Colors.red
                                    : generatedAlert.alert.priorityLevel == 2
                                        ? Colors.yellow
                                        : Colors.green,
                                width: 1.4,
                              ),
                              borderRadius: BorderRadius.circular(32.0),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 10,
                        bottom: 15,
                        child: ElevatedButton.icon(
                          icon:Icon(
                            FontAwesomeIcons.calendarDays,
                            color: Colors.white,
                            size: 18,
                          ),
                          onPressed: () {
                             RemindDialog.showRemindDialog(context, _RemindDialog,generatedAlert,notificationService);
                          },
                          label: Text(
                            AppLocalizations.of(context)!.schedule,
                            style: const TextStyle(
                                fontSize: 14, color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            fixedSize: Size(115, 40),
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
