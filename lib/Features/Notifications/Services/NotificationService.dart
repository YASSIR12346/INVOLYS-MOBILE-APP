import 'package:http/http.dart' as http;
import 'package:involys_mobile_app/Config/ApiConstants.dart';
import '../../Authentication/Logic/UserData.dart';
import '../Models/Notifications.dart';
import 'dart:async';
import 'dart:convert';

class NotificationService {
  Future<Notifications> getNotifications(url) async {
    final response = await http.get(
        Uri.parse(url + ApiConstants.NotificationsEndpoint),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ' + UserData.Token!,
        });
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      if (data["generatedAlerts"] == null) {
        throw Exception("You don't have any Notifications");
      } else {
        data = Notifications.fromJson(data);
        return data;
      }
    } else {
      throw Exception("Failed To load Notifications");
    }
  }

  Future<int> getNotificationsCount(token,url) async {
    int count = 0;
    try {
      final response = await http.get(
          Uri.parse(url + ApiConstants.NotificationsEndpoint),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ' + token,
          });
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data["generatedAlerts"] != null) {
          data = Notifications.fromJson(data);
          count = data.generatedAlerts.length;
        }
      }
      else{
        count=-1;
      }
    } catch (e) {
      count=-1;
    }
    return count;
  }

  Future<int> test()async{
    int count = 0;
    try{
    final response = await http.get(
        Uri.parse("https://apitestinvolys.000webhostapp.com"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          
        });
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      count=data["count"];
    }
    }
    catch(e){
      count=-1;
    }
   return count;
  }
  

  Future<List<GeneratedAlert>> getAlerts(token,url) async {
    try {
      final response = await http.get(
          Uri.parse(url + ApiConstants.AlertsEndpoint),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ' + token,
          });
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        data = data
            .map<GeneratedAlert>((x) => GeneratedAlert.fromJson(x))
            .toList();
        return data;
      }
    } catch (e) {}

    return [];
  }

  remindAlert(GeneratedAlert model,url) async {
    final response = await http.put(
        Uri.parse(url + ApiConstants.RemindEndpoint),
        body: json.encode(model.toJson()),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ' + UserData.Token!,
        });
    if (response.statusCode == 200) {
      return "You will be Reminded Soon";
    } else {
      return "Something went wrong";
    }
  }

  readAlert(String id,String url) async {
    final response = await http.put(
        Uri.parse(url + ApiConstants.ReadEndpoint + id),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ' + UserData.Token!,
        });
    if (response.statusCode == 200) {
      return "Alert is Readed";
    } else {
      return "Something went wrong";
    }
  }

  hideAlert(String id,url) async {
    final response = await http.put(
        Uri.parse(url + ApiConstants.HideEndpoint + id),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ' + UserData.Token!,
        });
    if (response.statusCode == 200) {
      return "Alert is Hidden";
    } else {
      return "Something went wrong";
    }
  }
}
