import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:involys_mobile_app/Features/Authentication/Models/LoginInputModel.dart';
import 'package:involys_mobile_app/Features/Authentication/Screens/NetworkErrorPage.dart';
import 'package:involys_mobile_app/Features/Dashboard/Provider/DashboardProvider.dart';
import 'package:involys_mobile_app/Features/Home/Provider/appProvider.dart';
import 'package:involys_mobile_app/Features/Home/Screens/pageController.dart';
import 'package:provider/provider.dart';
import '../../../Shared/LoaderDialog.dart';
import '../../../Shared/Toasts.dart';
import '../Providers/AuthenticationProvider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  @override
  void initState() {
    super.initState();
  }

  final _formfield = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final GlobalKey<State> _LoaderDialog = new GlobalKey<State>();
  bool passToggle = true;

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
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
              Navigator.pop(context);
            },
          ),
        ),
        Align(
          alignment: Alignment(0, -0.6),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppLocalizations.of(context)!.titleThree,
                style: TextStyle(
                  color: Color.fromARGB(255, 0, 72, 153),
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              Text(
                AppLocalizations.of(context)!.titleFour,
                style: TextStyle(
                  color: Color.fromARGB(255, 75, 78, 82),
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 30),
        Align(
            alignment: Alignment(0, 0.1),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Form(
                  key: _formfield,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                        decoration: InputDecoration(
                          labelText: "Login",
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.email),
                        ),
                        validator: (value) {
                          if (value=="") {
                            return "Enter Login";
                          } 
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                          keyboardType: TextInputType.visiblePassword,
                          controller: passwordController,
                          obscureText: passToggle,
                          decoration: InputDecoration(
                            labelText: AppLocalizations.of(context)!.password,
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.lock),
                            suffix: InkWell(
                              onTap: () {
                                setState(() {
                                  passToggle = !passToggle;
                                });
                              },
                              child: Icon(passToggle
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter Password";
                            } else if (passwordController.text.length < 3) {
                              return "Password must be at least 3 characters";
                            }
                          }),
                      SizedBox(height: 40),
                      ElevatedButton(
                        child: Text(AppLocalizations.of(context)!.login,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        onPressed: () async {
                          if (_formfield.currentState!.validate()) {
                            LoaderDialog.showLoadingDialog(
                                context, _LoaderDialog);
                            
                            await Provider.of<AuthenticationProvider>(context,
                                    listen: false)
                                .Login(LoginInputModel(
                              Login: emailController.text,
                              Password: passwordController.text,
                            ));
                            try{
                            Navigator.of(_LoaderDialog.currentContext!,
                                    rootNavigator: true)
                                .pop();
                            }
                            catch(e){
                              
                            }
                            if (Provider.of<AuthenticationProvider>(context,
                                    listen: false)
                                .isLoggedIn) {
                              Provider.of<AppProvider>(context,listen:false).updateLocale();
                              Provider.of<DataNotifier>(context,listen:false).update();
                              ShowToast("Logged In Successfully");
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Home(),
                                  ),
                                  (route) => false);
                            } else {
                              if (Provider.of<AuthenticationProvider>(context,
                                          listen: false)
                                      .status ==
                                  "Network Error") {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) {
                                  return NetworkErrorPage();
                                }));
                              } else {
                                ShowToast(Provider.of<AuthenticationProvider>(
                                        context,
                                        listen: false)
                                    .status);
                              }
                            }
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
            ))
      ]),
    );
  }
}
