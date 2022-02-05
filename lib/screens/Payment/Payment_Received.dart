import 'package:finandy/screens/Payment/Bil_Pay.dart';
import 'package:finandy/screens/Upi%20Payment/src/response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PaymentReceived extends StatefulWidget {

  final UpiPaymentResponse paymenData;
  final String isFrome;

  const PaymentReceived({Key? key,required this.paymenData, required this.isFrome}) : super(key: key);

  @override
  _PaymentReceivedState createState() => _PaymentReceivedState();
}

class _PaymentReceivedState extends State<PaymentReceived> {

  var paymentListName = ['Received Amount', 'Card Number', 'Trans Id','Date', 'Time', 'Location'];
  var paymentListNameValue = ['₹ 2,100', '1234 5678 9012', '8wqyeu9q990','Nov 20, 2021', '11:30 AM', 'Gurugram'];

  late UpiPaymentResponse paymentDetails;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {

      paymentDetails = widget.paymenData;

      paymentListNameValue[0] = paymentDetails.amount.toString();
      paymentListNameValue[1] = paymentDetails.cardNumber.toString();
      paymentListNameValue[2] = paymentDetails.transID.toString();
      paymentListNameValue[3] = paymentDetails.date;
      paymentListNameValue[4] = paymentDetails.time;
      paymentListNameValue[5] = paymentDetails.location;

    });
  }



  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        backgroundColor: appWhiteColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          // elevation: 0,
          leading: GestureDetector(
            onTap: (){
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/', (Route<dynamic> route) => false);
            },
            child: BackButton(color: Colors.black),
          ),
          // automaticallyImplyLeading: false,

          title: const Text(
            "Payment Received",
            style: TextStyle(color: appBlackColor),
          ),
        ),
        body : SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(top: 20,bottom: 20),
                height: 84,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(32)),
                child: Image.asset("asset/Paymenticon/verifyed.png",width: 64,height: 64,),

              ),
              Column(

                children: [

                  Container(
                    height: 70,
                      padding: const EdgeInsets.only(left: 80,right: 80),
                      alignment: Alignment.center,

                      child: const Text("Payment Received Successfully",textAlign: TextAlign.center,style: TextStyle(color: appBlackColor,fontSize: 24,fontWeight: FontWeight.bold))),
                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                    height: 20,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(left: 60,right: 60),
                    child: const Text("Transaction Successfull",textAlign: TextAlign.center,style: TextStyle(color: appBlackColor,fontSize: 16,fontWeight: FontWeight.normal))
                    ,
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  Card(
                    elevation: 4,

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: const EdgeInsets.only(left: 20,right: 20),
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [

                              Padding(  padding: const EdgeInsets.only(left: 20,bottom: 16,top: 20),
                              child: Text("Details",textAlign: TextAlign.center,style: TextStyle(color: appBlackColor,fontSize: 16,fontWeight: FontWeight.bold))),
                              Container(
                                margin: EdgeInsets.only(left: 20,right: 20),
                                height: 1,
                                color: appGreyColor,
                              ),

                              const SizedBox(
                                height: 10,
                              ),


                              Container(
                                height: paymentListName.length*30,
                                margin: EdgeInsets.only(left: 20,right: 20),
                                child: ListView.builder(
                                  // Let the ListView know how many items it needs to build.
                                  itemCount: paymentListName.length,
                                  // Provide a builder function. This is where the magic happens.
                                  // Convert each item into a widget based on the type of item it is.
                                  itemBuilder: (context, index) {
                                    final item = paymentListName[index];
                                    final itemvalue = paymentListNameValue[index];
                                    return Container(

                                      height: 30,
                                      // color: appBlackColor,
                                      child: Row(

                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(item + " : ",textAlign: TextAlign.center,style: TextStyle(color: appGreyDarkColor,fontSize: 14,fontWeight: FontWeight.normal)),
                                          // Text((" "+itemvalue),textAlign: TextAlign.right,
                                          //     overflow: TextOverflow.ellipsis,
                                          //     softWrap: false,style: TextStyle(color: appBlackColor,fontSize: 14,fontWeight: FontWeight.bold)),
                                          Flexible(
                                            child: Text(
                                              " "+itemvalue,
                                              textAlign: TextAlign.center,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines:2,
                                              style: const TextStyle(color: appBlackColor,fontSize: 14,fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          // Text(" "+itemvalue,textAlign: TextAlign.center,style: TextStyle(color: appBlackColor,fontSize: 14,fontWeight: FontWeight.normal)),
                                    ],
                                      ),
                                    );
                                  },
                                ),
                              ),

                              const SizedBox(
                                height: 10,
                              ),

                            ],
                          ),
                        )
                      ],
                    )
                  ),
                  const SizedBox(
                    height: 30,
                  ),

                ],
              ),
              // Spacer()
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children:  [

                  Container(
                    alignment: Alignment.center,
                    height: 30,
                    width: 30,
                    // padding: const EdgeInsets.only(left: 60,right: 60),
                    child: SvgPicture.asset(
                      'asset/Paymenticon/carbon_security.svg',
                      width: 70,
                      alignment: Alignment.centerLeft,
                    ),

                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text("Pin Verified",textAlign: TextAlign.center,style: TextStyle(color: appBlackColor,fontSize: 16,fontWeight: FontWeight.normal,
                  ))
                ],
              ),
              TextButton(
                onPressed: () {

                  Navigator.of(context).pushNamedAndRemoveUntil(
                      '/', (Route<dynamic> route) => false);
                  },
                child: Container(
                  // height: 50,
                  margin: const EdgeInsets.only(left: 25, right: 25, bottom: 30, top: 10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      // widget.isFrome == "isFrome" ? appGreyColor : appBlueGColor
                      color: appBlueGColor, borderRadius: BorderRadius.circular(10)),
                  child: const Padding(
                    padding:
                    EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    child: Center(
                        child: Text(
                          'Home',
                          style: TextStyle(color: appWhiteColor,fontSize: 20,fontWeight: FontWeight.normal),
                        )),
                  ),
                ),
              ),


            ],


          ),
        )
    );
  }
}
