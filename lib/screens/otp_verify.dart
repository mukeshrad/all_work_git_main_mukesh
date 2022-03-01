import 'package:finandy/constants/instances.dart';
import 'package:finandy/constants/texts.dart';
import 'package:finandy/modals/bill.dart';
import 'package:finandy/modals/card_schema.dart';
import 'package:finandy/modals/customer.dart';
import 'package:finandy/screens/personal_info.dart';
import 'package:finandy/screens/profileBuildingPage.dart';
import 'package:finandy/screens/rootPageScreens/root_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:swagger/api.dart';

class OTPverify extends StatefulWidget {
  static String id = "otp";
  final String fromPage;
  const OTPverify({ Key? key, required this.fromPage }) : super(key: key);

  @override
  _OTPverifyState createState() => _OTPverifyState();
}

class _OTPverifyState extends State<OTPverify> {
  bool isVerifying = true;
  String otp = "";

  @override
  void initState(){
    super.initState();
    WidgetsBinding.instance!
        .addPostFrameCallback((_) => widget.fromPage == "pinfo" ? getVerifiedNewUser(context): getVerified(context));
  }
 
  @override
  void dispose(){
     SmsAutoFill().unregisterListener();
     super.dispose();  
  }

  getVerifiedNewUser(ctx) async{
     setState(() {
       isVerifying = true;
     });
    //AAdhar verification
    try {
      apiClient.addDefaultHeader("Client-Secret", clientSecret);
      // final UsersSendotpBody body = UsersSendotpBody.fromJson({ 
      //       'client_id': clientId,
      //       "phone_number": Provider.of<Customer>(context, listen: false).primaryPhoneNumber
      //     });                  
          // final res = await userApi.v1UsersSendOtpPost(body);
          // var code = res!.otp; 
          // final UsersOnboarduserBody onboarduserBody = UsersOnboarduserBody.fromJson({
          //   'client_id': clientId,
          //   'phone_number': Provider.of<Customer>(context, listen: false).primaryPhoneNumber,
          //   'otp': code,
          // });
          // final res1 = await userApi.v1UsersOnBoardUserPost(onboarduserBody);   
          // final token = res1!.token.toString();       
          // final userId = res1.user.clientCustomerId; 
      
      UserResponse userBody = UserResponse.fromJson({
              "customer_name": Provider.of<Customer>(context, listen: false).customerName,
              "gender": Provider.of<Customer>(context, listen: false).gender,
              "dob": Provider.of<Customer>(context, listen: false).dateOfBirth.toString(),
              'primary_phone_number': Provider.of<Customer>(context, listen: false).primaryPhoneNumber,
              'client_id': clientId,
              // 'image_url': instance.imageUrl,
              'client_customer_id': userId,
            }
      );
          
          apiClient.addDefaultHeader("Client-Secret", "");
          final res2 = await userApi.v1UsersUserIdPut(userId, body: userBody);
        
            SharedPreferences preferences = await SharedPreferences.getInstance();
            preferences.setString("userId", userId);
            Provider.of<Customer>(context, listen: false).setCustomer(res2.toJson(), UserState.AadharVerified);
            final response = await cardsApi.v1UsersUserIdCardsPost(userId);
            AadharGenerateOTPBody generateOTPBody = AadharGenerateOTPBody.fromJson({
                'entered_name': res2.customerName,
                'aadhaar_number': Provider.of<Customer>(context).aadharNo,
                'is_consented': true,
                'consent_text': "lorem ipsum",
                'consent_time': (DateTime.now().millisecondsSinceEpoch/1000).toString()
            });
            await SmsAutoFill().listenForCode();
            final res3 = await aadharVerificationApi.v1AadharVerificationOTPRequest(userId, generateOTPBody: generateOTPBody); 
            AadhaarOTPValidate otpValidateBody = AadhaarOTPValidate.fromJson({
              'aadhaar_number': Provider.of<Customer>(context).aadharNo,
              'otp': otp,
              'access_key': res3!.accessKey,
              'is_consented': true,
            });
            final res4 = await aadharVerificationApi.v1AadharVerificationOTPValidate(userId, otpValidateBody: otpValidateBody);
            if(res4!.isValidated == true){
                Provider.of<CardSchema>(context, listen: false).setCardDetails(json: response!.toJson(), name: Provider.of<Customer>(context, listen: false).customerName);
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const ProfileBuilding()));
            }else{
              setState(() {
                isVerifying = false;
              });
            }
    } catch (e, stack) {
       setState(() {
         isVerifying = false;
       });
       print("\n${e}\n${stack}\n\n");
    }
  }

  getVerified(ctx) async{
    setState(() {
       isVerifying = true;
     });
     try {
       // await SmsAutoFill().listenForCode();
      apiClient.addDefaultHeader("Client-Secret", clientSecret);
      final UsersSendotpBody body = UsersSendotpBody.fromJson({ 
            'client_id': clientId,
            "phone_number": Provider.of<Customer>(context, listen: false).primaryPhoneNumber
          });                  
          final res = await userApi.v1UsersSendOtpPost(body);
          var code = res.otp;
          final UsersOnboarduserBody onboarduserBody = UsersOnboarduserBody.fromJson({
            'client_id': clientId,
            'phone_number': Provider.of<Customer>(context, listen: false).primaryPhoneNumber,
            'otp': code,
          });
          final res1 = await userApi.v1UsersOnBoardUserPost(onboarduserBody);   
          final token = res1.token.toString();
          final userId = res1.user.clientCustomerId; 
          final String name = res1.user.customerName.toString();

          SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
              sharedPreferences.setString("token", token);
              sharedPreferences.setString("userId", userId!);
              apiClient.setAccessToken(token);   
              
            if(name != "null"){
              Provider.of<Customer>(context, listen: false).setCustomer(res1.user.toJson(), UserState.OTPVerified);
              final userDetails = await userApi.v1UsersUserDetailsGet(userId);
              
              Provider.of<CardSchema>(context, listen: false).setCardDetails(json: userDetails.cards![0].toJson(), name: Provider.of<Customer>(context, listen: false).customerName);
              Provider.of<BillSchema>(context, listen: false).setBill(userDetails.bill!.toJson());
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const RootPage()), (route) => false);   
          }else{
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const PersonalInfo()));
          }
     } catch (e, stack) {
       setState(() {
          isVerifying = false;
        });
       print("\n${e}\n${stack}\n\n");
     }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: SingleChildScrollView(
         child: Stack(
           fit: StackFit.loose, 
           children: [
             if(isVerifying) 
               Container(
                 color: Colors.grey,
                 height:  MediaQuery.of(context).size.height,
                 width:  MediaQuery.of(context).size.width,
                 child: const Center(
                   child: CircularProgressIndicator(
                      color: Color(0xff0d406a),
                    ),
                 ),
               ),
             Container(
             margin: const EdgeInsets.symmetric(horizontal: 10),
             child: Column(
               mainAxisAlignment: MainAxisAlignment.center,
               crossAxisAlignment: CrossAxisAlignment.stretch,
               children: [
                   const SizedBox(
                     height: 170,
                   ),
                   Center(
                     child: Container(
                       padding: const EdgeInsets.only(top: 10, bottom: 5),
                       child: const Text(
                         otpVerify,
                         style: TextStyle(
                           fontWeight: FontWeight.bold,
                           fontSize: 28,
                         ),
                       ),
                     ),
                   ),
                   const Padding(
                     padding: EdgeInsets.all(5),
                     child: Text(otpVerifyText, 
                       softWrap: true,
                       style: TextStyle(fontSize: 15),
                       textAlign: TextAlign.center,
                     ),
                   ),
                   Container(
                     margin: const EdgeInsets.only(bottom: 20, top: 80, left: 20, right: 20),
                     child:  PinFieldAutoFill(
                       enableInteractiveSelection: false,
                       keyboardType: TextInputType.none,
                      decoration: const BoxLooseDecoration(
                        gapSpace: 3.5,
                        textStyle: TextStyle(fontSize: 20, color: Colors.black),
                        strokeColorBuilder: FixedColorBuilder(Colors.black87),
                      ),
                      currentCode: "     ",
                      codeLength: 6,
                      onCodeSubmitted: (code) {},
                      onCodeChanged: (code) {
                        if (code!.length == 6) {
                          FocusScope.of(context).requestFocus(FocusNode());
                          setState(() {
                            otp = code;
                          });
                        }
                     },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(right: 20, left: 20, top: 20, bottom: 10),
                  child: ElevatedButton(onPressed: () {}, 
                     style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                     child: const Padding(
                       padding: EdgeInsets.all(10.0),
                       child: Text(submit, style: TextStyle(fontSize: 20),),
                     ) 
                     ),
                ),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     const Text(didNotVerify,
                       style: TextStyle(
                                fontSize: 16,
                                 ),
                     ),
                     GestureDetector(
                       child: const Text(resendOtp,
                              style: TextStyle(
                                fontSize: 16,
                                color: Color(0xff315d80)
                                 ),
                                ),
                       onTap: (){ 
                               if(!isVerifying){
                                   widget.fromPage == "pinfo" ? getVerified(context) : getVerifiedNewUser(context);
                                 }
                             },
                     ),
                   ],
                 )
               ],
             ),
           ),
         ]),
       ),
    );
  }
}