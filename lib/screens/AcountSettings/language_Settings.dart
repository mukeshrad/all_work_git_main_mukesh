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
              const NewAppBar(pageName: 'Language'),
              const SizedBox(
                height: 31.0,
              ),
              buildTileWithRadio(tileName: 'English', val: Language.English),
              const SizedBox(
                height: 10.0,
              ),
              buildTileWithRadio(tileName: 'Hindi', val: Language.Hindi),
            ],
          ),
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text(
        "OK",
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      alignment: Alignment.center,
      title: Center(child: const Text("Hindi not Available")),
      content: const Text(
          "This feature is curently under development.\nSorry for the inconveniences!"),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  InkWell buildTileWithRadio(
      {required String tileName, required Language val}) {
    return InkWell(
      onTap: () {
        if (tileName == 'Hindi') {
          print('b');
          showAlertDialog(context);
        } else {
          print('a');
          setState(() {
            _language = Language.English;
          });
        }
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 15.0),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey.shade300,
          ),
          borderRadius: BorderRadius.circular(5.0),
        ),
        padding: const EdgeInsets.only(
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
              activeColor: Color(0xffDD2E44),
              value: val,
              groupValue: _language,
              onChanged: (value) {
                if (value == Language.Hindi) {
                  print('b');
                  showAlertDialog(context);
                } else {
                  print('a');
                  setState(() {
                    _language = value!;
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
