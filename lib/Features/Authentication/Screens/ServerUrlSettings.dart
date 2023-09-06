import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:involys_mobile_app/Features/Authentication/Providers/AuthenticationProvider.dart';
import 'package:involys_mobile_app/Features/Authentication/Screens/LandingPage.dart';
import 'package:provider/provider.dart';

class ServerUrlSettings extends StatefulWidget {
  const ServerUrlSettings({super.key});

  @override
  State<ServerUrlSettings> createState() => _ServerUrlSettingsState();
}

class _ServerUrlSettingsState extends State<ServerUrlSettings> {
  final _urlFormfield = GlobalKey<FormState>();
  final serverUrlController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(fit: StackFit.expand, children: [
        Align(
          alignment: Alignment(0, -0.6),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Configuration",
                style: TextStyle(
                  color: Color.fromARGB(255, 0, 72, 153),
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              Text(
                textAlign:TextAlign.center,
                "Veuillez introduire un URL valide du serveur",
                style: TextStyle(
                  color: Color.fromARGB(255, 75, 78, 82),
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment(0, 0.0),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Form(
                key: _urlFormfield,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.url,
                      controller: serverUrlController,
                      decoration: InputDecoration(
                        labelText: "URL Serveur",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(FontAwesomeIcons.globe),
                      ),
                      validator: (value) {
                        final bool urlValid = RegExp(
                                r"^https?:\/\/\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}:\d{1,5}$")
                            .hasMatch(value!);
                        if (value == "") {
                          return "Entrer un URL";
                        } else if (!urlValid) {
                          return "Entrer un URL Valide";
                        }
                      },
                    ),
                    SizedBox(height: 40),
                    ElevatedButton(
                      child: Text("Enregistrer",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      onPressed: () async {
                        if (_urlFormfield.currentState!.validate()) {
                       await Provider.of<AuthenticationProvider>(context,
                                  listen: false)
                              .setServerUrl(serverUrlController.text);
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LandingPage(),
                              ),
                              (route) => false);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(400, 50),
                        foregroundColor: Colors.white,
                        backgroundColor: Color.fromARGB(255, 0, 72, 153),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32.0),
                        ),
                      ),
                    )
                  ],
                )),
          ),
        )
      ]),
    );
  }
}
