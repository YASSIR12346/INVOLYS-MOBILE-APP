import 'package:flutter/material.dart';

class TimeNumber extends StatelessWidget {

  final int number;
  const TimeNumber({required this.number,super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Container(
        child: Center(child: Text(number<10?'0'+number.toString():number.toString(),
        style:TextStyle(
          fontSize: 35,
          fontWeight: FontWeight.bold,
        ))),
      ),
    );
  }
}
