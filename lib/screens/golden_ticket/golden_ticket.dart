import 'package:finandy/screens/golden_ticket/Available.dart';
import 'package:finandy/screens/golden_ticket/Shared.dart';
import 'package:flutter/material.dart';

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
          appBar: buildAppBar(),
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

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      iconTheme: const IconThemeData(
        color: Color(0xff084E6C),
      ),
      title: const Text(
        'Golden Tickets',
        style: TextStyle(color: Colors.black),
      ),
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
