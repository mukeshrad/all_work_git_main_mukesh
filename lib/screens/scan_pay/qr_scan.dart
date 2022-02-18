import 'dart:developer';

import 'package:finandy/screens/scan_pay/qr_scan-amt-desc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class CustomSizeScannerPage extends StatefulWidget {
  @override
  _CustomSizeScannerPageState createState() => _CustomSizeScannerPageState();
}

class _CustomSizeScannerPageState extends State<CustomSizeScannerPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  late QRViewController controller;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 0,
          ),
          Stack(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 1.3,
                child: _buildQrView(context),
              ),
              Positioned(
                  top: 30,
                  left: 10,
                  child: IconButton(
                    icon: Icon(
                      Icons.close_outlined,
                      color: Colors.white,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  )),
              Positioned(
                  top: 30,
                  right: 10,
                  child: IconButton(
                    icon: Icon(
                      Icons.refresh_outlined,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      setState(() {});
                    },
                  ))
            ],
          ),
          // Row(
          //   children: [
          //     IconButton(
          //       icon: Icon(Icons.close_outlined),
          //       onPressed: () => Navigator.of(context).pop(),
          //     ),
          //     IconButton(
          //       icon: Icon(Icons.refresh_outlined),
          //       onPressed: () {
          //         setState(() {});
          //       },
          //     )
          //   ],
          // ),
          // Expanded(
          //   child: _buildQrView(context),
          // child: kIsWeb
          //     ? AppBarcodeScannerWidget.defaultStyle(
          //         resultCallback: (String code) {
          //           print(code);
          //           Navigator.of(context).pushReplacement(MaterialPageRoute(
          //               builder: (context) => PayScreen(value: code)));
          //         },
          //       )
          //     : QRView(
          //         key: qrKey,
          //         onQRViewCreated: _onQRViewCreated,
          //       ),
          // ),
          SizedBox(
            height: MediaQuery.of(context).size.height * (1 - 1 / 1.3),
            child: Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Powered By'),
                    Image.asset("assets/images/poweredbyuptrack.png"),
                  ],
                )),
          )
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 300.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.white,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      controller.pauseCamera();
      RegExp regExpupi = RegExp(
        r"(\w+)://",
        caseSensitive: false,
        multiLine: false,
      );
      String? val = scanData.code;
      String verifyupi = regExpupi.stringMatch(val!).toString();
      if (verifyupi.startsWith("upi")) {
        checkMerchantDetail()
            ? Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => PayScreen(value: val)))
            : showModalBottomSheet<dynamic>(
                context: context,
                builder: (context) =>
                    Wrap(alignment: WrapAlignment.center, children: [
                      Container(
                        child: Column(
                          children: [
                            IconButton(
                              icon: Icon(Icons.arrow_drop_down_circle),
                              onPressed: () {
                                Navigator.pop(context);
                                controller.resumeCamera();
                              },
                            ),
                            Text(
                              "Your are not eligilbe for this UPI id \n for payment. Everyday Card not allowed to pay \n any liquor shop",
                              textAlign: TextAlign.center,
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 20),
                              child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                CustomSizeScannerPage()));
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.blueAccent,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Text(
                                      "Please try Again",
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ]));
        // controller.resumeCamera();
      } else {
        showModalBottomSheet<dynamic>(
            context: context,
            builder: (context) =>
                Wrap(alignment: WrapAlignment.center, children: [
                  Container(
                    child: Column(
                      children: [
                        IconButton(
                          icon: Icon(Icons.arrow_drop_down_circle),
                          onPressed: () {
                            Navigator.pop(context);
                            controller.resumeCamera();
                          },
                        ),
                        Text(
                          "Not an UPI QR Code",
                          textAlign: TextAlign.center,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 20),
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            CustomSizeScannerPage()));
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.blueAccent,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Text(
                                  "Please try Again",
                                  style: TextStyle(fontSize: 20),
                                ),
                              )),
                        ),
                      ],
                    ),
                  ),
                ]));
      }
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  bool checkMerchantDetail() => true;
}
//UPI URLm
//upi://pay?pa=UPIID@oksbi&amp;pn=FNAME SNAME K&amp;cu=INR
