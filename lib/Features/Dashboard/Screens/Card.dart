
import 'package:flutter/material.dart';

import '../../../Shared/style.dart';
import '../Services/formatNumber.dart';



class InfoCard extends StatelessWidget {
  final Color colorTitle;
  final String label;
  final String value;
  final  Color color;

  InfoCard({required this.colorTitle, required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return  Container(


      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(0),
        color: Theme.of(context).colorScheme.onSecondary,

      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Icon(Icons.numbers, color: Color(0xff004899),),
          // ),
          SizedBox(height: 10,),
          Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    textAlign: TextAlign.center,

                    label,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                ),
                Divider(),
              ],
            ),
          ),


          SizedBox(
            height:20,
          ),
          Center(
            child: PrimaryText(
              text: formatNumber(double.parse(value)),
              size: 18,
              color: color,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 30,),
        ],
      ),);
  }
}