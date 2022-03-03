import 'package:finandy/utils/appBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swagger/api.dart';

import '../../constants/instances.dart';
import '../../modals/customer.dart';

class NotificationSettings extends StatefulWidget {
  const NotificationSettings({Key? key}) : super(key: key);

  @override
  _NotificationSettingsState createState() => _NotificationSettingsState();
}

class _NotificationSettingsState extends State<NotificationSettings> {
  bool isSMS = false;
  bool isEmail = false;
  bool isWhatsApp = false;
  // getdet() async {
  //   try {
  //     SharedPreferences preferences = await SharedPreferences.getInstance();
  //     Object? token = preferences.get("token");
  //     apiClient.setAccessToken(token as String);
  //     var r = await userApi.v1UsersUserIdGet(
  //         '${Provider.of<Customer>(context, listen: false).userId}');
  //     print('as ${r?.notificationPreference}');
  //     print(
  //         '${Provider.of<Customer>(context, listen: false).notificationPreference}');
  //
  //     // final data = result;
  //   } catch (e) {
  //     print("Exception when calling UsersApi->v1UsersUserIdGet: $e\n");
  //   }
  // }
  putData() async {
    UsersUserIdPutBody userBody = UsersUserIdPutBody.fromJson({
      "id": Provider.of<Customer>(context, listen: false).userId,
      'notification_preference': {
        'whatsapp': isWhatsApp,
        'sms': isSMS,
        'email': isEmail,
      },
    });
    final res2 = await userApi.v1UsersUserIdPut(
        '${Provider.of<Customer>(context, listen: false).userId}',
        body: userBody);
    Provider.of<Customer>(context, listen: false)
        .setCustomer(res2, UserState.OTPVerified);
  }

  setData() async {
    setState(() {
      isSMS = Provider.of<Customer>(context, listen: false)
              .notificationPreference
              ?.sms ??
          true;
      isEmail = Provider.of<Customer>(context, listen: false)
              .notificationPreference
              ?.email ??
          true;
      isWhatsApp = Provider.of<Customer>(context, listen: false)
              .notificationPreference
              ?.whatsapp ??
          true;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setData();
  }

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
                  tileName: 'Email',
                  isSwitched: isEmail,
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
    setState(() => isSMS = value);
    putData();
  }

  void _setPUSHValue(bool value) {
    setState(() => isEmail = value);
    putData();
  }

  void _setWHATSAPPValue(bool value) {
    print('before: ' + isWhatsApp.toString());
    setState(() => isWhatsApp = value);
    putData();
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
            style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          Switch(
            value: isSwitched,
            activeColor: Color(0xffDD2E44),
            onChanged: setValue,
          ),
        ],
      ),
    );
  }
}
