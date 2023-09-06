import 'package:flutter/material.dart';
import 'package:involys_mobile_app/Features/Authentication/Logic/UserData.dart';
import '../../../Shared/SharedPreferencesManagement.dart';
import '../../../cache/cacheHelper.dart';
import '../Models/Notifications.dart';
import '../Services/NotificationService.dart';

class NotificationProvider extends ChangeNotifier {
  String urlServer="";
  DateTimeRange selectedDates =
      DateTimeRange(start: DateTime(2022, 09, 01), end: DateTime.now());
  bool high = true;
  bool medium = true;
  bool low = true;
  final NotificationService notificationService = NotificationService();
  Notifications? notifications;
  Notifications? results;
  bool isLoading = true;
  String status = '';
  bool alertflag=false;

  NotificationProvider() {
     urlServer=CacheData.getData(key: 'serverUrl')?? "";
     print("notification provider launched");
  }

  updateUrl(url){
     urlServer=url;
     notifyListeners();
  }
  
  getNotifications() async {   
    await SharedPreferencesManagement.init();
    await SharedPreferencesManagement.preferences!.reload();
    int count = SharedPreferencesManagement.getNotifications(UserData.UserId) ?? 0;
    try {
    
      isLoading = true;
      notifyListeners();
      notifications = await notificationService.getNotifications(urlServer);
      results = Notifications(
          notificationCount: notifications!.notificationCount,
          generatedAlerts: [...notifications!.generatedAlerts]);

      for (int nb = 0; nb < count && nb < results!.generatedAlerts.length; nb++) {
        results!.generatedAlerts[nb].viaApplication = true;
      }

      status = "success";
    } catch (e) {
  
      if (e.toString() == "Exception: You don't have any Notifications") {
        status = "You don't have any Notifications";
      } else if (e.toString() == "Exception: Failed To load Notifications") {
        status = "Failed To load Notifications";
      } else {
        status = "Network Error";
      }
    }
    isLoading = false;
    notifyListeners();
  }


  hideAlert(String id) async {
    String result=await notificationService.hideAlert(id,urlServer);
    return result;
  }

  readAlert(String id) async{
     String result=await notificationService.readAlert(id,urlServer);
     return result;
  }

  remindAlert(GeneratedAlert model) async {
     String result=await notificationService.remindAlert(model,urlServer);
     return result;
  }

  readAlertCorrected( String id){
    results = Notifications(
          notificationCount: notifications!.notificationCount,
          generatedAlerts: [...notifications!.generatedAlerts]);
    for(GeneratedAlert generatedAlert in results!.generatedAlerts){
      if(generatedAlert.id==id){
        generatedAlert.read=true;
      }
    }
    notifyListeners();

  }

  filter(high, medium, low, selectedDates) {
    List<int> priorities = [];
    (high) ? priorities.add(3) : null;
    (medium) ? priorities.add(2) : null;
    (low) ? priorities.add(1) : null;
    results!.generatedAlerts = notifications!.generatedAlerts
        .where((GeneratedAlert) =>
            GeneratedAlert.receivedDate.isBefore(selectedDates.end) &&
            GeneratedAlert.receivedDate.isAfter(selectedDates.start) &&
            priorities.contains(GeneratedAlert.alert.priorityLevel))
        .toList();
    notifyListeners();
  }

  search(String value) {
    if (value.isNotEmpty) {
      results!.generatedAlerts = notifications!.generatedAlerts
          .where((GeneratedAlert) => GeneratedAlert.alertText
              .toLowerCase()
              .contains(value.toLowerCase()))
          .toList();
    } else {
      results = Notifications(
          notificationCount: notifications!.notificationCount,
          generatedAlerts: [...notifications!.generatedAlerts]);
    }
    notifyListeners();
  }

  void changeHigh(bool value) {
    high = value;
    notifyListeners();
  }

  void changeMedium(bool value) {
    medium = value;
    notifyListeners();
  }

  void changeLow(bool value) {
    low = value;
    notifyListeners();
  }

  void changeSelectedDates(DateTimeRange value) {
    selectedDates = value;
    notifyListeners();
  }

  updateflag(bool flag){
    
      alertflag=flag;
      notifyListeners();
    
  }
}
