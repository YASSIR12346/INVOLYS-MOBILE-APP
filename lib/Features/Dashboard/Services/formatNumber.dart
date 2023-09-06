import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

String formatNumber(double number) {
  String formatted = NumberFormat.decimalPattern().format(number);
  return formatted;
}


String translater(String value, BuildContext context) {
 switch(value){
   case "Building" :
     return AppLocalizations.of(context)!.building;
     break;
   case "Apartment" :
     return AppLocalizations.of(context)!.apartment;
     break;
   case "Land" :
     return AppLocalizations.of(context)!.land;
     break;
   default:
     return value;

 }
}
