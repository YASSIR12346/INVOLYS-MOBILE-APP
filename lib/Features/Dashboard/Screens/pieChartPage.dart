import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:involys_mobile_app/Features/Dashboard/Logic/pieChartSection.dart';

import '../Models/dataModel.dart';
import '../Logic/indicatorsWidget.dart';

class PieChartPage extends StatefulWidget {
  List<Data> dataPie;
  String title;
  PieChartPage({super.key, required this.dataPie,required this.title});


  @override

  State<StatefulWidget> createState() => PieChartPageState();
}

class PieChartPageState extends State<PieChartPage> {





  late int touchedIndex=-1;
  double deviceWidth(BuildContext context) => MediaQuery.of(context).size.width;



  @override
  Widget build(BuildContext context) => IntrinsicHeight(
    child: Container(
      color: Theme.of(context).colorScheme.onSecondary,
      child: Column(

        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20,bottom: 8,left: 8),
            child: Center(
              child: Text(
                textAlign: TextAlign.center,
                widget.title,
                style: TextStyle(
                  fontSize: 14,
                  // fontSize: widget.touchedIndex == index ? 12 : 10,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
              ),
            ),
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: deviceWidth(context) * 0.45,
                    child: Padding(
                      padding: const EdgeInsets.only(left:8, top: 40),
                      child: IndicatorsWidget(touchedIndex: touchedIndex, data: widget.dataPie ),
                    ),
                  ),
                ],
              ),
              SizedBox(
              width: deviceWidth(context) * 0.5,
                // width: 180,
                height: 200,
                child: PieChart(
                  PieChartData(
                    pieTouchData: PieTouchData(
                      touchCallback: (FlTouchEvent event, pieTouchResponse) {
                        setState(() {
                          if (!event.isInterestedForInteractions ||
                              pieTouchResponse == null ||
                              pieTouchResponse.touchedSection == null) {
                            touchedIndex = -1;

                            return;
                          }
                          touchedIndex = pieTouchResponse
                              .touchedSection!.touchedSectionIndex;


                        });
                      },
                    ),
                    borderData: FlBorderData(show: false),
                    sectionsSpace: 3,
                    centerSpaceRadius: 40,
                    sections: getSections(touchedIndex, widget.dataPie),
                  ),
                ),
              ),

            ],
          ),
        ],
      ),
    ),
  );
}
