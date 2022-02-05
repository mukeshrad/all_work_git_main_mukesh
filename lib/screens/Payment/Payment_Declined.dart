import 'package:finandy/screens/Payment/Bil_Pay.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PaymentDeclined extends StatefulWidget {
  const PaymentDeclined({Key? key}) : super(key: key);

  @override
  _PaymentDeclinedState createState() => _PaymentDeclinedState();
}

class _PaymentDeclinedState extends State<PaymentDeclined> {
  @override
  Widget build(BuildContext context) {

    return  Scaffold(
        backgroundColor: Colors.white,
    body : Column(

      mainAxisAlignment: MainAxisAlignment.spaceBetween,

      children: [
        Spacer(),
        Container(

          // height: 200,

          child: Column(

            children: [

              Container(

                margin: EdgeInsets.only(top: 20,bottom: 20),
                child: Image.asset("asset/Paymenticon/ci_error.png", height: 50,width: 50,),

              ),
              Text("Payment Declined",style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold)),
            SizedBox(
            height: 20,
            ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(left: 20,right: 20),
                child:   Text("Your Transaction failed due to some technical issues, in case the Amount gets deducted , you will get a refund within 24 Hrs.",textAlign: TextAlign.center,style: const TextStyle(color: Colors.black,fontSize: 17))
                ,
              )
            ],
          ),
        ),
        Spacer(),
        // Expanded(child: Container()),
        // Spacer()
        TextButton(
          onPressed: () {
            Navigator.pop(context);
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
