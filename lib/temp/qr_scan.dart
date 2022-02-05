import 'package:finandy/services/scanner_service.dart';
import 'package:flutter/material.dart';

/// FullScreenScannerPage
class FullScreenScannerPage extends StatefulWidget {
  static String id = "qrscan" ;
  const FullScreenScannerPage({ Key? key }) : super(key: key);
  @override
  _FullScreenScannerPageState createState() => _FullScreenScannerPageState();
}

class _FullScreenScannerPageState extends State<FullScreenScannerPage> {
  String _code = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("「$_code」"),
            ],
          ),
          Expanded(
            child: AppBarcodeScannerWidget.defaultStyle(
              resultCallback: (String code) {
                setState(() {
                  _code = code;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}