import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
void ShowToast(String msg){
  Fluttertoast.showToast(msg: msg,
  toastLength: Toast.LENGTH_SHORT,
  backgroundColor: Colors.grey[800],
  fontSize: 16
  );
}