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
      padding: const EdgeInsets.only(top: 5, bottom: 5, left: 15, right: 15.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(7.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              offset: const Offset(0.0, 5.0),
              blurRadius: 30.0,
            ),
          ],
        ),
        child: ListTile(
          tileColor: Color(0xffFFFFFF),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              side: BorderSide(width: 0.5, color: Colors.white)),
          title: Text(
            s,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          onTap: onTap,
          trailing: const Icon(
            Icons.arrow_forward_ios_rounded,
            color: Colors.black,
          ),
        ),
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
              SizedBox(
                height: 31.0,
              ),
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
