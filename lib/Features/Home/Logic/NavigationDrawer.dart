import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:involys_mobile_app/Features/Authentication/Logic/UserData.dart';
import 'package:involys_mobile_app/Features/Authentication/Providers/AuthenticationProvider.dart';
import 'package:involys_mobile_app/Features/Authentication/Screens/LandingPage.dart';
import 'package:involys_mobile_app/Shared/LoaderDialog.dart';
import 'package:involys_mobile_app/Shared/SharedPreferencesManagement.dart';
import 'package:involys_mobile_app/Shared/Toasts.dart';
import 'package:involys_mobile_app/Shared/size_config.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:rate_my_app/rate_my_app.dart';

import '../../Dashboard/Provider/DashboardProvider.dart';
import '../Provider/appProvider.dart';


class NavigationDrawerC extends StatefulWidget {

  final RateMyApp rateMyApp;

  const NavigationDrawerC({
    Key? key,
    required this.rateMyApp,
  }) : super(key: key);


  @override
  State<NavigationDrawerC> createState() => _NavigationDrawerCState();
}

class _NavigationDrawerCState extends State<NavigationDrawerC> {
  final GlobalKey<State> _LoaderDialog = new GlobalKey<State>();
  late double iconSize;
  late double containerIconSize;
  @override
  Widget build(BuildContext context)
      {
        

        SizeConfig().init(context);
        iconSize= SizeConfig.screenWidth * 0.055;
        containerIconSize= SizeConfig.screenWidth * 0.1;
        return Drawer(
          child: Material(
            color: Theme.of(context).colorScheme.primary,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  buildHeader(context),
                  buildMenuItems(context),
                ],
              ),
            ),
          ),
        );
      }

  Widget buildHeader(BuildContext context) => Material(
    color: Theme.of(context).colorScheme.primary,
    child: InkWell(
      onTap: () {},
      child:   ClipPath(
        child: Container(

          width: SizeConfig.screenWidth * 0.2,
          height: SizeConfig.screenHeight * 0.35,
          decoration: BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
              image: AssetImage('assets/logo-involys-header.png'),
              fit: BoxFit.contain,
            ),
          ),
        )
        ,
        clipper: customClipper(),
      ),
    ),
  );

  Widget buildMenuItems(BuildContext context) => Container(
    color: Theme.of(context).colorScheme.primary,
    padding: const EdgeInsets.only(left: 15, right: 15, bottom: 24),
    child:   Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,

      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [

            Text(UserData.Surname+" "+UserData.Name ,style: TextStyle(
              fontSize: 12 * SizeConfig.textScale,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
            ),),
            CircleAvatar(radius:SizeConfig.screenWidth * 0.105 ,backgroundImage: AssetImage("assets/userIcon.png"),),

          ],
        ),
        SizedBox(height: SizeConfig.screenWidth * 0.02,),
        Divider(color: Colors.white,),
        SizedBox(height: SizeConfig.screenWidth * 0.1,),
        Wrap(

          runSpacing: SizeConfig.screenHeight * 0.01,

          children: [

            ListTile(
              textColor: Colors.white,

              leading:  Container(
                width: containerIconSize,
                height: containerIconSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: Icon(
                  Icons.home,
                  size: iconSize,
                  color: Color(0xffFCAD3E),
                ),
              )
              ,

              title:  Text(AppLocalizations.of(context)!.home),

              onTap: () async {
                Navigator.pop(context);
                Provider.of<DataNotifier>(context, listen: false).widgetName="-1";
                Provider.of<AppProvider>(context, listen: false).indexB=0;

              },

            ),
            ListTile(
              textColor: Colors.white,

              leading:  Container(
                width: containerIconSize,
                height: containerIconSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: Icon(
                  Icons.notifications,
                  size: iconSize,
                  color: CupertinoColors.destructiveRed,
                ),
              )
              ,

              title:  Text(AppLocalizations.of(context)!.notifications),

              onTap: (){
                Navigator.pop(context);
                Provider.of<AppProvider>(context, listen: false).indexB=1;


              },

            ),
            ListTile(
              textColor: Colors.white,

              leading:  Container(
                width: containerIconSize,
                height: containerIconSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: Icon(
                  Icons.settings,
                  size: iconSize,
                  color: Color(0xff61A7F9),
                ),
              )
              ,

              title:  Text(AppLocalizations.of(context)!.settings),

              onTap:  () =>
              {
              Navigator.pop(context),
              Provider.of<AppProvider>(context, listen: false).indexB=3,


                        }),
            ListTile(
              textColor: Colors.white,

              leading:  Container(
                width: containerIconSize,
                height: containerIconSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: Icon(
                  Icons.star,
                  size: iconSize,
                  color: Color(0xffFCD403),
                ),
              )
              ,

              title:  Text(AppLocalizations.of(context)!.rating,
              ),

              onTap:  () => widget.rateMyApp.showStarRateDialog(
                      context,
                      title: AppLocalizations.of(context)!.ratingTitle,
                      message: AppLocalizations.of(context)!.ratingText,
                      starRatingOptions: StarRatingOptions(initialRating: 4),
                      actionsBuilder: actionsBuilder,
  ),

            ),
            ListTile(
              textColor: Colors.white,

              leading:  Container(
                width: containerIconSize,
                height: containerIconSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: Icon(
                  Icons.logout,
                  size: iconSize,
                  color: Color(0xffFF630B),
                ),
              )
              ,

              title:  Text(AppLocalizations.of(context)!.logout),
              onTap: () async{
                LoaderDialog.showLoadingDialog(
                                context, _LoaderDialog);
                 await SharedPreferencesManagement.init();
                 await SharedPreferencesManagement.preferences!.reload();
                 await SharedPreferencesManagement.setLoginState(false);
                 Provider.of<AuthenticationProvider>(context,
                                    listen: false)
                                .Logout();
                
                 await Future.delayed(const Duration(seconds: 1));
                Navigator.of(_LoaderDialog.currentContext!,
                                    rootNavigator: true)
                                .pop();
                Provider.of<AppProvider>(context, listen: false).indexB=0;
                ShowToast("Logged out  Successfully");
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LandingPage(),
                                  ),
                                  (route) => false);
              },

            ),






          ],

        ),
      ],
    ),
  );

  List<Widget> actionsBuilder(BuildContext context, double? stars) =>
      stars == null
          ? [buildCancelButton()]
          : [buildOkButton(stars), buildCancelButton()];

  Widget buildOkButton(double stars) => TextButton(
    child: Text(AppLocalizations.of(context)!.ok, style: TextStyle(color: Theme.of(context).colorScheme.primaryContainer ),),
    onPressed: () async {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.thanFeed)),
      );

      final launchAppStore = stars >= 4;

      final event = RateMyAppEventType.rateButtonPressed;

      await widget.rateMyApp.callEvent(event);

      if (launchAppStore) {
        widget.rateMyApp.launchStore();
      }

      Navigator.of(context).pop();
    },
  );

  Widget buildCancelButton() => RateMyAppNoButton(
    widget.rateMyApp,
    text: AppLocalizations.of(context)!.cancel,
  );

}



class customClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    Path path= Path();
    path.lineTo(0, size.height / 1.6);
    path.cubicTo(size.width/4, 3* (size.height/2), 3* (size.width/4), size.height/2, size.width, size.height*0.9);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
   return true;
  }

}
