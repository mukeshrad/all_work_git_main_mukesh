import 'package:finandy/constants/instances.dart';
import 'package:finandy/constants/texts.dart';
import 'package:finandy/modals/card_schema.dart';
import 'package:finandy/modals/customer.dart';
import 'package:finandy/screens/agreement.dart';
import 'package:finandy/screens/otp_error.dart';
import 'package:finandy/screens/personal_info.dart';
import 'package:finandy/screens/root_page.dart';
import 'package:finandy/screens/signin.dart';
import 'package:flutter/cupertino.dart';
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
  bool isOtpRecieved = false;

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

    //AAdhar verification
    try {
      apiClient.addDefaultHeader("Client-Secret", clientSecret);
      final UsersSendotpBody body = UsersSendotpBody.fromJson({ 
            'client_id': clientId,
            "phone_number": Provider.of<Customer>(context, listen: false).primaryPhoneNumber
          });                  
          final res = await userApi.v1UsersSendOtpPost(body);
          var code = res!.otp; 
          final UsersOnboarduserBody onboarduserBody = UsersOnboarduserBody.fromJson({
            'client_id': clientId,
            'phone_number': Provider.of<Customer>(context, listen: false).primaryPhoneNumber,
            'otp': code,
          });
          final res1 = await userApi.v1UsersOnBoardUserPost(onboarduserBody);   
          final token = res1!.token.toString();       
          final userId = res1.user.id; 
      // await SmsAutoFill().listenForCode();
      
      // Map<String, dynamic> mp = {
      //         "customer_name": Provider.of<Customer>(context, listen: false).customerName,
      //         "current_address": Provider.of<Customer>(context, listen: false).currentAddress,
      //         "gender": Provider.of<Customer>(context, listen: false).gender,
      //         "date_of_birth": Provider.of<Customer>(context, listen: false).dateOfBirth,
      //       };
      UserResponse userBody = UserResponse.fromJson({
              "_id": userId,
              "customer_name": Provider.of<Customer>(context, listen: false).customerName,
              "gender": Provider.of<Customer>(context, listen: false).gender,
              "dob": Provider.of<Customer>(context, listen: false).dateOfBirth.toString(),
              'primary_phone_number': Provider.of<Customer>(context, listen: false).primaryPhoneNumber,
              'client_id': clientId,
              // 'image_url': instance.imageUrl,
              'client_customer_id': userId,
              'email': res1.user.email,
              'current_address': res1.user.currentAddress,
              'is_verified': res1.user.isVerified,
              'customer_preference': res1.user.customerPreference,
              'professional_info': res1.user.professionalInfo,
              'notification_preference': res1.user.notificationPreference,
            }
      );
          SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
          sharedPreferences.setString("token", token);
          sharedPreferences.setString("userId", userId);
          apiClient.addDefaultHeader("Client-Secret", "");
          apiClient.setAccessToken(token);
          final res2 = await userApi.v1UsersUserIdPut(userId, body: userBody);
        
            SharedPreferences preferences = await SharedPreferences.getInstance();
            preferences.setString("token", token);
            preferences.setString("userId", userId);
            Provider.of<Customer>(context, listen: false).setCustomer(res2!.toJson(), UserState.OTPVerified);
            final response = await cardsApi.v1UsersUserIdCardsPost(userId);
        
            Provider.of<CardSchema>(context, listen: false).setCardDetails(json: response!.toJson(), name: Provider.of<Customer>(context, listen: false).customerName);
         showVerifiedModal(context, const Agreement());
    } catch (e, stack) {
       Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const OTPError(toPage: PersonalInfo())));
       print("\n${e}\n${stack}\n\n");
    }
  }

  getVerified(ctx) async{
     try {
       // await SmsAutoFill().listenForCode();
      apiClient.addDefaultHeader("Client-Secret", clientSecret);
      final UsersSendotpBody body = UsersSendotpBody.fromJson({ 
            'client_id': clientId,
            "phone_number": Provider.of<Customer>(context, listen: false).primaryPhoneNumber
          });                  
          final res = await userApi.v1UsersSendOtpPost(body);
          var code = res!.otp; 
          final UsersOnboarduserBody onboarduserBody = UsersOnboarduserBody.fromJson({
            'client_id': clientId,
            'phone_number': Provider.of<Customer>(context, listen: false).primaryPhoneNumber,
            'otp': code,
          });
          final res1 = await userApi.v1UsersOnBoardUserPost(onboarduserBody);   
          final token = res1!.token.toString();       
          final userId = res1.user.id; 
          final String name = res1.user.customerName.toString();
             
            if(name != "null"){
              SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
              sharedPreferences.setString("token", token);
              sharedPreferences.setString("userId", userId);
              apiClient.setAccessToken(token);
              Provider.of<Customer>(context, listen: false).setCustomer(res1.user.toJson(), UserState.OTPVerified);
              final response = await cardsApi.v1UsersUserIdCardsPost(userId);
              
              Provider.of<CardSchema>(context, listen: false).setCardDetails(json: response!.toJson(), name: Provider.of<Customer>(context, listen: false).customerName);
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const RootPage()), (route) => false);   
          }else{
             showVerifiedModal(ctx, const PersonalInfo());  
          }
     } catch (e, stack) {
       Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const OTPError(toPage: SignUpScreen())));
       print("\n${e}\n${stack}\n\n");
     }
  }

  showVerifiedModal(ctx, Widget route){
   return showDialog(
            context: ctx,
            builder: (BuildContext context) {
              return Card(
                elevation: 10,
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 100),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                child: SizedBox(
                  width: 250,
                  height: 400,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        child: Icon(CupertinoIcons.checkmark_alt_circle_fill, size: 75, color: Colors.green[400],),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 15),
                        child: const Text("OTP Verified", 
                           style: TextStyle(
                             fontWeight: FontWeight.bold,
                             fontSize: 25
                           ),
                           ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                        child: const Text("Kindly spare a few moments for us. We need to know you better", 
                           style: TextStyle(
                             fontSize: 20
                           ),
                           ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 15),
                        child: ElevatedButton(onPressed: (){
                          print(Provider.of<Customer>(context, listen: false).clientId);
                          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => route));},
                           style: ElevatedButton.styleFrom(
                             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text("Start Now", style: TextStyle(fontSize: 20),),
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
            },
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: SingleChildScrollView(
         child: Container(
           margin: const EdgeInsets.symmetric(horizontal: 10),
           child: Column(
             children: [
               Container(
                 margin: const EdgeInsets.only(top: 70, bottom: 30, left: 20, right: 20),
                 child: const Placeholder(fallbackHeight: 275, fallbackWidth: 75,)
                 ),
                 Container(
                   padding: const EdgeInsets.symmetric(vertical: 10),
                   child: const Text(
                     "OTP Verification",
                     style: TextStyle(
                       fontWeight: FontWeight.bold,
                       fontSize: 22,
                     ),
                   ),
                 ),
                 const Padding(
                   padding: EdgeInsets.all(5),
                   child: Text("An OTP sent on your mobile number please verify", 
                     style: TextStyle(fontSize: 15),
                     textAlign: TextAlign.center,
                   ),
                 ),
                 Container(
                   margin: const EdgeInsets.only(bottom: 20, top: 10, left: 20, right: 20),
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
                   child: Padding(
                     padding: const EdgeInsets.all(12.0),
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.center, 
                       children: const [
                         Text("Submit", style: TextStyle(fontSize: 20),),
                         SizedBox(width: 10,),
                         Icon(Icons.arrow_forward_sharp)
                       ],
                     ),
                   ) 
                   ),
              ),
               GestureDetector(
                 child: const Text("Resend OTP",style: TextStyle(fontSize: 16),),
                 onTap: (){widget.fromPage == "pinfo" ? getVerified(context) : getVerifiedNewUser(context);},
               )
             ],
           ),
         ),
       ),
    );
  }
}