import 'package:finandy/constants/Colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThanksYouCaseBackPage extends StatefulWidget {
  const ThanksYouCaseBackPage({Key? key}) : super(key: key);

  @override
  _ThanksYouCaseBackPageState createState() => _ThanksYouCaseBackPageState();
}

class _ThanksYouCaseBackPageState extends State<ThanksYouCaseBackPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: appWhiteColor,
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: 80),
                height: 84,
                decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(32)),
                child: Image.asset(
                  "assets/images/verifyed.png",
                  width: 64,
                  height: 64,
                ),
              ),
              Container(
                  height: 70,
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  alignment: Alignment.center,
                  child: const Text("Thank You!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: appBlackColor,
                          fontSize: 24,
                          fontWeight: FontWeight.bold))),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(left: 30, right: 30, bottom: 30),
                child: Text(
                  'We will Credit Rs 1 to your everyday card within 24 Hrs.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 16,
                      color: appBlack1Color,
                      fontWeight: FontWeight.normal),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 30, right: 30, bottom: 30),
                height: 280,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top: 40),
                      height: 84,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(32)),
                      child: Image.asset("assets/images/offers.png"),
                    ),
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(top: 30, bottom: 10),
                      child: Text(
                        'You’ve received',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16,
                            color: appBlack1Color,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                    Container(
                        height: 70,
                        padding: EdgeInsets.only(left: 30, right: 30),
                        alignment: Alignment.center,
                        child: Text(
                          "₹ 10",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: appBlackColor,
                              fontSize: 60,
                              fontWeight: FontWeight.bold),
                        ))
                  ],
                ),
              ),
              Container(
                height: 70,
                child: TextButton(
                  onPressed: () async {
                    Navigator.pop(context);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(
                        left: 20, right: 20, bottom: 0, top: 0),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: appBlueGColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: const Padding(
                      padding:
                      EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                      child: Center(
                          child: Text(
                            'Home',
                            style: TextStyle(color: appWhiteColor),
                          )),
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
