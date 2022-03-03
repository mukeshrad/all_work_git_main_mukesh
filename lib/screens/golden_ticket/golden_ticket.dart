import 'package:finandy/screens/golden_ticket/Available.dart';
import 'package:finandy/screens/golden_ticket/Shared.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/utilityTools.dart';

class GoldenTicket extends StatefulWidget {
  const GoldenTicket({Key? key}) : super(key: key);

  @override
  _GoldenTicketState createState() => _GoldenTicketState();
}

class _GoldenTicketState extends State<GoldenTicket> {
  menuOption(String s) {
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
        onTap: () {},
        trailing: const Icon(Icons.arrow_forward_ios_rounded),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: buildAppBar(context),
          body: const TabBarView(
            children: <Widget>[
              AvailableGoldenTicket(),
              SharedGoldenTicket(),
            ],
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    String msg =
        "0I'm trying to make it where the user is able to change their profile pic inside the app. I'm able to pull the camera and take a picture in flutter. However, the image is not being saved, and inside visual studio code I get the following error: [ERROR:flutter/lib/ui/ui_dart_state.cc(209)] Unhandled Exception: type 'XFile' is not a subtype of type 'PickedFile' in type cast";
    return AppBar(
      elevation: 0.5,
      backgroundColor: Colors.white,
      iconTheme: const IconThemeData(
        color: Color(0xff084E6C),
      ),
      title: const Text(
        'Golden Tickets',
        style: TextStyle(color: Colors.black),
      ),
      actions: [
        IconButton(
          onPressed: () {
            showbottomSheet(buildContext: context, msg: msg);
          },
          icon: const Icon(
            CupertinoIcons.info,
            color: Colors.black,
          ),
        ),
        SizedBox(
          width: 20.0,
        ),
      ],
      bottom: const TabBar(
        unselectedLabelStyle: TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 18.0,
        ),
        labelColor: Color(0xff084E6C),
        labelStyle: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w600,
        ),
        labelPadding: EdgeInsets.only(bottom: 10.0),
        unselectedLabelColor: Color(0xff5C5C5C),
        indicatorColor: Color(0xff084E6C),
        indicatorWeight: 2,
        // isScrollable: true,
        tabs: <Tab>[
          Tab(
            text: 'Available',
          ),
          Tab(
            text: 'Shared',
          ),
        ],
      ),
    );
  }
}
