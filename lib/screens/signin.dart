import 'package:finandy/constants/texts.dart';
import 'package:finandy/screens/otp_verify.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/src/provider.dart';
import 'package:sms_autofill/sms_autofill.dart';

import 'package:finandy/modals/customer.dart';
import 'package:finandy/screens/personal_info.dart';
import 'package:swagger/api.dart';

class SignUpScreen extends StatefulWidget {
  static String id = "signin";
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}
class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isChecked = false;
  var _phone;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
          child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                    Text(
                      getStarted,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Color(0xff141414),
                        fontSize: 32,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w700,
                      )),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:  [    
                     const SizedBox(height: 10),
                     Text(
                        ladderInfo,
                        textAlign: TextAlign.center,
                        style:  const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                     const SizedBox(height: 50,),  
                      Form(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        key: _formKey,
                        child:  TextFormField(
                              keyboardType: TextInputType.number,
                              maxLengthEnforcement: MaxLengthEnforcement.enforced,
                              maxLength: 10,
                              decoration:  InputDecoration(
                                border: const OutlineInputBorder(),
                                labelText: mobile,
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
                       Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(onlyAadhar),
                      ) 
                    ],
                  ),
                  const SizedBox(height: 250,),
                  ElevatedButton(
                   onPressed: () async{
                     if(_formKey.currentState!.validate()){
                       _formKey.currentState!.save();
                      final signature = await SmsAutoFill().getAppSignature;
                        context.read<Customer>().setPhone(_phone);
                        context.read<Customer>().setUserState(UserState.PhoneEntered);
                          
                          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const OTPverify(fromPage: "signin",)));
                     }else {
                       return;
                     }
                   },
                  style: ElevatedButton.styleFrom(
                    alignment: Alignment.bottomCenter,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                   ),
                   child: Padding(
                   padding: const EdgeInsets.all(10.0),
                   child: Text(signin, style: const TextStyle(fontSize: 18),),
                   ) 
                     )
                ],
              ),
        ),
      ) 
    );
  }
}