import 'package:finandy/screens/scan_pay/qr_scan-screen2.dart';
import 'package:finandy/services/scanner_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomSizeScannerPage extends StatefulWidget {
  @override
  _CustomSizeScannerPageState createState() => _CustomSizeScannerPageState();
}

class _CustomSizeScannerPageState extends State<CustomSizeScannerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            child: AppBarcodeScannerWidget.defaultStyle(
              resultCallback: (String code) {
                print(code);
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => PayScreen(value: code)));
              },
            ),
          ),
        ],
      ),
    );
  }
}
//UPI URLm
//upi://pay?pa=UPIID@oksbi&amp;pn=FNAME SNAME K&amp;cu=INR
