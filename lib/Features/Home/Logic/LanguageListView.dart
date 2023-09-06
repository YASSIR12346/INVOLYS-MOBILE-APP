import 'package:flutter/material.dart';
import 'package:involys_mobile_app/Features/Home/Provider/appProvider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LanguageListView extends StatefulWidget {
  @override
  _LanguageListViewState createState() => _LanguageListViewState();
}

class _LanguageListViewState extends State<LanguageListView> {
  late int _selectedLanguageIndex; // Declare as late
  List<Map<String, dynamic>> languages = [
    {'name': "english", 'locale': Locale('en')},
    {'name': "french", 'locale': Locale('fr')},
  ];



  @override
  void initState() {
    super.initState();
    final provider = Provider.of<AppProvider>(context, listen: false);

    _selectedLanguageIndex = languages.indexWhere(
          (language) => language['locale'] == provider.locale,
    );
  }


  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);
    final appLocalizations = AppLocalizations.of(context);

    languages = [
      {'name': appLocalizations!.english, 'locale': Locale('en')},
      {'name': appLocalizations.french, 'locale': Locale('fr')},
    ];

    return ListView.builder(
      shrinkWrap: true,
      itemCount: languages.length,
      itemBuilder: (context, index) {
        final language = languages[index];
        final isSelected = index == _selectedLanguageIndex;

        return ListTile(
          title: Row(
            children: [
              Icon(
                Icons.language,
                size: 24,
                color: isSelected ? Colors.blue : Theme.of(context).colorScheme.tertiary,
              ),
              SizedBox(width: 8),
              Text(
                language['name'],
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected ? Colors.blue : Theme.of(context).colorScheme.tertiary,
                ),
              ),
            ],
          ),
          trailing: isSelected ? Icon(Icons.check, color: Colors.blue) : null,
          onTap: () {

            setState(() {
              _selectedLanguageIndex = index;
            });

            provider.setLocale(language['locale']);
            provider.saveSelectedLanguage(language['locale']);


          },
        );
      },
    );
  }
}
