import 'package:finandy/constants/texts.dart';
import 'package:finandy/screens/otp_verify.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:provider/src/provider.dart';
// import 'package:sms_autofill/sms_autofill.dart';

import 'package:finandy/modals/customer.dart';
import 'package:finandy/screens/personal_info.dart';
import 'package:provider/src/provider.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:swagger/api.dart';
import 'package:url_launcher/url_launcher.dart';

class SignUpScreen extends StatefulWidget {
  static String id = "signin";
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}
class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  bool checkValue = false;
  var _phone;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
          child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                    const SizedBox(height: 45,),
                    const Text(
                      letsGetStarted,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xff141414),
                        fontSize: 32,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w700,
                      )),
                    const SizedBox(height: 10),
                     const Text(
                        ladderInfo,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                  const SizedBox(height: 90,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:  [    
                      Form(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        key: _formKey,
                        child:  TextFormField(
                              keyboardType: TextInputType.number,
                              maxLengthEnforcement: MaxLengthEnforcement.enforced,
                              maxLength: 10,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: mobile,
                                helperText: onlyAadhar
                              ),
                              onSaved: (value){
                                _phone = value;
                              },
                              validator: (value) {
                                if(value!.isEmpty && value.length != 10){
                                  return correctMobile;
                                }
                                return null;
                              },
                            ),
                      ), 
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 15, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Checkbox(
                          checkColor: Colors.white,
                          fillColor: MaterialStateProperty.resolveWith((states) => Colors.red),
                          value: checkValue, onChanged: (ch){
                            setState(() {
                              checkValue = !checkValue;
                            });
                          }),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(5),
                              child: const Text(checkAgreement,
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
                                    const TextSpan(text: cibilData),
                                    TextSpan(text: useTerms, 
                                      style: const TextStyle(
                                        decoration: TextDecoration.underline,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xff093257)
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
                                  const TextSpan(text: And),
                                  TextSpan(text: privacyPolicy,
                                  style: const TextStyle(
                                    decoration: TextDecoration.underline,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xff093257)
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
                      ],
                    ), 
                  ),
                  const SizedBox(height: 45,),
                  ElevatedButton(
                   onPressed: () async{
                     if(_formKey.currentState!.validate() && checkValue == true){
                       _formKey.currentState!.save();
                      final signature = await SmsAutoFill().getAppSignature;
                        context.read<Customer>().setPhone(_phone);
                        context.read<Customer>().setUserState(UserState.PhoneEntered);
                          
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const OTPverify(fromPage: "signin",)));
                     }else {
                       return;
                     }
                   },
                  style: ElevatedButton.styleFrom(
                    primary: checkValue ? Theme.of(context).primaryColor : Theme.of(context).primaryColor.withOpacity(0.65),
                    alignment: Alignment.bottomCenter,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                   ),
                   child: const  Padding(
                   padding: EdgeInsets.all(10.0),
                   child: Text(signin, style: TextStyle(fontSize: 18),),
                   ) 
                     )
                ],
              ),
        ),
      ) 
    );
  }
}