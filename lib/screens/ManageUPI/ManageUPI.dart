import 'package:flutter/material.dart';

import '../../utils/main_app_bar.dart';

class ManageUPI extends StatefulWidget {
  @override
  _ManageUPI createState() => _ManageUPI();
}

enum ListUPI { PhonePe, GooglePay }

class _ManageUPI extends State<ManageUPI> {
  ListUPI? _character = ListUPI.PhonePe;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        appBar: AppBar(),
        title: "Card Settings",
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
            child: Text(
              "Your Saved UPI",
              style: TextStyle(
                  fontFamily: "Inter",
                  fontWeight: FontWeight.w500,
                  fontSize: 18),
            ),
          ),
          SizedBox(),
          ListView(
            children: [
              Card(
                margin:
                    EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                child: ListTile(
                  title: const Text('PhonePe'),
                  leading: Radio<ListUPI>(
                    value: ListUPI.PhonePe,
                    groupValue: _character,
                    onChanged: (ListUPI? value) {
                      setState(() {
                        _character = value;
                      });
                    },
                  ),
                ),
              ),
              Card(
                margin:
                    EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                child: ListTile(
                  title: const Text('Google Pay'),
                  leading: Radio<ListUPI>(
                    value: ListUPI.GooglePay,
                    groupValue: _character,
                    onChanged: (ListUPI? value) {
                      setState(() {
                        _character = value;
                      });
                    },
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
