import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:involys_mobile_app/Features/Authentication/Screens/LandingPage.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:involys_mobile_app/Features/Home/Provider/appProvider.dart';
import 'package:provider/provider.dart';

class NetworkErrorPage extends StatelessWidget {
  const NetworkErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Stack(fit: StackFit.expand, children: [
        Positioned(
          left: 5,
          top: 30,
          child: IconButton(
            icon: Icon(
              FontAwesomeIcons.arrowLeft,
              color: Color.fromARGB(255, 0, 72, 153),
              size: 30,
            ),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LandingPage(),
                                  ),
                                  (route) => false);;
            },
          ),
        ),
         Align(
            alignment: Alignment(0, -0.35),
            child: Image.asset(
              "assets/exclamation.png",
              fit: BoxFit.cover,
              width: 140,
              height: 140,
            ),
          ),
          Align(
            alignment: Alignment(0, 0.2),
            child: Text(
              AppLocalizations.of(context)!.errorone,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Provider.of<AppProvider>(context, listen: false).isDarkMode?Colors.white:Colors.black),
            ),
          ),
           Align(
            alignment: Alignment(0, 0.36),
            child: Padding(
               padding: EdgeInsets.symmetric(horizontal: 14),
              child: Text(
                textAlign:TextAlign.center,
               AppLocalizations.of(context)!.errortwo,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey),
              ),
            ),
          ),
      ]),
    );
  }
}
