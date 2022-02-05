import 'package:finandy/utils/credit_card.dart';
import 'package:finandy/utils/main_app_bar.dart';
import 'package:flutter/material.dart';

class ActivateCard extends StatelessWidget {
  const ActivateCard({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mainAppBar(),
      body: Container(
        margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const UptrackCard(bankName: "Bank Name", cardNumber: "XXXX XXXX XXXX XXXX", cardType: "Card Type", expiry: "XX/XX", ownerName: "Shivam",),
            Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: ElevatedButton(onPressed: (){
                    // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const OTPverify()));
                    },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text("Verify and Submit", style: TextStyle(fontSize: 20),),
                          SizedBox(width: 10,),
                          Icon(Icons.arrow_forward_sharp)
                        ],
                      ),
                    ) 
                ),
            ),
          ],
        ),
      ),
    );
  }
}