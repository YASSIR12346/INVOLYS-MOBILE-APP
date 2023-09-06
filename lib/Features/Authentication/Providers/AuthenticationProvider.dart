import 'package:flutter/material.dart';
import 'package:involys_mobile_app/Features/Authentication/Models/LoginInputModel.dart';
import 'package:involys_mobile_app/Features/Authentication/Models/LoginResponseModel.dart';
import 'package:involys_mobile_app/Features/Authentication/Services/AuthenticationService.dart';
import 'package:involys_mobile_app/Shared/SharedPreferencesManagement.dart';
import 'package:involys_mobile_app/cache/cacheHelper.dart';
import '../Logic/UserData.dart';

class AuthenticationProvider extends ChangeNotifier {
  String urlServer="";
  final AuthenticationService notificationsService = AuthenticationService();
  LoginResponseModel? loginResponseModel;
  bool isLoggedIn = false;
  bool isLoading = false;
  String status = '';

  AuthenticationProvider(){
    print("authentication provider launched");
    urlServer=CacheData.getData(key: 'serverUrl')?? "";
  }
  Login(LoginInputModel loginInputModel) async {
    try {
      isLoading = true;
      notifyListeners();
      loginResponseModel = await AuthenticationService.login(loginInputModel,urlServer);
      await SharedPreferencesManagement.setLoginState(true);
      await SharedPreferencesManagement.setToken(loginResponseModel!.accessToken);
      await SharedPreferencesManagement.setUserId(loginResponseModel!.userId);
      await SharedPreferencesManagement.setSurname(loginResponseModel!.user.surname);
      await SharedPreferencesManagement.setName(loginResponseModel!.user.name);
      UserData.init(loginResponseModel!.accessToken,loginResponseModel!.userId,loginResponseModel!.user.surname,loginResponseModel!.user.name);
      isLoggedIn = true;
    } catch (e) {
     
      if (e.toString() == 'Exception: invalid credentials') {
        status = 'invalid credentials';
      } else if (e.toString() == 'Exception: Failed to Login') {
        status = 'Failed to Login';
      } else {
        status = 'Network Error';
      }
    }
    isLoading = false;
    notifyListeners();
  }

  Logout(){
    isLoggedIn = false;
    notifyListeners();
  }


   setServerUrl(String url ) async{
    print("authentication provider Updated");
     await SharedPreferencesManagement.setInstallationState(true);
     await SharedPreferencesManagement.setServerUrl(url);
     await CacheData.setData(key: 'serverUrl', value:url);
     urlServer=url;
     notifyListeners();

  }
}
