import 'package:finandy/constants/texts.dart';
import 'package:finandy/utils/credit_card.dart';
import 'package:flutter/material.dart';

import 'card_activation.dart';

class VerificationSuccess extends StatelessWidget {
  const VerificationSuccess({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(left: 10, right: 10, top: 70, bottom: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
           children: [
             Column(
               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
               children: [
                 Card(
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 7),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          height: 60,
                          width: 80,
                          child: Image.asset("assets/images/congo.png", fit: BoxFit.contain,)
                        ),
                        const SizedBox(height: 3,),
                         Text(congo,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 19
                          ),
                        ),
                        const SizedBox(height: 3,),
                        Text(cardLimitTxt,
                          style: const TextStyle(
                            fontSize: 15
                          ),
                        ),
                        const SizedBox(height: 3,),
                        const Text(
                          "₹ 1000",
                          style: TextStyle(
                            fontSize: 23
                          ),
                        )
                      ],
                    ),
                  ), 
                 ),
             Padding(
               padding: const EdgeInsets.symmetric(vertical:3.0),
               child: Text(congoText,
                 softWrap: true,
                 style: const TextStyle(
                   fontSize: 14,
                 ),
               ),
             ),
             const UptrackCard(bankName: "Bank Name", cardNumber: "1212 1212 1212 1212", cardType: "Card Type", expiry: "02/26",ownerName: "Shivam",),
               ],
             ),
             Container(
                   margin: const EdgeInsets.symmetric(horizontal: 15),
                   child: ElevatedButton(onPressed: (){Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const CardActivation()));},
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                     ),
                     child: const Padding(
                       padding: EdgeInsets.all(15.0),
                       child: Text("Activate Card", style: TextStyle(fontSize: 20),),
                     ) 
                ),
              ),
           ], 
        ),
      ),
    );
  }
}