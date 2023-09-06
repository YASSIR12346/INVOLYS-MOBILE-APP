import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:involys_mobile_app/Features/Dashboard/Provider/DashboardProvider.dart';
import 'package:involys_mobile_app/Features/Home/Provider/appProvider.dart';
import 'package:involys_mobile_app/Features/Notifications/Screens/FilterBottomSheet.dart';
import 'package:involys_mobile_app/Features/Notifications/Screens/NotificationSquare.dart';
import 'package:provider/provider.dart';
import '../Providers/NotificationProvider.dart';
import 'NotificationsExceptions.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage>
 {
 
  @override
  void initState() {
    print("notification init state");
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<NotificationProvider>(context, listen: false)
          .getNotifications();
    });
    super.initState();
   
  }

  @override
  Widget build(BuildContext context) {
    final notificationProvider = Provider.of<NotificationProvider>(context);
    return Scaffold(
        backgroundColor:
         Provider.of<AppProvider>(context, listen: false).isDarkMode?
         Theme.of(context).scaffoldBackgroundColor:Colors.white,
        resizeToAvoidBottomInset: false,
        body: WillPopScope(
            onWillPop: () async {
          Provider.of<DataNotifier>(context, listen: false).widgetName="-1";
          Provider.of<AppProvider>(context, listen: false).indexB=0;
          return false;
        },
          child: Stack(fit: StackFit.expand, children: [
            Positioned(
              left: 10,
              top: 20,
              child: Text(
                "Notifications",
                style: TextStyle(
                  color: Provider.of<AppProvider>(context, listen: false).isDarkMode?Colors.white:Colors.black,
                  fontSize: 29,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Positioned(
              top: 10,
              right: 10,
              child: IconButton(
                  iconSize: 30,
                  icon: Icon(FontAwesomeIcons.filter,
                      color: Color.fromARGB(255, 0, 72, 153)),
                  onPressed: () {
                    showModalBottomSheet(
                      backgroundColor:Provider.of<AppProvider>(context, listen: false).isDarkMode?Colors.black:Colors.white ,
                        isScrollControlled: true,
                        context: context,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(25.0),
                          ),
                        ),
                        builder: (context) {
                          return FilterBottomSheet(notificationProvider:notificationProvider);
                        });
                  }),
            ),
            Align(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 70),
                  Expanded(child: Consumer<NotificationProvider>(
                    builder: (context, value, child) {
                      if (value.isLoading) {
                        return Center(child: CircularProgressIndicator(
                           color: Color.fromARGB(255, 0, 72, 153),
                          strokeWidth: 5,
                        ));
                      } else if (value.status !='success' ) {
                        return NotificationsExceptions(value.status);
                      } else {
                        return (ListView.builder(
                            itemCount: value.results!.generatedAlerts.length,
                            itemBuilder: (context, index) {
                              return NotificationSquare(
                                  value.results!.generatedAlerts[index]);
                            }));
                      }
                    },
                  )),
                ],
              ),
            )
          ]),
        ));
  }
}
