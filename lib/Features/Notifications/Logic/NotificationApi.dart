import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

class NotificationApi {
  static final _notifications = AwesomeNotifications();

  static Future init({bool initScheduled = false}) async {
    _notifications.initialize('resource://drawable/xxr', [
      NotificationChannel(
        channelGroupKey: 'basic_test',
        channelKey: 'basic_channel',
        channelName: 'Basic notifications',
        channelDescription: 'Notification channel for basic tests',
        channelShowBadge: false,
        importance: NotificationImportance.High,
        enableVibration: true,
        
      ),
    ]);
  }

  static Future showAlert({
    int? id,
    String? title,
    String? body,
    Map<String, String>? payload,
  }) async =>
      _notifications.createNotification(
          content: NotificationContent(
            id: id!,
            channelKey: 'basic_channel',
            title: title,
            body: body,
            payload: payload,
            autoDismissible: true,
            color: Colors.green,
            
          ));

  static Future showNotification({
    int? id,
    String? title,
    String? body,
    Map<String, String>? payload,
  }) async =>
      _notifications.createNotification(
        content: NotificationContent(
          id: id!,
          channelKey: 'basic_channel',
          title: title,
          body: body,
          payload: payload,
          autoDismissible: true,
          color: Colors.green,

        ),
      );
}
