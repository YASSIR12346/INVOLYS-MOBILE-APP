import 'package:involys_mobile_app/Features/Authentication/Models/User.dart';

class ApiConstants{

   static const String LoginEndpoint="/console/SecurityApi/account/MobileLogin";

   static const String Dashboard="/DashboardApi/api/v1/Dashboards/";

   static  const String NotificationsEndpoint = '/NotificationsApi/api/v1/notifications/GeneratedAlerts/Notifications/1000';
  
   static const String RemindEndpoint="/NotificationsApi/api/v1/notifications/GeneratedAlerts/Remind";
   
   static const String HideEndpoint="/NotificationsApi/api/v1/notifications/GeneratedAlerts/Hide/";

   static const String AlertsEndpoint="/NotificationsApi/api/v1/notifications/GeneratedAlerts/RemindedAlerts";
   
   static const String ReadEndpoint="/NotificationsApi/api/v1/notifications/GeneratedAlerts/Read/";


}  
