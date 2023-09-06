import 'package:flutter/material.dart';
import 'package:involys_mobile_app/Features/Home/Provider/appProvider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../Dashboard/Provider/DashboardProvider.dart';
import '../Logic/LanguageListView.dart';
import '../Logic/UrlServerTextField.dart';
class SettingsPage extends StatefulWidget {
  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

@override
  void initState() {
  super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          Provider.of<DataNotifier>(context, listen: false).widgetName="-1";
          Provider.of<AppProvider>(context, listen: false).indexB=0;
          return false;
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.urlServer,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              UrlServerTextField(),
              SizedBox(height: 30),
              Text(
                AppLocalizations.of(context)!.language2,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              LanguageListView(),
              SizedBox(height: 20),
              Text(
                AppLocalizations.of(context)!.theme,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Consumer<AppProvider>(
                builder: (context, provider, _) => SwitchListTile(
                  title: Text(AppLocalizations.of(context)!.darkMode),
                  value: provider.isDarkMode,
                  onChanged: (newValue) {
                    provider.toggleTheme();
                  },
                ),
              ),
              
              
              
              
            ],
          ),
        ),
      ),
    );
  }
}


