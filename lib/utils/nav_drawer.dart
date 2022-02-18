import 'dart:io';

import 'package:finandy/constants/texts.dart';
import 'package:finandy/modals/customer.dart';
import 'package:finandy/screens/AcountSettings/account_settings.dart';
import 'package:finandy/screens/Credit-Score/credit_Score.dart';
import 'package:finandy/screens/Rate_AND_Review/ratingScreen.dart';
import 'package:finandy/screens/app_purpose.dart';
import 'package:finandy/screens/golden_ticket/golden_ticket.dart';
import 'package:finandy/screens/profile/profile.dart';
import 'package:finandy/utils/profile_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class NavDrawer extends StatefulWidget {
  const NavDrawer({Key? key}) : super(key: key);

  @override
  _NavDrawerState createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  menuOption(Icon icon, String s, VoidCallback callback) {
    return Padding(
      padding: EdgeInsets.only(
          top: icon == Icons.person_outline_sharp ? 0 : 5, bottom: 5),
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
          tileColor: const Color(0xffFFFFFF),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              side: BorderSide(width: 0.5, color: Colors.white)),
          leading: icon,
          onTap: callback,
          title: Text(
            s,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios_rounded,
            color: Colors.black,
            size: 12.0,
          ),
        ),
      ),
    );
  }

  sendToscreen(var page, BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  _launchURL() async {
    const url = 'https://www.uptrack.money/privacy';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  openwhatsapp() async {
    var whatsapp = whatsAppNO;
    var whatsappURlAndroid =
        "whatsapp://send?phone=" + whatsapp + "&text=hello";
    var whatappURLIos = "https://wa.me/$whatsapp?text=${Uri.parse("hello")}";
    if (Platform.isIOS) {
      // for iOS phone only
      if (await canLaunch(whatappURLIos)) {
        await launch(whatappURLIos, forceSafariVC: false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("whatsapp no installed")));
      }
    } else {
      // android , web
      if (await canLaunch(whatsappURlAndroid)) {
        await launch(whatsappURlAndroid);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("whatsapp no installed")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.85,
        child: Drawer(
          child: Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: ListView(
                    clipBehavior: Clip.hardEdge,
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.clear,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      ProfileUi(
                          id: userId,
                          name:
                              '${Provider.of<Customer>(context, listen: false).customerName}',
                          profileImg: userImg),
                      const SizedBox(
                        height: 15,
                      ),
                      menuOption(
                          const Icon(
                            Icons.person_outline_sharp,
                            color: Color(0xff55ACEE),
                          ),
                          "Profile", () {
                        sendToscreen(const ProfilePage(), context);
                      }),
                      menuOption(
                          const Icon(
                            CupertinoIcons.ticket_fill,
                            color: Color(0xffF4900C),
                          ),
                          "Golden Ticket", () {
                        sendToscreen(const GoldenTicket(), context);
                      }),
                      menuOption(
                          const Icon(
                            CupertinoIcons.speedometer,
                            color: Color(0xff6FEF25),
                          ),
                          "Credit Score", () {
                        sendToscreen(const CreditScore(), context);
                      }),
                      menuOption(
                          const Icon(
                            Icons.settings_outlined,
                            color: Color(0xffFA743E),
                          ),
                          "Account Settings", () {
                        Navigator.pop(context);
                        sendToscreen(const AccountSettings(), context);
                      }),
                      menuOption(
                          const Icon(
                            Icons.gpp_good_outlined,
                            color: Color(0xffDF1F32),
                          ),
                          "Privacy Policy", () {
                        _launchURL();
                      }),
                      menuOption(
                          const Icon(
                            Icons.rate_review_outlined,
                            color: Color(0xff72D837),
                          ),
                          "Rate and Review", () {
                        sendToscreen(const RatingScreen(), context);
                      }),
                      menuOption(
                          const Icon(
                            Icons.contact_support_outlined,
                            color: Color(0xff259AF2),
                          ),
                          "24x7 WhatsApp Support", () {
                        openwhatsapp();
                      }),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () async {
                    SharedPreferences preferences =
                        await SharedPreferences.getInstance();
                    preferences.remove("token");
                    preferences.remove("userId");
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => const AppPurpose()),
                        (route) => false);
                  },
                  child: buildButtonText(),
                ),
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container buildButtonText() {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 16.0,
      ),
      decoration: BoxDecoration(
        color: Color.fromRGBO(223, 31, 50, .2),
        borderRadius: BorderRadius.circular(7.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            offset: const Offset(0.0, 5.0),
            blurRadius: 30.0,
          ),
        ],
      ),
      child: Center(
          child: Text(
        'Logout',
        style: TextStyle(
          color: Color(0xffDF1F32),
          fontWeight: FontWeight.w500,
        ),
      )),
    );
  }
}
