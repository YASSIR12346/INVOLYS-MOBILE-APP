import 'package:flutter/material.dart';
import 'package:involys_mobile_app/Features/Authentication/Screens/LoginPage.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {


  @override
  void initState() {
    super.initState();
   
    
  }
  @override
  Widget build(BuildContext context) {
    FlutterAppBadger.removeBadge();
    return Scaffold(
       resizeToAvoidBottomInset: false,
        body: Container(
            child: Stack(
      fit: StackFit.expand,
      children: [
       
        Align(
          alignment: Alignment(0, -0.6),
          child: Container(
            
            width: 260,
            height: 260,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Color.fromARGB(255, 0, 72, 153),
                style: BorderStyle.solid,
                width: 6.0,
              ),
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: AssetImage('assets/involys_logo _officiel.jpg'),
                  fit: BoxFit.contain,
                  )
            ),
          ),
        ),
        Align(
          alignment: Alignment(0, 0.5),
          child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppLocalizations.of(context)!.titleOne,
                  style: TextStyle(
                    color: Color.fromARGB(255, 0, 72, 153),
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
               
                const SizedBox(height: 27),
                ElevatedButton(
                  child: Text(AppLocalizations.of(context)!.login,
                  style:TextStyle(
                     fontSize: 20,
                    fontWeight: FontWeight.bold
                  )),
                  onPressed: () => {
                    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                      return LoginPage();
                    }))
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(300, 50),
                    foregroundColor: Colors.white,
                    backgroundColor:Color.fromARGB(255, 0, 72, 153) ,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0),
                    ),
                  ),
                )
              ]),
        )
      ],
    )));
  }
}
