import 'package:flutter/material.dart';


class LoaderDialog {
  static Future<void> showLoadingDialog(
      BuildContext context, GlobalKey key) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
            key: key,
            backgroundColor: Colors.white,
            child: Container(
              width: 260.0,
              height: 260.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      "Loading...",
                      style: TextStyle(
                        color:Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 70,
                  ),
                  SizedBox(
                    width: 50,
                    height: 50,
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Color.fromARGB(255, 0, 72, 153),
                        strokeWidth: 5,
                      ),
                    ),
                  ),
                ],
              ),
            ));
      },
    );
  }
}
