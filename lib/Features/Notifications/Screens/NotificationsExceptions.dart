import 'package:flutter/material.dart';
import 'package:involys_mobile_app/Features/Home/Provider/appProvider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../Providers/NotificationProvider.dart';

class NotificationsExceptions extends StatelessWidget {
  final String? status;

  const NotificationsExceptions(this.status, {super.key});

  @override
  Widget build(BuildContext context) {
    if (this.status == "Network Error") {
      return  Stack(
          fit: StackFit.expand,
          children: [
            Align(
              alignment: Alignment(0, -0.35),
              child: Image.asset(
                "assets/exclamation.png",
                fit: BoxFit.cover,
                width: 130,
                height: 130,
              ),
            ),
            Align(
              alignment: Alignment(0, 0.15),
              child: Text(
                AppLocalizations.of(context)!.errorone,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Provider.of<AppProvider>(context, listen: false).isDarkMode?Colors.white:Colors.black),
              ),
            ),
            Align(
              alignment: Alignment(0, 0.31),
              child: Padding(
                 padding: EdgeInsets.symmetric(horizontal: 14),
                child: Text(
                  textAlign:TextAlign.center,
                 AppLocalizations.of(context)!.errortwo ,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey),
                ),
              ),
            ),
            Align(
              alignment: Alignment(0, 0.6),
              child: ElevatedButton(
                onPressed: () {
                  Provider.of<NotificationProvider>(context, listen: false)
                      .getNotifications();
                },
                child: Text("Refresh", style: TextStyle(fontSize: 20)),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(90, 40),
                  foregroundColor: Color.fromARGB(255, 0, 72, 153),
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Color.fromARGB(255, 0, 72, 153),
                      width: 1.4,
                    ),
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                ),
              ),
            ),
          ],
        );
    } else if (this.status == "You don't have any Notifications") {
      return Stack(
        fit: StackFit.expand,
        children: [
          Align(
            alignment: Alignment(0, -0.4),
            child: Image.asset(
              "assets/notification.jpg",
              fit: BoxFit.cover,
              width: 141,
              height: 141,
            ),
          ),
          Align(
            alignment: Alignment(0, 0.2),
            child: Text(
              "No notifications Yet",
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
          Align(
            alignment: Alignment(0, 0.33),
            child: Text(
              "When you get notifications,they'll show up here",
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey),
            ),
          ),
          Align(
            alignment: Alignment(0, 0.6),
            child: ElevatedButton(
              onPressed: () {
                Provider.of<NotificationProvider>(context, listen: false)
                    .getNotifications();
              },
              child: Text("Refresh", style: TextStyle(fontSize: 20)),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(90, 40),
                foregroundColor: Color.fromARGB(255, 0, 72, 153),
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: Color.fromARGB(255, 0, 72, 153),
                    width: 1.4,
                  ),
                  borderRadius: BorderRadius.circular(32.0),
                ),
              ),
            ),
          ),
        ],
      );
    } else {
      return Center(
          child: Text(
        this.status!,
        style: TextStyle(
            fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
      ));
    }
  }
}
