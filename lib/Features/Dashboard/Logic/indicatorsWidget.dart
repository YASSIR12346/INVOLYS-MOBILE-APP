import 'package:flutter/material.dart';

import '../Models/dataModel.dart';
import 'package:intl/intl.dart';

import '../Services/formatNumber.dart';

class IndicatorsWidget extends StatefulWidget {
  int touchedIndex;
  List<Data> data;
  IndicatorsWidget({super.key, required this.touchedIndex, required this.data});

  @override
  State<IndicatorsWidget> createState() => _IndicatorsWidgetState();
}

class _IndicatorsWidgetState extends State<IndicatorsWidget> {





  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: widget.data.asMap().entries.map((entry) {
      final int index = entry.key;
      final Data data = entry.value;

      return Container(
        padding: EdgeInsets.symmetric(vertical: 2),
        child: buildIndicator(
          color: widget.touchedIndex == index ? data.colorOpac :  data.color,
          text:  widget.touchedIndex == index ? '${translater(data.name,context)} : ${formatNumber(data.percent)}' :  translater(data.name,context) ,
          index: index,
        ),
      );
    }).toList(),
  );

  Widget buildIndicator({
    required Color color,
    required String text,
    required int index,
    bool isSquare = false,
    double size = 12,
    Color textColor = const Color(0xff505050),
  }) =>
      Row(
        children: <Widget>[
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
              color:color,
            ),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: widget.touchedIndex == index ? color : Theme.of(context).colorScheme.tertiary,
              ),
            ),
          )
        ],
      );
}
