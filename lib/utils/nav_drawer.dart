import 'package:finandy/constants/texts.dart';
import 'package:finandy/screens/AcountSettings/account_settings.dart';
import 'package:finandy/screens/Rate_AND_Review/ratingScreen.dart';
import 'package:finandy/screens/app_purpose.dart';
import 'package:finandy/screens/golden_ticket/golden_ticket.dart';
import 'package:finandy/screens/profile/profile.dart';
import 'package:finandy/utils/profile_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NavDrawer extends StatefulWidget {
  const NavDrawer({Key? key}) : super(key: key);

  @override
  _NavDrawerState createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  menuOption(IconData icon, String s, VoidCallback callback) {
    return Padding(
      padding: EdgeInsets.only(
          top: icon == Icons.person_outline_sharp ? 0 : 5, bottom: 5),
      child: ListTile(
        tileColor: Colors.grey[200],
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            side: BorderSide(width: 0.5, color: Colors.white)),
        leading: Icon(icon),
        onTap: callback,
        title: Text(
          s,
          style: const TextStyle(
            fontSize: 17,
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios_rounded),
      ),
    );
  }

  sendToscreen(var page, BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
        clipBehavior: Clip.hardEdge,
        children: [
          ProfileUi(id: userId, name: userName, profileImg: userImg),
          const SizedBox(
            height: 15,
          ),
          menuOption(Icons.person_outline_sharp, "Profile", () {
            sendToscreen(const ProfilePage(), context);
          }),
          menuOption(CupertinoIcons.ticket_fill, "Golden Ticket", () {
            sendToscreen(const GoldenTicket(), context);
          }),
          menuOption(Icons.settings, "Account Settings", () {
            Navigator.pop(context);
            sendToscreen(const AccountSettings(), context);
          }),
          menuOption(Icons.gpp_good_outlined, "Privacy Policy", () {}),
          menuOption(Icons.rate_review_outlined, "Rate and Review", () {
            sendToscreen(const RatingScreen(), context);
          }),
          menuOption(
              Icons.contact_support_outlined, "24x7 WhatsApp Support", () {}),
          const SizedBox(
            height: 15,
          ),
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.grey[100],
              ),
              child: const Text(
                "Log Out",
                style: TextStyle(color: Colors.black54),
              ),
              onPressed: () async {
                SharedPreferences preferences = await SharedPreferences.getInstance();
                preferences.remove("token");
                preferences.remove("userId");
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const AppPurpose()), (route) => false);
                },
            ),
          )
        ],
      ),
    );
  }
}
