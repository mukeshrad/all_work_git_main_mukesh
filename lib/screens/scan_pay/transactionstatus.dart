import 'dart:async';

import 'package:finandy/screens/root_page.dart';
import 'package:flutter/material.dart';

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
      body: SingleChildScrollView(
        child: Container(
          margin:
              const EdgeInsets.only(left: 25, right: 25, top: 30, bottom: 90),
          child: SuccessPage(),
        ),
      ),
    );
  }
}

class PendingPage extends StatefulWidget {
  @override
  _PendingPage createState() => _PendingPage();
}

class _PendingPage extends State<PendingPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Text("Pending");
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
  String Date = new DateTime.now().toString();
  // var formatter = new DateFormat('yyyy-MM-dd');
  //  = formatter.format(now);
  String Time = DateTime.now().toString();
  String Location = "GZB";

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
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
          Text(
            "Transaction Successfull",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black26,
              fontSize: 16,
              fontFamily: "Inter",
              fontWeight: FontWeight.w500,
            ),
          ),
        ])),
        SizedBox(
          height: 20,
        ),
        Card(
          elevation: 6,
          child: Column(
            children: [
              const ListTile(
                title: Text(
                  "Details",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.black))),
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Paid to",
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text("Amount", style: TextStyle(fontSize: 16)),
                      SizedBox(
                        height: 5,
                      ),
                      Text("Trans Id", style: TextStyle(fontSize: 16)),
                      SizedBox(
                        height: 5,
                      ),
                      Text("Date", style: TextStyle(fontSize: 16)),
                      SizedBox(
                        height: 5,
                      ),
                      Text("Time", style: TextStyle(fontSize: 16)),
                      SizedBox(
                        height: 5,
                      ),
                      Text("Location", style: TextStyle(fontSize: 16)),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        ": ${userName}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        ": ${Amount}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        ": ${TrId}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        ": ${Date}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        ": ${Time}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      SizedBox(
                        height: 5,
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
              Padding(padding: EdgeInsets.all(5))
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Icon(Icons.verified_user_outlined),
        SizedBox(
          height: 10,
        ),
        Align(
          child: Text("Pin Verified"),
          alignment: Alignment.center,
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
        ),
      ],
    );
  }
}

//UPI URL
//upi://pay?pa=UPIID@oksbi&amp;pn=FNAME SNAME K&amp;cu=INR
