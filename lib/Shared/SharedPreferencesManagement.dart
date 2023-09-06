import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesManagement {
  static SharedPreferences? preferences;

  static Future init() async {
    preferences = await SharedPreferences.getInstance();
  }

  static Future setLoginState(bool state) async {
    await preferences!.setBool('loginState', state);
  }

  static bool? getLoginState() {
    return preferences!.getBool('loginState');
  }

  static Future setInstallationState(bool state) async {
    await preferences!.setBool('installationState', state);
  }

  static bool? getInstallationState() {
    return preferences!.getBool('installationState');
  }

  static Future setNotificationsCount(String userId,int count) async {
    await preferences!.setInt('count'+userId, count);
  }

  static int? getNotificationsCount(String userId) {
    return preferences!.getInt('count'+userId);
  }

  static Future setNotifications(String userId,int nb) async {
    await preferences!.setInt('notifications'+userId, nb);
  }

  static int? getNotifications(String userId) {
    return preferences!.getInt('notifications'+userId);
  }

  static Future setToken(String token) async {
    await preferences!.setString('Token', token);
  }

  static String? getToken() {
    return preferences!.getString('Token');
  }

  static Future setUserId(String id) async {
    await preferences!.setString('UserId', id);
  }

  static String? getUserId() {
    return preferences!.getString('UserId');
  }

  static Future setSurname(String name) async {
    await preferences!.setString('Surname', name);
  }

  static String? getSurname() {
    return preferences!.getString('Surname');
  }
  static Future setName(String name) async {
    await preferences!.setString('Name', name);
  }

  static String? getName() {
    return preferences!.getString('Name');
  }

  static Future setServerUrl(String url) async {
    await preferences!.setString("ServerUrl", url);
  }

  static String? getServerUrl() {
    return preferences!.getString('ServerUrl');
  }


}
