

class Notifications {
  int notificationCount;
  List<GeneratedAlert> generatedAlerts;

  Notifications({
    required this.notificationCount,
    required this.generatedAlerts,
  });

  factory Notifications.fromJson(Map<String, dynamic> json) => Notifications(
        notificationCount: json["notificationCount"],
        generatedAlerts: json["generatedAlerts"]
            .map<GeneratedAlert>((x) => GeneratedAlert.fromJson(x))
            .toList(),
      );
}

class GeneratedAlert {
  String alertText;
  Alert alert;
  DateTime receivedDate;
  dynamic entityId;
  bool read;
  bool completed;
  bool hidden;
  bool remind;
  int remindedCount;
  int timeNumber;
  int timeUnit;
  dynamic user;
  bool viaApplication;
  bool viaEmail;
  bool viaSms;
  String id;

  GeneratedAlert({
    required this.alertText,
    required this.alert,
    required this.receivedDate,
    this.entityId,
    required this.read,
    required this.completed,
    required this.hidden,
    required this.remind,
    required this.remindedCount,
    required this.timeNumber,
    required this.timeUnit,
    this.user,
    required this.viaApplication,
    required this.viaEmail,
    required this.viaSms,
    required this.id,
  });

  factory GeneratedAlert.fromJson(Map<String, dynamic> json) => GeneratedAlert(
        alertText: json["alertText"],
        alert: Alert.fromJson(json["alert"]),
        receivedDate: DateTime.parse(json["receivedDate"]),
        entityId: json["entityId"],
        read: json["read"],
        completed: json["completed"],
        hidden: json["hidden"],
        remind: json["remind"],
        remindedCount: json["remindedCount"],
        timeNumber: json["timeNumber"],
        timeUnit: json["timeUnit"],
        user: json["user"],
        viaApplication: json["viaApplication"],
        viaEmail: json["viaEmail"],
        viaSms: json["viaSms"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "alertText": this.alertText,
        "alert": this.alert.toJson(),
        "receivedDate": this.receivedDate.toIso8601String(),
        "entityId": this.entityId,
        "read": this.read,
        "completed": this.completed,
        "hidden": this.hidden,
        "remind": this.remind,
        "remindedCount": this.remindedCount,
        "timeNumber": this.timeNumber,
        "timeUnit": this.timeUnit,
        "user": this.user,
        "viaApplication": this.viaApplication,
        "viaEmail": this.viaEmail,
        "viaSms": this.viaSms,
        "id": this.id,
      };
}

class Alert {
  String designation;
  int priorityLevel;
  bool showOldAlerts;
  dynamic screenName;
  dynamic screenUrl;
  dynamic company;
  dynamic activity;
  String id;

  Alert({
    required this.designation,
    required this.priorityLevel,
    required this.showOldAlerts,
    this.screenName,
    this.screenUrl,
    this.company,
    this.activity,
    required this.id,
  });

  factory Alert.fromJson(Map<String, dynamic> json) => Alert(
        designation: json["designation"],
        priorityLevel: json["priorityLevel"],
        showOldAlerts: json["showOldAlerts"],
        screenName: json["screenName"],
        screenUrl: json["screenUrl"],
        company: json["company"],
        activity: json["activity"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "designation": this.designation,
        "priorityLevel": this.priorityLevel,
        "showOldAlerts": this.showOldAlerts,
        "screenName": this.screenName,
        "screenUrl": this.screenUrl,
        "company": this.company,
        "activity": this.activity,
        "id": this.id,
      };
}
