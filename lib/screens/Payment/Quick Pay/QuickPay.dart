import 'dart:math';
import 'dart:core';

import 'package:finandy/screens/Upi%20Payment/src/api.dart';
import 'package:finandy/screens/Upi%20Payment/src/discovery.dart';
import 'package:finandy/screens/Upi%20Payment/src/meta.dart';
import 'package:finandy/screens/Upi%20Payment/src/response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../Bil_Pay.dart';
import '../Payment_Declined.dart';
import '../Payment_Received.dart';

class QuickPay extends StatefulWidget {
  const QuickPay({Key? key}) : super(key: key);

  @override
  _QuickPayState createState() => _QuickPayState();
}

class _QuickPayState extends State<QuickPay> {

  String val = '';
  List<TextEditingController> listControlers = [TextEditingController(),TextEditingController(),TextEditingController()];

  String mobileNumber = '';

  String? _upiAddrError;
  final _upiAddressController = TextEditingController();
  final _amountController = TextEditingController();
  List<ApplicationMeta>? _apps; // System Aps upi

  final txtEnterAmount = TextEditingController();
  var response = "";
  var selectIndex = 0;
  var currentDate = "";

  initiateTransaction() async {
    String upiUrl = 'upi://pay?pa=7220858116@apl&pn=Deepak Kumar&am=10.0&cu=INR';
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    listControlers[0].text = mobileNumber == '' ? "1234567890" : mobileNumber;
    listControlers[1].text = mobileNumber == '' ? "1234567890" : mobileNumber;
    listControlers[2].text = mobileNumber == '' ? "1234567890" : mobileNumber;
    setState(() { });

    setState(() {
      txtEnterAmount.text = "500";
      var now = DateTime.now();
      var formatter1 = new DateFormat('MMM dd, yyyy'); //yyyy-MM-dd
      String getDate = formatter1.format(now);
      currentDate = getDate;
    });

    Future.delayed(Duration(milliseconds: 0), () async {
      //
      print("************** hhhhh");
      _apps = (await UpiPay.getInstalledUpiApplications(
          statusType: UpiApplicationDiscoveryAppStatusType.all)).cast<ApplicationMeta>();
      print(_apps?.length);
      setState(() {});
    });
  }




  Widget build(BuildContext context) {

    // background: linear-gradient(177.23deg, #084E6C -13.49%, #084E6C 109.75%);

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
        child: Column(
          children: [
            Container(
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
                        image: Image.asset("asset/Paymenticon/bgCard.jpeg", height: 20,width: 20,).image,
                        fit: BoxFit.cover
                    )
                ),
                child: Column(
                  children:[
                    Container(
                      // height:  40,
                      padding: EdgeInsets.only(left: 20,right: 20,top: 15,bottom: 5),

                      child:  Row(

                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "My E-Card",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,color: appWhiteColor),
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
                                    fontWeight: FontWeight.bold,color: appWhiteColor),
                              ),



                              Image.asset("assets/images/uptrackLogo.png",fit: BoxFit.cover,height: 15,),


                              Text(
                                "CK",
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,color: appWhiteColor),
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
                      padding: EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 5),
                      child:  Column(

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
                                fontWeight: FontWeight.bold,color: appWhiteColor),
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
                            child:  Column(

                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              // crossAxisAlignment: CrossAxisAlignment.center,
                              children: const [
                                Text(
                                  "Total Card Limit",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: appGreyColor,
                                    fontWeight: FontWeight.normal,),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  "₹ 4000.00",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,color: appWhiteColor),
                                ),
                              ],


                            ),


                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10,bottom: 10),
                            width: 0.1,
                            height: 50,
                            // height: double.infinity,
                            color: appGreyDarkColor,

                          ),
                          Container(
                            // height:  40,
                            padding: EdgeInsets.only(right: 20),
                            child:  Column(
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
                                      fontWeight: FontWeight.bold,color: appWhiteColor),
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
            ),
            Container(
              // height: 170,
              decoration: BoxDecoration(
                  border: Border.all(color: appGreyColor, width: 0.2),
                  borderRadius: const BorderRadius.all(Radius.circular(15)),

            //       boxShadow: [
            //   BoxShadow(
            //   color: appGreyColor,
            //   spreadRadius: 5,
            //   blurRadius: 9,
            //   offset: Offset(0, 2), // changes position of shadow
            // ),
          // ],

              ),
              margin: EdgeInsets.all(20),
              child:  Column(
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
                          child:  Column(
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
                                style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],


                          ),


                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10,bottom: 10),
                          width: 0.1,
                          height: 50,
                          // height: double.infinity,
                          color: appGreyDarkColor,

                        ),
                        Container(
                          // height:  40,
                          padding: EdgeInsets.only(right: 20),
                          child:  Column(

                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              Text(
                                "Unbilled Amount",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: appGreyDarkColor,
                                    fontWeight: FontWeight.normal),
                              ),

                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                "₹ 1000.00",
                                style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 50,
                    padding: EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                        border: Border.all(color: appGreyColor, width: 0.2),
                        borderRadius: const BorderRadius.all(Radius.circular(7))),
                    margin: EdgeInsets.all(20),

                    child: Row(

                      children: [

                        // Icon(Icons.calendar_today_sharp,),
                        SizedBox(width: 10,),

                        Image.asset("assets/images/calendarLogo.png",fit: BoxFit.cover,height: 20,),

                        SizedBox(width: 10,),

                        TextButton(onPressed: (){

                        }, child: Text(
                          currentDate,
                          style: TextStyle(
                              fontSize: 16,
                              color: appBlackColor,
                              fontWeight: FontWeight.w800),
                        ),)
                      ],
                    ),

                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
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
                          suffixIcon: IconButton(onPressed: (){
                            print("Work");
                            // Navigator.of(context).push(MaterialPageRoute(builder: (context) => SelectContacts()));

                          }, icon: Container(), ),//,
                          fillColor: Colors.grey.shade200),
                    ),
                  ),
                  Container(
                    // height: 42,
                    padding: EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
                    child:
                    Text(
                      "*If you are paying full outstanding balance you will save rs10.",
                      style: TextStyle(
                          fontSize: 16,
                          color: appBlackColor,

                          fontWeight: FontWeight.normal),
                    ),

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

            Container(
              child: TextButton(
                onPressed: () {

                  buttonSheetPage(_apps);

                },
                child: Container(
                  margin: const EdgeInsets.only(left: 20, right: 20, bottom: 30, top: 40),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: appRedBGColor, borderRadius: BorderRadius.circular(10)),
                  child: const Padding(
                    padding:
                    EdgeInsets.symmetric(horizontal: 15, vertical: 15),
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

  String? _validateUpiAddress(String value) {
    if (value.isEmpty) {
      return 'UPI VPA is required.';
    }
    if (value.split('@').length != 2) {
      return 'Invalid UPI VPA';
    }
    return null;
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

      Navigator.of(context).push(MaterialPageRoute(builder: (context) => PaymentReceived(paymenData: paymentDetails, isFrome: '',)));

    }else{
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

  // Show buttom Sheet
  void buttonSheetPage (List<ApplicationMeta>? _apps){

    showModalBottomSheet<dynamic>(
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, setState) {
                return Container(
                  height: ((_apps?.length ?? 0 + 3) * 70),
                  decoration: BoxDecoration(
                      color: appWhite1Color,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(25),
                        topLeft: Radius.circular(25),
                      )
                  ),
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
                                    borderRadius: BorderRadius.all(Radius.circular(15))
                                ),
                                child: InkWell(
                                  onTap: (){
                                    print("fdsvdf");
                                    Navigator.pop(context);

                                  },

                                  child: Image.asset("asset/Paymenticon/DownEro.png", height: 30,width: 30,),


                                ),
                                margin: EdgeInsets.only(top: 10,bottom: 10),

                              ),
                              const Text(
                                'Recommended Options',
                                style: TextStyle(color: appBlackColor),
                              ),
                            ],
                          ),


                        ),

                        Container(
                          height:  _apps!.length * 70,
                          child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            // Let the ListView know how many items it needs to build.
                            itemCount: _apps.length,
                            // Provide a builder function. This is where the magic happens.
                            // Convert each item into a widget based on the type of item it is.
                            itemBuilder: (context, index) {
                              final item = _apps[index];
                              return  Container(

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
                                            setState(() {

                                            });
                                          });
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: selectIndex == index ? Image.asset("asset/Paymenticon/check1.png", height: 20,width: 20,) : Image.asset("asset/Paymenticon/uncheck1.png", height: 20,width: 20,),
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
                                            child: Text(
                                                _apps[index].upiApplication.getAppName()
                                            ),
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
                            margin: const EdgeInsets.only(left: 20, right: 20, bottom: 0, top: 0),
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: appRedBGColor, borderRadius: BorderRadius.circular(10)),
                            child: const Padding(
                              padding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 15),
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


              }
          );
        });

  }


}
