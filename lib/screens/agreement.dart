import 'package:finandy/screens/profileBuildingPage.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Agreement extends StatefulWidget {
  const Agreement({ Key? key }) : super(key: key);

  @override
  _AgreementState createState() => _AgreementState();
}

class _AgreementState extends State<Agreement> {
  bool checkValue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(right: 10, left: 10, top: 50, bottom: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Checkbox(
                  value: checkValue, onChanged: (ch){
                    setState(() {
                      checkValue = !checkValue;
                    });
                  }),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(5),
                        child: const Text("I hereby appoint Ladder as my authorised\nrepresentative to receive my credit\ninformation from Cibil/Equifax/Experian.",
                          softWrap: true,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(5),
                        child: RichText(
                          textAlign: TextAlign.start,
                          maxLines: 4, softWrap: true,
                          text: TextSpan(
                            style: const TextStyle(color: Colors.black),
                            children: [
                              const TextSpan(text: "Info About Using data for Cibil Check.\nCredit Score ",),
                              TextSpan(text: "Terms of Use", 
                                style: const TextStyle(
                                  decoration: TextDecoration.underline,
                                fontWeight: FontWeight.w700,
                              ),
                              recognizer: TapGestureRecognizer()..onTap = () async{
                                final url = '';
                                if (await canLaunch(url)) {
                                  await launch(
                                    url,
                                    enableJavaScript: true,
                                  );
                                }
                              }),
                            const TextSpan(text: ",\nand "),
                            TextSpan(text: "Privacy Policy",
                             style: const TextStyle(
                               decoration: TextDecoration.underline,
                               fontWeight: FontWeight.w700,
                             ), 
                             recognizer: TapGestureRecognizer()..onTap = () async{
                               final url = '';
                              if (await canLaunch(url)) {
                                await launch(
                                  url,
                                  enableJavaScript: true,
                                );
                              }
                            })
                          ]
                        ),),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Container(
                        margin: const EdgeInsets.symmetric(vertical: 20),
                        child: ElevatedButton(onPressed: checkValue ? (){
                                 Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const ProfileBuilding()));} : (){},
                           style: ElevatedButton.styleFrom(
                             primary: checkValue ? Theme.of(context).primaryColor : Colors.grey,
                             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                          child: const Padding(
                            padding:  EdgeInsets.all(15.0),
                            child: Text("Submit", style: TextStyle(fontSize: 20),),
                          ) 
                     ),
                  ),
          ],
        ), 
      ),
    );
  }
}