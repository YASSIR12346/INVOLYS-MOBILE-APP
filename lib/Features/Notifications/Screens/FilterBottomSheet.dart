import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:involys_mobile_app/Features/Home/Provider/appProvider.dart';
import 'package:involys_mobile_app/Features/Notifications/Providers/NotificationProvider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FilterBottomSheet extends StatefulWidget {
  final NotificationProvider notificationProvider;
  const FilterBottomSheet({super.key, required this.notificationProvider});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Consumer<NotificationProvider>(builder: (context, value, child) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
              height: 50,
              child: Stack(children: [
                Align(
                  alignment: Alignment(-0.90, 0),
                  child: Icon(
                    FontAwesomeIcons.filter,
                    color: Provider.of<AppProvider>(context, listen: false)
                            .isDarkMode
                        ? Colors.white
                        : Colors.black,
                    size: 27,
                  ),
                ),
                Align(
                  alignment: Alignment(-0.5, 0),
                  child: Text(
                    AppLocalizations.of(context)!.filter,
                    style: TextStyle(
                      color: Provider.of<AppProvider>(context, listen: false)
                              .isDarkMode
                          ? Colors.white
                          : Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ])),
          const SizedBox(height: 10),
          ExpansionTile(
            title: Text(AppLocalizations.of(context)!.priority,
                style: TextStyle(
                  fontSize: 18,
                )),
            children: [
              Column(
                children: [
                  CheckboxListTile(
                    checkboxShape: CircleBorder(),
                    value: value.high,
                    title: Text(
                      AppLocalizations.of(context)!.high,
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    activeColor: Colors.red,
                    controlAffinity: ListTileControlAffinity.leading,
                    onChanged: (newValue) {
                      widget.notificationProvider.changeHigh(newValue!);
                    },
                  ),
                  CheckboxListTile(
                    checkboxShape: CircleBorder(),
                    value: value.medium,
                    title: Text(
                      AppLocalizations.of(context)!.medium,
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    activeColor: Colors.yellow,
                    controlAffinity: ListTileControlAffinity.leading,
                    onChanged: (newValue) {
                      widget.notificationProvider.changeMedium(newValue!);
                    },
                  ),
                  CheckboxListTile(
                    checkboxShape: CircleBorder(),
                    value: value.low,
                    title: Text(
                      AppLocalizations.of(context)!.low,
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    activeColor: Colors.green,
                    controlAffinity: ListTileControlAffinity.leading,
                    onChanged: (newValue) {
                      widget.notificationProvider.changeLow(newValue!);
                    },
                  ),
                ],
              )
            ],
          ),
          ExpansionTile(
              title: Text(AppLocalizations.of(context)!.date,
                  style: TextStyle(
                    fontSize: 18,
                  )),
              children: [
                Container(
                    height: 120,
                    child: Stack(children: [
                      Align(
                        alignment: Alignment(-0.93, -0.9),
                        child: Icon(
                          FontAwesomeIcons.calendarDays,
                          color: Color.fromARGB(255, 0, 99, 211),
                          size: 50,
                        ),
                      ),
                      Align(
                          alignment: Alignment(-0.50, -0.9),
                          child: Text(
                            AppLocalizations.of(context)!.fromDate,
                            style: TextStyle(
                              color: Color.fromARGB(255, 94, 148, 210),
                              fontSize: 16,
                            ),
                          )),
                      Align(
                          alignment: Alignment(-0.50, -0.4),
                          child: Text(
                            '${value.selectedDates.start.year}/${value.selectedDates.start.month}/${value.selectedDates.start.day}',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                      Align(
                        alignment: Alignment(0.93, -0.9),
                        child: Icon(
                          FontAwesomeIcons.calendarDays,
                          color: Color.fromARGB(255, 0, 99, 211),
                          size: 50,
                        ),
                      ),
                      Align(
                          alignment: Alignment(0.50, -0.9),
                          child: Text(
                            AppLocalizations.of(context)!.toDate,
                            style: TextStyle(
                              color: Color.fromARGB(255, 94, 148, 210),
                              fontSize: 16,
                            ),
                          )),
                      Align(
                          alignment: Alignment(0.50, -0.4),
                          child: Text(
                            '${value.selectedDates.end.year}/${value.selectedDates.end.month}/${value.selectedDates.end.day}',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Color.fromARGB(255, 0, 153, 74),
                              fixedSize: Size(120, 35),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(32.0),
                              ),
                            ),
                            onPressed: () async {
                              final DateTimeRange? picked =
                                  await showDateRangePicker(
                                      context: context,
                                      firstDate: DateTime(2020),
                                      lastDate: DateTime(2024),
                                      builder: (context, Widget? child) =>
                                          Theme(
                                            data: ThemeData.light().copyWith(
                                                colorScheme: ColorScheme.light(
                                              onPrimary: Colors.white,
                                              primary: Color.fromARGB(
                                                  255, 0, 72, 153),
                                            )),
                                            child: child!,
                                          ));

                              if (picked != null) {
                                widget.notificationProvider
                                    .changeSelectedDates(picked);
                              }
                            },
                            child:
                                Text(AppLocalizations.of(context)!.selectDate)),
                      ),
                    ])),
              ]),
          const SizedBox(height: 10),
          Center(
            child: ElevatedButton(
              onPressed: () {
                widget.notificationProvider.filter(
                    value.high, value.medium, value.low, value.selectedDates);
              },
              child: Text(AppLocalizations.of(context)!.applyFilters,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(200, 40),
                foregroundColor: Colors.white,
                backgroundColor: Color.fromARGB(255, 0, 72, 153),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0),
                ),
              ),
            ),
          ),
          const SizedBox(height: 9)
        ],
      );
    });
  }
}
