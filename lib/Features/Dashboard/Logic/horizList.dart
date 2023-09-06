
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Home/Provider/appProvider.dart';



Widget buildListItem(BuildContext context, int index, List<String> WIDGET) {
  double deviceWidth(BuildContext context) => MediaQuery.of(context).size.width;

  return IntrinsicHeight(
    child: Container(
      width: deviceWidth(context) * 0.80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Theme.of(context).colorScheme.primary,
      ),
      child: Row( 
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              Provider.of<AppProvider>(context, listen: false).jumpToIndex(index - 1,context);
            },
            icon: Icon(Icons.arrow_left),
            color: Colors.white,
          ),
          Expanded(
            child: Center(
              child: Text(
                WIDGET[index],
                textAlign: TextAlign.center,

                style: TextStyle(

                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              Provider.of<AppProvider>(context, listen: false).jumpToIndex(index + 1,context);
            },
            icon: Icon(Icons.arrow_right),
            color: Colors.white,
          ),
        ],
      ),
    ),
  );
}