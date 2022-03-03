import 'dart:async';
import 'dart:developer';

import 'package:finandy/constants/instances.dart';
import 'package:finandy/screens/scan_pay/qr_scan-amt-desc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrScanPage extends StatefulWidget {
  @override
  _QrScanPageState createState() => _QrScanPageState();
}

class _QrScanPageState extends State<QrScanPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  late QRViewController controller;
  bool validMerchant = true;
  late Map mercDetails;
  @override
  void initState() {
    super.initState();
  }

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
          Expanded(
            child: Stack(
              children: [
                _buildQrView(context),
                Positioned(
                  top: 40,
                  left: 10,
                  child: IconButton(
                    icon: const Icon(
                      Icons.close_outlined,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      // controller.stopCamera();

                      Navigator.pop(context);
                    },
                  ),
                ),
                Positioned(
                  top: 40,
                  right: 10,
                  child: IconButton(
                    icon: const Icon(
                      Icons.refresh_outlined,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        controller.resumeCamera();
                      });
                    },
                  ),
                )
              ],
            ),
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
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 50.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Powered By'),
                const SizedBox(
                  height: 10.0,
                ),
                Image.asset("assets/images/poweredbyuptrack.png"),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 300.0
        : 300.0;
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderColor: Colors.white,
        borderRadius: 10,
        borderLength: 30,
        borderWidth: 10,
        cutOutSize: scanArea,
      ),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  sendToScreen(merchDetails) async {
    bool r = await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => PayScreen(mercDetails: merchDetails)));
    if (r) {
      controller.resumeCamera();
    }
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
      // print('qr code is this $val');
      if (verifyupi.startsWith("upi")) {
        checkMerchantDetail(val).then((value) {
          validMerchant
              ? sendToScreen(mercDetails)
              : showModalBottomSheet<dynamic>(
                  context: context,
                  builder: (context) =>
                      Wrap(alignment: WrapAlignment.center, children: [
                        Container(
                          child: Column(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.arrow_drop_down_circle),
                                onPressed: () {
                                  Navigator.pop(context);
                                  controller.resumeCamera();
                                },
                              ),
                              const Text(
                                "Your are not eligilbe for this UPI id \n for payment. Everyday Card not allowed to pay \n any liquor shop",
                                textAlign: TextAlign.center,
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 20),
                                child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  QrScanPage()));
                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.blueAccent,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.all(15.0),
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
        });

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
                          icon: const Icon(Icons.arrow_drop_down_circle),
                          onPressed: () {
                            Navigator.pop(context);
                            controller.resumeCamera();
                          },
                        ),
                        const Text(
                          "Not an UPI QR Code",
                          textAlign: TextAlign.center,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 20),
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) => QrScanPage()));
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.blueAccent,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(15.0),
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
    controller.stopCamera();
    controller.dispose();
    super.dispose();
  }

  Future<void> checkMerchantDetail(result) async {
    try {
      var apiResult = await merchantApi.v1MerchantsCheck(result);
      final Map someMap = {
        "upi_id": apiResult!.paymentInstruments!.upiId,
        "name": apiResult.name ?? "Default Name",
        "merchantCategoryCode": apiResult.merchantCategoryCode ?? "1571",
        "image": apiResult.images,
        "qr_code": result
      };
      setState(() {
        mercDetails = someMap;
        validMerchant = true;
      });
    } catch (e) {
      print("Exception when calling MerchantApi->v1MerchantsCheck: $e\n");
      setState(() {
        validMerchant = false;
      });
    }
  }
}
//UPI URLm
//upi://pay?pa=UPIID@oksbi&amp;pn=FNAME SNAME K&amp;cu=INR
