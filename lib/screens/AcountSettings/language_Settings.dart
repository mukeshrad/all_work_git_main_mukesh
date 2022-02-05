import 'package:finandy/utils/appBar.dart';
import 'package:flutter/material.dart';

class LanguageSettings extends StatefulWidget {
  const LanguageSettings({Key? key}) : super(key: key);

  @override
  _LanguageSettingsState createState() => _LanguageSettingsState();
}

enum Language { English, Hindi }

class _LanguageSettingsState extends State<LanguageSettings> {
  Language _language = Language.English;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              NewAppBar(pageName: 'Language'),
              SizedBox(
                height: 29.0,
              ),
              buildTileWithRadio(tileName: 'English', val: Language.English),
              SizedBox(
                height: 10.0,
              ),
              buildTileWithRadio(tileName: 'Hindi', val: Language.Hindi),
            ],
          ),
        ),
      ),
    );
  }

  Container buildTileWithRadio(
      {required String tileName, required Language val}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(5.0),
      ),
      padding: EdgeInsets.only(
        top: 6.0,
        bottom: 6.0,
        left: 18.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            tileName,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          Radio<Language>(
            activeColor: Colors.black,
            value: val,
            groupValue: _language,
            onChanged: (value) {
              setState(() {
                _language = value!;
              });
            },
          ),
        ],
      ),
    );
  }
}
