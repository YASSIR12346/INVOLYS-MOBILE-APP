import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../Models/dataModel.dart';
import '../Services/formatNumber.dart';


List<PieChartSectionData> getSections(int touchedIndex, List<Data> data) {
  final double totalValue = data.map((d) => d.percent).reduce((a, b) => a + b);
  final double threshold = 0.05; 

  List<PieChartSectionData> sections = [];

  double otherValue = 0.0;
  Color otherColor = Colors.grey; 

  for (int index = 0; index < data.length; index++) {
    final dataPoint = data[index];
    final percent = dataPoint.percent / totalValue;

    if (percent >= threshold) {
      final isTouched = index == touchedIndex;
      final double fontSize = isTouched ? 15 : 10;
      final double radius = isTouched ? 60 : 40;

      final value = PieChartSectionData(
        color: isTouched ? dataPoint.colorOpac : dataPoint.color,
        value: dataPoint.percent,
        title: '${formatNumber(dataPoint.percent)}',
        titlePositionPercentageOffset: 0.55,
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: const Color(0xffffffff),
        ),
      );

      sections.add(value);
    } else {
      otherValue += dataPoint.percent; 
    }
  }

  if (otherValue > 0) {
    sections.add(PieChartSectionData(
      color: otherColor,
      value: otherValue,
      title: '${formatNumber(otherValue)}', 
      titlePositionPercentageOffset: 0.55,
      radius: 40,
      titleStyle: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.bold,
        color: const Color(0xffffffff),
      ),
    ));
  }

  return sections;
}

