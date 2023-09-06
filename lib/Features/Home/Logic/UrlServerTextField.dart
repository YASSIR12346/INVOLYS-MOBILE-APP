import 'dart:async';

import 'package:flutter/material.dart';
import 'package:involys_mobile_app/Config/ApiConstants.dart';
import 'package:involys_mobile_app/Features/Notifications/Providers/NotificationProvider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../Shared/SharedPreferencesManagement.dart';
import '../../../cache/cacheHelper.dart';
import '../../Authentication/Logic/UserData.dart';
import '../../Dashboard/Provider/DashboardProvider.dart';
import '../Logic/loadingWidget.dart';
import '../Provider/appProvider.dart';
class UrlServerTextField extends StatefulWidget {

  @override
  _UrlServerTextFieldState createState() => _UrlServerTextFieldState();
}

class _UrlServerTextFieldState extends State<UrlServerTextField> {

  TextEditingController _controller = TextEditingController(text: '');
  Completer<void> _updateServerUrlCompleter = Completer<void>();
  bool isLoading=false;
  @override
  Widget build(BuildContext context) {
    final provider= Provider.of<DataNotifier>(context, listen: false);
    _controller = TextEditingController(text: provider.serverUrl);
    return isLoading ? Loading() : TextField(
      controller: _controller,
      decoration: InputDecoration(
        hintText: AppLocalizations.of(context)!.entrURL,
        suffixIcon: IconButton(
          icon: Icon(Icons.save),
          onPressed: () async {
            // Save the URL to a provider or somewhere else

            if (!_updateServerUrlCompleter.isCompleted) {
              _updateServerUrlCompleter.complete();
            }

            _updateServerUrlCompleter = Completer<void>();

            setState(() {
              isLoading=true;
            });

            try {
              await provider.checkServerUrl(_controller.text);
              if(provider.ServerError) {
                _controller.text=Provider.of<DataNotifier>(context, listen: false).serverUrl;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(AppLocalizations.of(context)!.noChangedURL),
                    duration: Duration(seconds: 3), // How long the Snackbar should be displayed
                  ),
                );

              } else {
                Provider.of<DataNotifier>(context, listen: false).serverUrl=_controller.text;
                Provider.of<NotificationProvider>(context, listen: false).updateUrl( _controller.text);
                CacheData.setData(key: 'serverUrl', value: _controller.text);
                await SharedPreferencesManagement.setServerUrl(_controller.text);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(AppLocalizations.of(context)!.changedURL),
                    duration: Duration(seconds: 3), // How long the Snackbar should be displayed
                  ),
                );


              }
            } catch (error) {
              // Handle any errors here
            } finally {
              setState(() {
                isLoading = false;
              });
            }




            print("URL Server: ${_controller.text}");
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _updateServerUrlCompleter.complete();
    _controller.dispose();
    super.dispose();
  }
}

