import 'dart:async';

import 'package:finandy/screens/rootPageScreens/root_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

var cardId = "15577057378879732";
var trId = "123";
enum Response { Success, Pending, Failed }

class TransactionStatus extends StatefulWidget {
  const TransactionStatus({Key? key}) : super(key: key);

  @override
  State<TransactionStatus> createState() => _TransactionStatus();
}

//
class _TransactionStatus extends State<TransactionStatus> {
  var APIResponse = Response.Success;
  List<String> AppBarResponse = [
    "Transaction Successful!",
    "Transaction Pending!",
    "Transaction Failed!",
  ];
  String appBarTitle = "Transaction Pending!";
  late Timer timer;
  @override
  void initState() {
    super.initState();
    // timer = Timer.periodic(Duration(seconds: 10), (Timer t) {
    //   var result =
    //       transaction_api.v1CardsCardIdTransactionsTrIdGet(cardId, trId);
    // });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  void changeTitle() {
    setState(() {
      appBarTitle = APIResponse == Response.Pending
          ? AppBarResponse[1]
          : (APIResponse == Response.Success
              ? AppBarResponse[0]
              : AppBarResponse[2]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 25, right: 25, top: 30),
        child: PendingPage(),
      ),
    );
  }
}

class PendingPage extends StatefulWidget {
  @override
  _PendingPage createState() => _PendingPage();
}

class _PendingPage extends State<PendingPage> {
  String userName = "Apoorv";
  double Amount = 100;
  var TrId = "123";
  String Date = DateFormat.yMMMd().format(DateTime.now());
  String Time = DateFormat.jm().format(DateTime.now());
  String Location = "GZB";
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Card(
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 10,
              ),
              CircularProgressIndicator(
                strokeWidth: 4,
              ),
              Container(
                  child: Column(children: [
                Container(),
                SizedBox(
                  height: 20,
                ),
                const Text("Pending",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.amber,
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w600,
                    )),
                SizedBox(
                  height: 10,
                ),
                const Text(
                  "Your payment has reached the \n receiver’s bank and will be transferred \n to the receiver’s account within 2 \n working days. If this fails for any \n reason, you will receive a refund. Don’t \n worry, your money is safe.",
                  textAlign: TextAlign.center,
                ),
              ])),
              Column(
                children: [
                  const ListTile(
                    minVerticalPadding: 0,
                    title: Text(
                      "Transaction Details",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: "Inter",
                          fontSize: 16),
                    ),
                  ),
                  // Container(
                  //   decoration: BoxDecoration(
                  //       border: Border(bottom: BorderSide(color: Colors.black))),
                  // ),
                  Divider(
                    color: Colors.black12,
                    indent: 20,
                    endIndent: 20,
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Paid to",
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text("Amount", style: TextStyle(fontSize: 16)),
                          SizedBox(
                            height: 10,
                          ),
                          Text("Trans Id", style: TextStyle(fontSize: 16)),
                          SizedBox(
                            height: 10,
                          ),
                          Text("Date", style: TextStyle(fontSize: 16)),
                          SizedBox(
                            height: 10,
                          ),
                          Text("Time", style: TextStyle(fontSize: 16)),
                          SizedBox(
                            height: 10,
                          ),
                          Text("Location", style: TextStyle(fontSize: 16)),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            ": ${userName}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            ": ₹${Amount}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            ": ${TrId}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            ": ${Date}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            ": ${Time}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            ": ${Location}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Icon(
                    Icons.verified_user_outlined,
                    color: Colors.green,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                    child: Text("Pin Verified"),
                    alignment: Alignment.center,
                  ),
                  Padding(padding: EdgeInsets.all(12.5)),
                ],
              ),
            ],
          ),
        ),
        Flexible(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 20),
            child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const RootPage()));
                },
                style: ElevatedButton.styleFrom(
                  primary: Color(0xff093257),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      "Home",
                      style: TextStyle(fontSize: 20),
                    ))),
          ),
        ),
      ],
    );
  }
}

class FailedPage extends StatefulWidget {
  @override
  _FailedPage createState() => _FailedPage();
}

class _FailedPage extends State<FailedPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Text("Failed");
  }
}

class SuccessPage extends StatefulWidget {
  @override
  _SuccessPage createState() => _SuccessPage();
}

class _SuccessPage extends State<SuccessPage> {
  String userName = "Apoorv";
  double Amount = 100;
  var TrId = "123";
  String Date = DateFormat.yMMMd().format(DateTime.now());
  String Time = DateFormat.jm().format(DateTime.now());
  String Location = "GZB";

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                  child: Column(children: [
                Container(),
                SizedBox(
                  height: 20,
                ),
                const Text("Successful!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 32,
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w700,
                    )),
                SizedBox(
                  height: 20,
                ),
              ])),
              SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  const ListTile(
                    title: Text(
                      "Transaction Details",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                  ),
                  // Container(
                  //   decoration: BoxDecoration(
                  //       border: Border(bottom: BorderSide(color: Colors.black))),
                  // ),
                  Divider(
                    color: Colors.black12,
                    indent: 20,
                    endIndent: 20,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Paid to",
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text("Amount", style: TextStyle(fontSize: 16)),
                          SizedBox(
                            height: 10,
                          ),
                          Text("Trans Id", style: TextStyle(fontSize: 16)),
                          SizedBox(
                            height: 10,
                          ),
                          Text("Date", style: TextStyle(fontSize: 16)),
                          SizedBox(
                            height: 10,
                          ),
                          Text("Time", style: TextStyle(fontSize: 16)),
                          SizedBox(
                            height: 10,
                          ),
                          Text("Location", style: TextStyle(fontSize: 16)),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            ": ${userName}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            ": ₹${Amount}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            ": ${TrId}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            ": ${Date}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            ": ${Time}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            ": ${Location}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Icon(
                    Icons.verified_user_outlined,
                    color: Colors.green,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                    child: Text("Pin Verified"),
                    alignment: Alignment.center,
                  ),
                  Padding(padding: EdgeInsets.all(12.5)),
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 20),
          child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const RootPage()));
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  "Home",
                  style: TextStyle(fontSize: 20),
                ),
              )),
          color: Colors.lightBlue,
        ),
      ],
    );
  }
}

//UPI URL
//upi://pay?pa=UPIID@oksbi&amp;pn=FNAME SNAME K&amp;cu=INR
