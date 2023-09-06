import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:involys_mobile_app/Features/Home/Provider/appProvider.dart';
import 'package:involys_mobile_app/Features/Notifications/Models/Notifications.dart';
import 'package:intl/intl.dart';
import 'package:involys_mobile_app/Features/Notifications/Screens/NotificationBottomSheet.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class NotificationSquare extends StatelessWidget {
  final GeneratedAlert generatedAlert;
  const NotificationSquare(this.generatedAlert, {super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<State> _RemindDialog = new GlobalKey<State>();
    return Padding(
      padding: const EdgeInsets.only(bottom: 3),
      child: Container(
        decoration: BoxDecoration(
          color:Provider.of<AppProvider>(context, listen: false).isDarkMode? Color(0xff182F4F):generatedAlert.read
              ? Colors.white
              : Color.fromARGB(255, 231, 238, 246),
          border: Border(
              left: BorderSide(
                  color: this.generatedAlert.alert.priorityLevel == 3
                      ? Colors.red
                      : this.generatedAlert.alert.priorityLevel == 2
                          ? Colors.yellow
                          : Colors.green,
                  width: 6)),
        ),
        height: 98,
        child: Stack(children: [
          Positioned(
            top: 7,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 11, right: 50, left: 6),
              child: Text(this.generatedAlert.alertText,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  )),
            ),
          ),
          Positioned(
            bottom: 7,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0, left: 6.0),
              child: Text(
                  DateFormat("yy-MM-dd")
                          .format(this.generatedAlert.receivedDate) +
                      '  ' +
                      DateFormat.jm().format(this.generatedAlert.receivedDate),
                  style: TextStyle(
                    color:Provider.of<AppProvider>(context, listen: false).isDarkMode?const Color.fromARGB(192, 255, 255, 255) :Color.fromARGB(255, 70, 70, 70),
                    fontSize: 13,
                  )),
            ),
          ),
          Positioned(
            bottom: 7,
            right: 55,
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0,left:6),
              child: Text(
                  generatedAlert.viaApplication? AppLocalizations.of(context)!.newNotification:"",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                    fontSize: 15,
                  )),
            ),
          ),
          Positioned(
            top: 0,
            bottom: 0,
            right: 5,
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 0),
              child: IconButton(
                  iconSize: 30,
                  icon: Icon(FontAwesomeIcons.ellipsisVertical,
                      color: Color.fromARGB(255, 0, 72, 153)),
                  onPressed: () {
                    showModalBottomSheet(
                      backgroundColor:Provider.of<AppProvider>(context, listen: false).isDarkMode?Colors.black:Colors.white,
                        context: context,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(25.0),
                          ),
                        ),
                        builder: (context) {
                          return NotificationBottomSheet(
                              context: context,RemindDialog: _RemindDialog,generatedAlert: this.generatedAlert);
                        });
                  }),
            ),
          ),
        ]),
      ),
    );
  }
}
