import 'dart:math';

import 'package:finandy/screens/Upi%20Payment/src/api.dart';
import 'package:finandy/screens/Upi%20Payment/src/discovery.dart';
import 'package:finandy/screens/Upi%20Payment/src/meta.dart';
import 'package:finandy/screens/Upi%20Payment/src/response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../Bil_Pay.dart';
import '../Payment_Declined.dart';
import '../Payment_Received.dart';

import 'package:universal_io/io.dart' as io;


class UpiApsList extends StatefulWidget {
  const UpiApsList({Key? key}) : super(key: key);

  @override
  _UpiApsListState createState() => _UpiApsListState();
}

class _UpiApsListState extends State<UpiApsList> {

  List<ApplicationMeta>? _apps; // System Aps upi


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(Duration(milliseconds: 0), () async {
      _apps = (await UpiPay.getInstalledUpiApplications(
          statusType: UpiApplicationDiscoveryAppStatusType.all)).cast<ApplicationMeta>();
      setState(() {});
      print(_apps?.length);
      print("--------- -- -- -- - -- -- - ");
    });

  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: appWhiteColor,
        appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: appBlackColor),
    title: const Text(
    "Quick Pay",
    style: TextStyle(color: appBlackColor),
    ),
    ),
    body: SingleChildScrollView(

      child: Container(
        // height: 100,
        child :  (_apps != null) ? _appsGrid(_apps!.map((e) => e).toList()) : Text(""),

        // child: _apps != null ? _nonDiscoverableAppsGrid() : Container(child: Text("dvd"),height: 100,),
      ),

    )
    );
  }

  Future<void> _onTap(ApplicationMeta app) async {
    // final err = _validateUpiAddress(_upiAddressController.text);
    // if (err != null) {
    //   setState(() {
    //     _upiAddrError = err;
    //   });
    //   return;
    // }
    // setState(() {
    //   _upiAddrError = null;
    // });

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

      Navigator.of(context).push(MaterialPageRoute(builder: (context) => PaymentDeclined()));

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
      paymentDetails.date =  getDate;
      paymentDetails.time =  getTime;
      paymentDetails.location = "";

      Navigator.of(context).push(MaterialPageRoute(builder: (context) => PaymentReceived(paymenData: paymentDetails, isFrome: 'BilPay',)));

    }else{
      if (io.Platform.isAndroid) {
        _showAlert(context,paymentResponce.rawResponse.toString());
      }else {
        _showAlert(context,paymentResponce.toString());
      }


    }


  }

  void _showAlert(BuildContext context,String text) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Response"),
          content: Text(text),
        )
    );
  }

  Widget _appsGrid(List<ApplicationMeta> apps) {

    return Container(
      height:  apps.length * 70,
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        // Let the ListView know how many items it needs to build.
        itemCount: apps.length,
        // Provide a builder function. This is where the magic happens.
        // Convert each item into a widget based on the type of item it is.
        itemBuilder: (context, index) {
          final item = apps[index];
          return  Container(

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

                    // print(apps[index].upiApplication.androidPackageName);

                    // print("Phone tap");
                    // initiateTransaction();

                    await _onTap(apps[index]);

                    // await LaunchApp.isAppInstalled(
                    //     androidPackageName: item.upiApplication.androidPackageName,
                    //     iosUrlScheme: 'pulsesecure://'
                    // );

                    // await LaunchApp.isAppInstalled(
                    //     androidPackageName: item.upiApplication.androidPackageName
                    //     // iosUrlScheme: 'pulsesecure://'
                    // );


                  },

                  trailing: Container(
                    decoration: BoxDecoration(
                        color: appGreyColor,
                        borderRadius: BorderRadius.circular(5)),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: Text('Pay'),
                    ),
                  ),
                  leading: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: EdgeInsets.only(right: 10),

                        width: 20,
                        child: Radio(
                            value: apps[index].upiApplication.getAppName(),
                            groupValue: "",
                            onChanged: (val) {

                              print(apps[index].upiApplication.androidPackageName);
                            }
                        ),
                      ),
                      apps[index].iconImage(24),
                      Container(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                            apps[index].upiApplication.getAppName()
                        ),
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

    // return ListView.builder(itemBuilder: (BuildContext context, int index) {
    //
    //
    // },);



    // return GridView.count(
    //   crossAxisCount: 1,
    //   shrinkWrap: true,
    //   // mainAxisSpacing: 1,
    //   // crossAxisSpacing: 1,
    //   // childAspectRatio: 4,
    //   physics: NeverScrollableScrollPhysics(),
    //   children: apps
    //       .map(
    //         (it) => Material(
    //       key: ObjectKey(it.upiApplication),
    //       // color: Colors.grey[200],
    //       child: InkWell(
    //         onTap: Platform.isAndroid ? () async => await _onTap(it) : null,
    //         child: Column(
    //           mainAxisSize: MainAxisSize.min,
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           children: <Widget>[
    //             it.iconImage(48),
    //             Container(
    //               height: 50,
    //               margin: EdgeInsets.only(top: 4),
    //               alignment: Alignment.center,
    //               child: Text(
    //                 it.upiApplication.getAppName(),
    //                 textAlign: TextAlign.center,
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //     ),
    //   )
    //       .toList(),
    // );
  }
}
