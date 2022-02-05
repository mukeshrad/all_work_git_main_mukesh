import 'package:finandy/utils/appBar.dart';
import 'package:flutter/material.dart';

class NotificationSettings extends StatefulWidget {
  const NotificationSettings({Key? key}) : super(key: key);

  @override
  _NotificationSettingsState createState() => _NotificationSettingsState();
}

class _NotificationSettingsState extends State<NotificationSettings> {
  bool isSMS = false;
  bool isPush = false;
  bool isWhatsApp = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const NewAppBar(pageName: 'Notification Settings'),
              const SizedBox(
                height: 29.0,
              ),
              buildTileWithSwitch(
                tileName: 'SMS',
                isSwitched: isSMS,
                setValue: _setSMSValue,
              ),
              const SizedBox(
                height: 10.0,
              ),
              buildTileWithSwitch(
                  tileName: 'Push',
                  isSwitched: isPush,
                  setValue: _setPUSHValue),
              const SizedBox(
                height: 10.0,
              ),
              buildTileWithSwitch(
                  tileName: 'WhatsApp',
                  isSwitched: isWhatsApp,
                  setValue: _setWHATSAPPValue),
            ],
          ),
        ),
      ),
    );
  }

  void _setSMSValue(bool value) {
    print('before: ' + isSMS.toString());
    setState(() => isSMS = value);
    print('after: ' + isSMS.toString());
  }

  void _setPUSHValue(bool value) {
    print('before: ' + isPush.toString());
    setState(() => isPush = value);
    print('after: ' + isPush.toString());
  }

  void _setWHATSAPPValue(bool value) {
    print('before: ' + isWhatsApp.toString());
    setState(() => isWhatsApp = value);
    print('after: ' + isWhatsApp.toString());
  }

  Container buildTileWithSwitch({
    required String tileName,
    var isSwitched,
    required void Function(bool value) setValue,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
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
            style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          Switch(
            value: isSwitched,
            activeColor: Colors.black,
            onChanged: setValue,
          ),
        ],
      ),
    );
  }
}
