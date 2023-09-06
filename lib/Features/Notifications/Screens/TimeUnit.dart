import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class TimeUnit extends StatelessWidget {

  final int number;
  const TimeUnit({required this.number,super.key});
  

  @override
  Widget build(BuildContext context) {
    List<String> units = [AppLocalizations.of(context)!.min,
    AppLocalizations.of(context)!.hour,AppLocalizations.of(context)!.day,
    AppLocalizations.of(context)!.week,
    AppLocalizations.of(context)!.month];
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Container(
        child: Center(child: Text(units[this.number],
        style:TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ))),
      ),
    );
  }
}
