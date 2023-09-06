import 'package:flutter/material.dart';
import 'package:involys_mobile_app/Features/Notifications/Providers/NotificationProvider.dart';
import 'package:provider/provider.dart';
import '../Provider/appProvider.dart';
import 'CustomSearchDelegate.dart';// Import your AppProvider class
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final GlobalKey<ScaffoldState> drawerKey;

  CustomAppBar({required this.drawerKey});

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final notificationProvider = Provider.of<NotificationProvider>(context);
    int index = Provider.of<AppProvider>(context, listen: false).indexB;

    if (index == 0) {
      return AppBar(
        leading: IconButton(
          onPressed: () {
            drawerKey.currentState?.openDrawer();
          },
          icon: Icon(Icons.menu, color: Theme.of(context).colorScheme.secondary),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        actions: [
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: CustomSearchDelegate());
            },
            icon: Icon(Icons.search),
            color: Theme.of(context).colorScheme.secondary,
          )
        ],
      );
    } else if(index==1){
      return  AppBar(
          iconTheme:
              IconThemeData(size: 35, color:Provider.of<AppProvider>(context, listen: false).isDarkMode? Color.fromARGB(255, 0, 72, 153):Colors.white),
          toolbarHeight: 70,
          backgroundColor: Theme.of(context).colorScheme.primary,
          bottomOpacity: 0.0,
          elevation: 0.0,
          title: Container(
            height: 40.0,
            alignment: Alignment.center,
            child: TextField(
              onChanged: (value) {
                notificationProvider.search(value);
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: Color.fromARGB(255, 221, 221, 221),
                isDense: true,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                hintText:  AppLocalizations.of(context)!.search,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(
                      width: 1, color: Color.fromARGB(255, 0, 72, 153)),
                ),
                hintStyle: TextStyle(color: Color.fromARGB(255, 74, 73, 73)),
                suffixIcon: IconButton(
                    icon: Icon(Icons.search,
                        color: Color.fromARGB(255, 74, 73, 73)),
                    onPressed: () {}),
              ),
            ),
          ),
        );
    }else {
String title;
      switch (index) {
        case 3:
          title =AppLocalizations.of(context)!.settings;

          break;
        default:
          title = '';
          break;
      }

      return AppBar(
        leading: IconButton(
          onPressed: () {
            drawerKey.currentState?.openDrawer();
          },
          icon: Icon(Icons.menu, color: Theme.of(context).colorScheme.secondary),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            title,
            style: TextStyle(color: Colors.white),
          ),
        ),
        automaticallyImplyLeading: false,
      );
    }
  }
}
