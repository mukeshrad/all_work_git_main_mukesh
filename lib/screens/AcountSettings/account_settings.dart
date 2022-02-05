import 'package:finandy/screens/AcountSettings/language_Settings.dart';
import 'package:finandy/screens/AcountSettings/notifications_Settings.dart';
import 'package:finandy/utils/appBar.dart';
import 'package:flutter/material.dart';

class AccountSettings extends StatefulWidget {
  const AccountSettings({Key? key}) : super(key: key);

  @override
  _AccountSettingsState createState() => _AccountSettingsState();
}

class _AccountSettingsState extends State<AccountSettings> {
  menuOption(String s, {required VoidCallback onTap}) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 5),
      child: ListTile(
        tileColor: Colors.grey[200],
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            side: BorderSide(width: 0.5, color: Colors.white)),
        leading: Text(
          s,
          style: const TextStyle(
            fontSize: 17,
          ),
        ),
        onTap: onTap,
        trailing: const Icon(Icons.arrow_forward_ios_rounded),
      ),
    );
  }

  sendToscreen(var page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          child: Column(
            children: [
              const NewAppBar(pageName: 'Account Setting'),
              menuOption("Language", onTap: () {
                sendToscreen(const LanguageSettings());
              }),
              menuOption("Notifications", onTap: () {
                sendToscreen(const NotificationSettings());
              }),
            ],
          ),
        ),
      ),
    );
  }
}
