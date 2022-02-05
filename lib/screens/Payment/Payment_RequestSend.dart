import 'dart:async';

import 'package:finandy/screens/Payment/Bil_Pay.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PaymentRequestSend extends StatefulWidget {
  const PaymentRequestSend({Key? key}) : super(key: key);

  @override
  _PaymentRequestSendState createState() => _PaymentRequestSendState();
}

class _PaymentRequestSendState extends State<PaymentRequestSend> {

  Timer? timer;
  int counter = 0;
  int totalSecondsExpire = 120;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateTimer();

    // timer = Timer.periodic(const Duration(seconds: 15), (Timer t) => updateTimer());

  }

  updateTimer(){

    timer = Timer.periodic(Duration(seconds: 1), (timer) {

      counter ++;



      print(counter);
      if (counter == totalSecondsExpire) {
        timer.cancel();
      }

      setState(() {

      });

    });



  }





  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          // elevation: 0,
          // leading: BackButton(color: Colors.black),
          automaticallyImplyLeading: false,

          title: const Text(
            "Request Sent",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body : Column(

          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Spacer(),
            Container(

              // height: 200,

              child: Column(

                children: [

                  Container(
                      padding: const EdgeInsets.only(left: 80,right: 80),
                      alignment: Alignment.center,

                      child: const Text("Payment Request Sent Successfully",textAlign: TextAlign.center,style: TextStyle(color: appBlackColor,fontSize: 24,fontWeight: FontWeight.bold))),
                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(left: 60,right: 60),
                    child: const Text("Kindly open your Payment Application , as the request for the Payment has been sent to it.",textAlign: TextAlign.center,style: TextStyle(color: appBlackColor,fontSize: 16,fontWeight: FontWeight.normal))
                    ,
                  )

                ],
              ),
            ),
            Spacer(),
            // Expanded(child: Container()),

            // Spacer()
            Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(counter != totalSecondsExpire ? "The Payment Link will expire in  " : "The Payment Link expired",textAlign: TextAlign.center,style: TextStyle(color: appBlackColor,fontSize: 14,fontWeight: FontWeight.normal)),
                  Text(counter != totalSecondsExpire ? (totalSecondsExpire-counter).toString() + " Sec.": "",textAlign: TextAlign.center,style: TextStyle(color: appBlackColor,fontSize: 16,fontWeight: FontWeight.normal,    decoration: TextDecoration.underline,
                  ))
                ],
              ),

            ),
            TextButton(
              onPressed: () {
                // Navigator.pop(context);

                timer?.cancel();
                counter = 0;
                updateTimer();


              },
              child: Container(
                // height: 50,
                margin: const EdgeInsets.only(left: 25, right: 25, bottom: 30, top: 5),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: appBlueGColor, borderRadius: BorderRadius.circular(10)),
                child: const Padding(
                  padding:
                  EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  child: Center(

                    // PaymentDeclined
                      child: Text(
                        'Try Again',
                        style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.normal),
                      )),
                ),
              ),
            ),


          ],


        )
    );
  }


}
