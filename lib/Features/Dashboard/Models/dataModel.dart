import 'package:flutter/material.dart';



class Data {
  final String name;

  final double percent;

  final Color color;
  final Color colorOpac;

  Data({required this.name, required this.percent, required this.color,  required this.colorOpac});
}
class grapheModel {
  final List<List<Data>> grapheData;
  final List<String> titleData;
  final List<dynamic> typesData;

  grapheModel({
    required this.grapheData,
    required this.titleData,
    required this.typesData,
  });
}


class companyModel {
  final String name;
  final String id;
  companyModel({required this.name, required this.id});
}

class Event {
  final String title;
  final String taskStatus;
  final String start;
  final String end;
  final String taskType;
  final String taskResponsible;
  final List<String> taskInterventionPeople;
  Event({required this.title,required this.taskStatus,required this.taskType,required this.taskResponsible,required this.taskInterventionPeople,required this.start,required this.end});

}




















