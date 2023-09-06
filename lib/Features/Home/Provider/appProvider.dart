import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:involys_mobile_app/Config/ApiConstants.dart';
import 'package:involys_mobile_app/Features/Authentication/Logic/UserData.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../cache/cacheHelper.dart';
import '../../Dashboard/Provider/DashboardProvider.dart';

class AppProvider extends ChangeNotifier {
  //Bottom Bar navigation
  int _indexB=0;
  int get indexB => _indexB;

  set indexB(int newIndex) {
    _indexB = newIndex;
    notifyListeners();
  }

  //Theme

  ThemeMode themeMode = ThemeMode.system;

  bool get isDarkMode {
    if (themeMode == ThemeMode.system) {
      final brightness = SchedulerBinding.instance.window.platformBrightness;
      return brightness == Brightness.dark;
    } else {
      return themeMode == ThemeMode.dark;
    }
  }



  void toggleTheme() {
    themeMode = themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();
  }

  //Language
  Locale _locale= Locale('fr');
  AppProvider() {
     _locale = (CacheData.getData(key: 'selectedLanguage'+UserData.UserId!) ?? 'fr') == 'en' ? Locale('en') : Locale('fr');
     print("app  provider launched");
  }

  Locale get locale => _locale;


  void updateLocale(){
     _locale = (CacheData.getData(key: 'selectedLanguage'+UserData.UserId!) ?? 'fr') == 'en' ? Locale('en') : Locale('fr');
     notifyListeners();
  }

  void setLocale(Locale newLocale) {
    _locale = newLocale;
    notifyListeners();
  }
  //

  void saveSelectedLanguage(Locale locale) {
    String languageCode = locale.languageCode;
    CacheData.setData(key: 'selectedLanguage'+UserData.UserId!, value: languageCode);
  }




  //Search Delegate

  var itemController = ItemScrollController();
  Future scrollToItem(int titleIndex) async{
    itemController.scrollTo(index: titleIndex, duration: Duration(milliseconds: 1000));

  }


  //Horizantal List Jump

  ScrollController _listController = ScrollController();

  int _INDEX=0;
  int get INDEX => _INDEX;
  ScrollController get listController => _listController;

  set listController(ScrollController newName) {
    _listController = newName;
    notifyListeners();
  }




  void jumpToIndex(int desiredIndex, BuildContext context) {
    double deviceWidth(BuildContext context) => MediaQuery.of(context).size.width;
    final provider = context.read<DataNotifier>();
    int circularIndex = provider.widgets.isNotEmpty
        ? (desiredIndex % provider.widgets.length).toInt()
        : 0;
    int extendedIndex = circularIndex + provider.widgets.length * 50;

    double itemSize = deviceWidth(context) * 0.80;
    double scrollOffset = itemSize * extendedIndex;

    _listController.jumpTo(scrollOffset);

    notifyListeners();
  }


}

class MyThemes {
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Color(0xff15202E),
    primaryColor: Colors.black,
    colorScheme: ColorScheme.dark(
      primary: Color(0xff182F4F), // Custom dark mode color
      onPrimary: Color(0xffDDDDDD),
      secondary: Color(0xff2673DD),
      onSecondary: Color(0xff182F4F),
      tertiary: Color(0xffDDDDDD),
      onTertiary: Color(0xff182F4F),
      primaryContainer: Color(0xff2673DD),
    ),
  );

  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Colors.white,
    colorScheme: ColorScheme.light(
      primary: Color(0xff004899), // curved
      primaryContainer: Color(0xff004899),
      onPrimary: Color(0xff004899),
      secondary: Colors.white, // icons
      onSecondary: Color(0x7fD3D3D3), // bg Graphes
      tertiary: Colors.black, //title
      onTertiary: Colors.white,

    ),

  );
}
