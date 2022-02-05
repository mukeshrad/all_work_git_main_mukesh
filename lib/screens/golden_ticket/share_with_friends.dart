import 'package:finandy/utils/appBar.dart';
import 'package:finandy/utils/usedButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Available.dart';

class ShareWithFriendsScreen extends StatefulWidget {
  const ShareWithFriendsScreen({Key? key}) : super(key: key);

  @override
  _ShareWithFriendsScreenState createState() => _ShareWithFriendsScreenState();
}

class _ShareWithFriendsScreenState extends State<ShareWithFriendsScreen> {
  bool showContactField = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                NewAppBar(pageName: 'Share With Friend'),
                SizedBox(
                  height: 44.0,
                ),
                Image.asset(
                  'assets/images/refer.png',
                ),
                buildCard(
                    valid_Date: '06/30',
                    onTapShare: () {},
                    cardNo: '1234 5678 9012 3456'),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    showContactField == false
                        ? buildMobNoButton(callback: () {
                            setState(() {
                              showContactField = true;
                            });
                          })
                        : buildSelectFromContactButton(context,
                            callback: () {}),
                  ],
                ),
              ],
            ),
            UsedButton(
              buttonName: 'Share With Friend',
              onpressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  Padding buildSelectFromContactButton(BuildContext context,
      {required VoidCallback callback}) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 30.0,
        vertical: 40.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: callback,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xff141414)),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  // padding: EdgeInsets.only(
                  //   top: 16.0,
                  //   bottom: 16.0,
                  //   left: 18.0,
                  // ),
                  child: ListTile(
                    title: Text(
                      "Select From Contact List",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff141414),
                      ),
                    ),
                    trailing: Icon(
                      Icons.contacts,
                      color: Color(0xff5C5C5C),
                    ),
                  ),
                ),
                Positioned(
                  left: 20.06,
                  top: -10.0,
                  child: Container(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    padding: EdgeInsets.all(4.0),
                    child: Row(
                      children: [
                        Text(
                          'Mobile',
                          style: TextStyle(
                            fontSize: 12.0,
                            color: Color(0xff141414),
                          ),
                        ),
                        Text(
                          '*',
                          style: TextStyle(
                            fontSize: 12.0,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 4.0,
          ),
          Text(
            'Only Aadhar registered number allowed.',
            style: TextStyle(
              fontSize: 10.0,
              color: Color(0xff5C5C5C),
            ),
          )
        ],
      ),
    );
  }

  InkWell buildMobNoButton({required VoidCallback callback}) {
    return InkWell(
      onTap: callback,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 30.0, vertical: 40.0),
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xff7B8497)),
          borderRadius: BorderRadius.circular(8.0),
        ),
        padding: EdgeInsets.only(
          top: 16.0,
          bottom: 16.0,
          left: 18.0,
        ),
        child: Text(
          'Mobile Number',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
            color: Color(0xff7B8497),
          ),
        ),
      ),
    );
  }
}
