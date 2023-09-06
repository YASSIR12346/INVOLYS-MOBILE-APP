import 'package:http/http.dart' as http;
import 'package:involys_mobile_app/Config/ApiConstants.dart';
import 'package:involys_mobile_app/Features/Authentication/Models/LoginInputModel.dart';
import 'dart:async';
import 'dart:convert';
import 'package:involys_mobile_app/Features/Authentication/Models/LoginResponseModel.dart';

class AuthenticationService{

  static Future<LoginResponseModel> login(LoginInputModel model,String url) async {
    final response = await http.get(
        Uri.parse(
            url+ApiConstants.LoginEndpoint+"?Login=${model.Login}&Password=${model.Password}"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        });
    
     if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      data = LoginResponseModel.fromJson(data);
      return data;
    } else if (response.statusCode == 204 || response.statusCode == 405) {
      throw Exception('invalid credentials');
    } else {
      throw Exception('Failed to Login');
    }
  }
}

  

