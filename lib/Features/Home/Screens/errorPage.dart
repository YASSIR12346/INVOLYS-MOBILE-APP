import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:involys_mobile_app/Features/Home/Screens/pageController.dart';
import 'package:provider/provider.dart';

import '../../../Shared/size_config.dart';
import '../../Dashboard/Provider/DashboardProvider.dart';
import '../Provider/appProvider.dart';

class ConnectionFailedScreen extends StatefulWidget {

  @override
  State<ConnectionFailedScreen> createState() => _ConnectionFailedScreenState();
}

class _ConnectionFailedScreenState extends State<ConnectionFailedScreen> {

  Future<void> initData() async {
    try {
      Provider.of<DataNotifier>(context, listen: false).widgetName="-1";
    } catch (e) {
      print('Error: $e');
    }

  }


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      initData();
    });


  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(

      body: Container(
        // Set the desired width
          height: SizeConfig.screenHeight,
        color: Color(0xffEFF1F3),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                "assets/Error.png",
                fit: BoxFit.fitWidth,
                height: MediaQuery.of(context).size.height * 0.42,
                width: MediaQuery.of(context).size.width,
              ),

              SizedBox(height: 70),
              Text(
                textAlign: TextAlign.center,

                AppLocalizations.of(context)!.cnxLost,
    style: TextStyle(
      color:Color(0xff15202E),
    fontSize: 20,
    fontWeight: FontWeight.bold,
    ),
    ),
              SizedBox(height: 20),
              Text(

                AppLocalizations.of(context)!.checkCNX,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xff15202E),
              fontSize: 16,
              ),
                      ),
              SizedBox(height: 30),
            Container(
                width: SizeConfig.screenWidth * 0.80,
              child: TextButton(
              style: TextButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
              ),
              ),
              onPressed: () {
                Provider.of<DataNotifier>(context, listen: false).widgetName="-1";
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => Home()),
                      (route) => false,
                );
                },
                child: Text(
                  AppLocalizations.of(context)!.tryAgain.toUpperCase(),
                style: TextStyle(color: Colors.white),
              ),
              ),
            ),

                    ],

      ),
        ),
    ));
  }
}


