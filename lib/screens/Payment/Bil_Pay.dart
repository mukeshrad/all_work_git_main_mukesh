import 'dart:math';
import 'package:finandy/constants/Colors.dart';
import 'package:intl/intl.dart';
import 'package:universal_io/io.dart' as io;
import 'package:finandy/screens/Upi%20Payment/src/api.dart';
import 'package:finandy/screens/Upi%20Payment/src/discovery.dart';
import 'package:finandy/screens/Upi%20Payment/src/meta.dart';
import 'package:finandy/screens/Upi%20Payment/src/response.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobile_number/mobile_number.dart';
import 'package:url_launcher/url_launcher.dart';

import 'Payment_Declined.dart';
import 'Payment_Received.dart';

class BilPay extends StatefulWidget {
  static String id = "Billpay";
  const BilPay({Key? key}) : super(key: key);

  @override
  _BilPayState createState() => _BilPayState();
}

class _BilPayState extends State<BilPay> {
  String val = '';
  // String _mobileNumber = '';
  // List<SimCard> _simCard = <SimCard>[];

  List<ApplicationMeta>? _apps; // System Aps upi

  var selectIndex = 0;
  var responce = "";

  final txtEnterAmount = TextEditingController();
  var currentDate = "";

  initiateTransaction() async {
    String upiUrl =
        'upi://pay?pa=7220858116@apl&pn=Deepak Kumar&am=10.0&cu=INR';
    await launch(upiUrl).then((value) {
      if (kDebugMode) {
        print(value);
      }
    }).catchError((err) => print(err));
  }

  Future<void> _onTap(ApplicationMeta app) async {
    final transactionRef = Random.secure().nextInt(1 << 32).toString();
    print("Starting transaction with id $transactionRef");

    String price = "10.0";
    String upi = "7220858116@apl";

    final paymentResponce = await UpiPay.initiateTransaction(
      amount: price,
      app: app.upiApplication,
      receiverName: 'Sharad',
      receiverUpiAddress: upi,
      transactionRef: transactionRef,
      transactionNote: 'UPI Payment',
      // merchantCode: '7372',
    );

    print(paymentResponce.toString());

    if (paymentResponce.status == UpiTransactionStatus.failure) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => PaymentDeclined()));
    } else if (paymentResponce.status == UpiTransactionStatus.success) {
      var now = DateTime.now();
      var formatter1 = new DateFormat('MMM dd, yyyy'); //yyyy-MM-dd
      String getDate = formatter1.format(now);
      print(getDate);

      var formatter2 = new DateFormat('hh:mm a'); //yyyy-MM-dd
      String getTime = formatter2.format(now);
      print(getTime);

      var paymentDetails = UpiPaymentResponse();
      paymentDetails.amount = "₹ " + price;
      paymentDetails.cardNumber = upi;
      paymentDetails.transID = paymentResponce.txnId.toString();
      paymentDetails.date = getDate;
      paymentDetails.time = getTime;
      paymentDetails.location = "";

      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => PaymentReceived(
                paymenData: paymentDetails,
                isFrome: 'BilPay',
              )));
    } else {
      if (io.Platform.isAndroid) {
        _showAlert(context, paymentResponce.rawResponse.toString());
      } else {
        _showAlert(context, paymentResponce.toString());
      }
    }
  }

  void _showAlert(BuildContext context, String text) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("Response"),
              content: Text(text),
            ));
  }

  @override
  void initState() {
    super.initState();
    //
    // MobileNumber.listenPhonePermission((isPermissionGranted) {
    //   if (isPermissionGranted) {
    //     initMobileNumberState();
    //   } else {}
    // });
    //
    // initMobileNumberState();

    setState(() {
      txtEnterAmount.text = "500";
      var now = DateTime.now();
      var formatter1 = new DateFormat('MMM dd, yyyy'); //yyyy-MM-dd
      String getDate = formatter1.format(now);
      currentDate = getDate;
    });

    Future.delayed(Duration(milliseconds: 0), () async {
      _apps = (await UpiPay.getInstalledUpiApplications(
              statusType: UpiApplicationDiscoveryAppStatusType.all))
          .cast<ApplicationMeta>();
      setState(() {});
    });
  }

// Platform messages are asynchronous, so we initialize in an async method.
//   Future<void> initMobileNumberState() async {
//     if (!await MobileNumber.hasPhonePermission) {
//       await MobileNumber.requestPhonePermission;
//       return;
//     }
//     String mobileNumber = '';
//     // Platform messages may fail, so we use a try/catch PlatformException.
//     try {
//       mobileNumber = (await MobileNumber.mobileNumber)!;
//       _simCard = (await MobileNumber.getSimCards)!;
//     } on PlatformException catch (e) {
//       debugPrint("Failed to get mobile number because of '${e.message}'");
//     }
//
//     // If the widget was removed from the tree while the asynchronous platform
//     // message was in flight, we want to discard the reply rather than calling
//     // setState to update our non-existent appearance.
//     if (!mounted) return;
//
//     setState(() {
//       _mobileNumber = mobileNumber;
//     });
//   }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appWhiteColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: appBlackColor),
        title: const Text(
          "Bil Pay",
          style: TextStyle(color: appBlackColor),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            cardUser(),
            Container(
              // height: 170,
              decoration: BoxDecoration(
                border: Border.all(color: appGreyColor, width: 0.2),
                borderRadius: const BorderRadius.all(Radius.circular(15)),
              ),
              margin: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          // height:  40,

                          padding: EdgeInsets.only(left: 20),
                          alignment: Alignment.centerLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "Payment Due",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: appGreyDarkColor,
                                    fontWeight: FontWeight.normal),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                "₹ 500",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10, bottom: 10),
                          width: 0.1,
                          height: 50,
                          // height: double.infinity,
                          color: appGreyDarkColor,
                        ),
                        Container(
                          // height:  40,
                          padding: EdgeInsets.only(right: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [
                              Text(
                                "Due Date",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: appGreyDarkColor,
                                    fontWeight: FontWeight.normal),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                currentDate,
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 10),
                    child: TextFormField(
                      showCursor: false,
                      readOnly: false,
                      controller: txtEnterAmount,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8)),
                          filled: true,
                          isDense: true,
                          hintText: "₹ 500",
                          labelText: 'Enter Amount',
                          suffixIcon: IconButton(
                            onPressed: () {
                              print("Work");
                              // Navigator.of(context).push(MaterialPageRoute(builder: (context) => SelectContacts()));
                            },
                            icon: Container(),
                          ), //,
                          fillColor: Colors.grey.shade200),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: 5,
                    color: appGreyColor.withOpacity(0.5),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                        // border: Border.all(color: Colors.grey,width: 1),
                        color: appBlueGColor,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15))),

                    height: 20,
                    // color: Colors.black,
                  ),
                ],
              ),
            ),

            // Expanded(
            //   child: Container(),
            // ),
            // Expanded(child: Container()),
            Container(
              child: TextButton(
                onPressed: () {
                  buttonSheetPage(_apps);
                },
                child: Container(
                  margin: const EdgeInsets.only(
                      left: 20, right: 20, bottom: 30, top: 40),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: appRedBGColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    child: Center(
                        // PaymentDeclined
                        child: Text(
                      'Proceed to Pay',
                      style: TextStyle(color: appWhiteColor),
                    )),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget cardUser() {
    return Container(
      margin: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: appBlueGColor.withOpacity(0.6), //appBlueGColor.withOpacity(0.5),
        borderRadius: const BorderRadius.all(Radius.circular(15)),
      ),
      child: Container(
        // height: 170,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Color(0xFF0E0E0E), Color(0xFF0E0E0E)]),
            border: Border.all(color: appGreyColor, width: 0.2),
            // color: Colors.blue,
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            image: DecorationImage(
                opacity: 0.2,
                image: Image.asset(
                  "asset/Paymenticon/bgCard.jpeg",
                  height: 20,
                  width: 20,
                ).image,
                fit: BoxFit.cover)),
        child: Column(
          children: [
            Container(
              // height:  40,
              padding: EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 5),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "My E-Card",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: appWhiteColor),
                  ),
                  SizedBox(
                    height: 8,
                  ),

                  Row(
                    children: [
                      Text(
                        "UPTR",
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: appWhiteColor),
                      ),
                      Image.asset(
                        "assets/images/uptrackLogo.png",
                        fit: BoxFit.cover,
                        height: 15,
                      ),
                      Text(
                        "CK",
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: appWhiteColor),
                      ),
                    ],
                  ),

                  // Text(
                  //   "UPTR CK",
                  //   style: TextStyle(
                  //       fontSize: 17,
                  //       fontWeight: FontWeight.bold,color: appWhiteColor),
                  // ),
                ],
              ),
            ),
            Container(
              // height:  40,
              padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Text(
                    "Card Number",
                    style: TextStyle(
                        fontSize: 16,
                        color: appGreyColor,
                        fontWeight: FontWeight.normal),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    "7987 8453 98",
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: appWhiteColor),
                  ),
                ],
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    // height:  40,
                    padding: EdgeInsets.only(left: 20),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Text(
                          "Total Card Limit",
                          style: TextStyle(
                            fontSize: 16,
                            color: appGreyColor,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          "₹ 4000.00",
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: appWhiteColor),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10, bottom: 10),
                    width: 0.1,
                    height: 50,
                    // height: double.infinity,
                    color: appGreyDarkColor,
                  ),
                  Container(
                    // height:  40,
                    padding: EdgeInsets.only(right: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Text(
                          "Weekly Limit",
                          style: TextStyle(
                              fontSize: 16,
                              color: appGreyColor,
                              fontWeight: FontWeight.normal),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          "₹ 1000.00",
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: appWhiteColor),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _appsGrid(List<ApplicationMeta> apps) {
    return Container(
      height: apps.length * 70,
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        // Let the ListView know how many items it needs to build.
        itemCount: apps.length,
        // Provide a builder function. This is where the magic happens.
        // Convert each item into a widget based on the type of item it is.
        itemBuilder: (context, index) {
          final item = apps[index];
          return Container(
            margin: EdgeInsets.only(top: 10),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              margin: EdgeInsets.symmetric(horizontal: 28),
              child: ListTile(
                  // dense: true,

                  onTap: () async {
                    setState(() {
                      selectIndex = index;
                    });
                    await _onTap(apps[index]);
                  },
                  trailing: Container(
                    decoration: BoxDecoration(
                        color: appGreyColor,
                        borderRadius: BorderRadius.circular(5)),
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      child: Text('Pay'),
                    ),
                  ),
                  leading: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        child: selectIndex == index
                            ? Image.asset(
                                "asset/Paymenticon/check1.png",
                                height: 20,
                                width: 20,
                              )
                            : Image.asset(
                                "asset/Paymenticon/uncheck1.png",
                                height: 20,
                                width: 20,
                              ),
                        padding: EdgeInsets.only(right: 10),
                      ),

                      apps[index].iconImage(24),
                      Container(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(apps[index].upiApplication.getAppName()),
                      ),

                      // SvgPicture.asset(
                      //   'asset/Paymenticon/phonpe.svg',
                      //   width: 100,
                      //   height: 32,
                      // )
                    ],
                  )),
            ),
          );
        },
      ),
    );
  }

  Card paycard(
      BuildContext context, String assetname, TextEditingController controler) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.fromLTRB(30, 10, 30, 10),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          trailing: Container(
            width: 1,
          ),
          leading: Container(
              // width: 20,
              // color: Colors.red,
              child: Radio(
                  value: 'Phonepay', groupValue: val, onChanged: (val) {})),
          title: SvgPicture.asset(
            'asset/Paymenticon/$assetname.svg',
            width: 70,
            alignment: Alignment.centerLeft,
            color: appGreyDarkColor,
          ),
        ),
      ),
    );
  }

  String? _validateUpiAddress(String value) {
    if (value.isEmpty) {
      return 'UPI VPA is required.';
    }
    if (value.split('@').length != 2) {
      return 'Invalid UPI VPA';
    }
    return null;
  }

  // Show buttom Sheet
  void buttonSheetPage(List<ApplicationMeta>? _apps) {
    showModalBottomSheet<dynamic>(
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (BuildContext context, setState) {
            return Container(
              height: ((_apps?.length ?? 0 + 3) * 70),
              decoration: BoxDecoration(
                  color: appWhite1Color,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(25),
                    topLeft: Radius.circular(25),
                  )),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 10),

                      // height: 50,
                      // color: Colors.red,

                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: appWhiteColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                            child: InkWell(
                              onTap: () {
                                print("fdsvdf");
                                Navigator.pop(context);
                              },
                              child: Image.asset(
                                "asset/Paymenticon/DownEro.png",
                                height: 30,
                                width: 30,
                              ),
                            ),
                            margin: EdgeInsets.only(top: 10, bottom: 10),
                          ),
                          const Text(
                            'Recommended Options',
                            style: TextStyle(color: appBlackColor),
                          ),
                        ],
                      ),
                    ),

                    Container(
                      height: _apps!.length * 70,
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        // Let the ListView know how many items it needs to build.
                        itemCount: _apps.length,
                        // Provide a builder function. This is where the magic happens.
                        // Convert each item into a widget based on the type of item it is.
                        itemBuilder: (context, index) {
                          final item = _apps[index];
                          return Container(
                            margin: EdgeInsets.only(top: 10),
                            child: Card(
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              margin: EdgeInsets.symmetric(horizontal: 28),
                              child: ListTile(
                                  onTap: () async {
                                    setState(() {
                                      selectIndex = index;
                                    });
                                  },
                                  trailing: InkWell(
                                    onTap: () {
                                      setState(() {
                                        selectIndex = index;
                                        print("selectIndex : $selectIndex");
                                        setState(() {});
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: selectIndex == index
                                            ? Image.asset(
                                                "asset/Paymenticon/check1.png",
                                                height: 20,
                                                width: 20,
                                              )
                                            : Image.asset(
                                                "asset/Paymenticon/uncheck1.png",
                                                height: 20,
                                                width: 20,
                                              ),
                                      ),
                                    ),
                                  ),
                                  leading: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(right: 10),
                                        width: 20,
                                      ),
                                      _apps[index].iconImage(24),
                                      Container(
                                        padding: EdgeInsets.only(left: 10),
                                        child: Text(_apps[index]
                                            .upiApplication
                                            .getAppName()),
                                      ),
                                    ],
                                  )),
                            ),
                          );
                        },
                      ),
                    ),

                    // (_apps != null) ? _appsGrid(_apps!.map((e) => e).toList()) : Text(""),

                    TextButton(
                      onPressed: () async {
                        await _onTap(_apps[selectIndex]);
                      },
                      child: Container(
                        margin: const EdgeInsets.only(
                            left: 20, right: 20, bottom: 0, top: 0),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: appRedBGColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 15),
                          child: Center(
                              // PaymentDeclined
                              child: Text(
                            'Proceed to Pay',
                            style: TextStyle(color: appWhiteColor),
                          )),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          });
        });
  }
}

class UpiPaymentResponse {
  late String amount;
  late String cardNumber;
  late String transID;
  late String date;
  late String time;
  late String location;
}
