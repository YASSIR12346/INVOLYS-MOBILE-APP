import 'dart:async';
import 'package:involys_mobile_app/Features/Authentication/Screens/ServerUrlSettings.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'dart:convert';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:involys_mobile_app/Features/Authentication/Providers/AuthenticationProvider.dart';
import 'package:involys_mobile_app/Features/Authentication/Screens/LandingPage.dart';
import 'package:involys_mobile_app/Features/Notifications/Logic/NotificationApi.dart';
import 'package:involys_mobile_app/Features/Notifications/Models/Notifications.dart';
import 'package:involys_mobile_app/Features/Notifications/Providers/NotificationProvider.dart';
import 'package:involys_mobile_app/Features/Notifications/Services/NotificationService.dart';
import 'package:involys_mobile_app/Shared/SharedPreferencesManagement.dart';
import 'package:provider/provider.dart';
import 'dart:ui';
import 'Features/Authentication/Logic/UserData.dart';
import 'Features/Dashboard/Provider/DashboardProvider.dart';
import 'Features/Home/Provider/appProvider.dart';
import 'Features/Dashboard/Services/api_service.dart';
import 'Features/Home/Screens/pageController.dart';
import 'cache/cacheHelper.dart';
import 'l10n/l10n.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
void main() async {
  print("main");
  WidgetsFlutterBinding.ensureInitialized();
  await Future.delayed(const Duration(seconds: 1));
  FlutterNativeSplash.remove();
  AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
  if (!isAllowed) {
    AwesomeNotifications().requestPermissionToSendNotifications();
  }
});
  await SharedPreferencesManagement.init();
  await CacheData.cacheInitialization();
  bool isLoggedIn = await SharedPreferencesManagement.getLoginState() ?? false;
  bool isInstalled = await SharedPreferencesManagement.getInstallationState() ?? false;
  if(isLoggedIn){
    String token=await SharedPreferencesManagement.getToken()?? "none";
    String userId=await SharedPreferencesManagement.getUserId()?? "none";
    String surname=await SharedPreferencesManagement.getSurname()?? "none";
    String name=await SharedPreferencesManagement.getName()?? "none";
    UserData.init(token,userId,surname,name);
  }
  await initializeBackgroundService();
  var defaultRoot = !isInstalled ? ServerUrlSettings():isLoggedIn? Home() : LandingPage();
  runApp(MultiProvider(
    providers: [
       ChangeNotifierProvider<NotificationProvider>(
            create: (_) => NotificationProvider()),
       ChangeNotifierProvider<AuthenticationProvider>(
            create: (_) => AuthenticationProvider()),
      ChangeNotifierProvider<AppProvider>(
        create: (context) => AppProvider(),
      ),
      ChangeNotifierProvider<DataNotifier>(
        create: (context) => DataNotifier(ApiService()),
      ),


    ],
    child:MyApp(defaultRoot: defaultRoot),
  ));
}


class MyApp extends StatefulWidget {
  final  defaultRoot;
  const MyApp({super.key, this.defaultRoot });
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {

    final themeProvider= Provider.of<AppProvider>(context);
    return  MaterialApp(
      debugShowCheckedModeBanner: false,

      themeMode: themeProvider.themeMode,
      theme: MyThemes.lightTheme,
      darkTheme: MyThemes.darkTheme,
      supportedLocales: L10n.all,
      locale: themeProvider.locale,
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      home: widget.defaultRoot,

    );
  }
}




Future<void> initializeBackgroundService() async {
  final service = FlutterBackgroundService();
  await service.configure(
    androidConfiguration: AndroidConfiguration(
      onStart: onStart,
      autoStart: true,
      isForegroundMode: true,
    ),
    iosConfiguration: IosConfiguration(
      autoStart: true,
      onForeground: onStart,
    ),
  );
  await service.startService();
}

@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  DartPluginRegistrant.ensureInitialized();
  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) {
      service.setAsForegroundService();
    });
    service.on('setAsBackground').listen((event) {
      service.setAsBackgroundService();
    });
    service.on('stopService').listen((event) {
      service.stopSelf();
    });
    
    NotificationService notificationService = NotificationService();
    Timer.periodic(const Duration(seconds: 35), (timer) async {
      print("start background");
      await SharedPreferencesManagement.init();
      await SharedPreferencesManagement.preferences!.reload();
      bool isLoggedIn =
          await SharedPreferencesManagement.getLoginState() ?? false;
      String url=await SharedPreferencesManagement.getServerUrl()?? "";
      print(url);
      String token = await  SharedPreferencesManagement.getToken()?? "";
      String userId=await SharedPreferencesManagement.getUserId()?? "none";
      int sharedNotificationsCount=await SharedPreferencesManagement.getNotificationsCount(userId) ?? -1;
      int notifications=await SharedPreferencesManagement.getNotifications(userId) ?? 0;
      int NotificationsCount = await notificationService.getNotificationsCount(token, url);
      List<GeneratedAlert> alerts = await notificationService.getAlerts(token,url);
      if(sharedNotificationsCount>-1 && isLoggedIn){
        if(NotificationsCount>sharedNotificationsCount){
          NotificationApi.showNotification(
            id: 666666,
            title: "Notifications",
            body: "Vous avez de nouvelles notifications",
            payload: {"type":"notifications"},
          );
          if(notifications>0){
            await SharedPreferencesManagement.setNotifications(userId,NotificationsCount-sharedNotificationsCount+notifications);
            FlutterAppBadger.updateBadgeCount(NotificationsCount-sharedNotificationsCount+notifications);
          }else{
             await SharedPreferencesManagement.setNotifications(userId,NotificationsCount-sharedNotificationsCount);
               FlutterAppBadger.updateBadgeCount(NotificationsCount-sharedNotificationsCount);
          }
        }
      }
      if(NotificationsCount!=-1 && isLoggedIn){
         await SharedPreferencesManagement.setNotificationsCount(userId,NotificationsCount);
         print("from background updated "+NotificationsCount.toString());
      }


      if (alerts.length >= 1 && isLoggedIn) {
        int id = 0;
        for (var generatedAlert in alerts) {
          id = id + 1;
          NotificationApi.showAlert(
            id: id,
            title: "Notification",
            body: generatedAlert.alertText,
            payload: {"id": generatedAlert.id, "type": "alert","body":json.encode(generatedAlert.toJson())},
          );
          await Future.delayed(const Duration(milliseconds: 1000));
        }
      }
      print("end background");
    });
  }
  
}


