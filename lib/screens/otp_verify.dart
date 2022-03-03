import 'package:finandy/constants/instances.dart';
import 'package:finandy/constants/texts.dart';
import 'package:finandy/modals/customer.dart';
import 'package:finandy/screens/personal_info.dart';
import 'package:finandy/screens/profileBuildingPage.dart';
import 'package:finandy/screens/rootPageScreens/root_page.dart';
import 'package:finandy/services/fetch_user_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:swagger/api.dart';

class OTPverify extends StatefulWidget {
  static String id = "otp";
  String? accessKey;
  final String fromPage;
  OTPverify({Key? key, required this.fromPage, this.accessKey})
      : super(key: key);

  @override
  _OTPverifyState createState() => _OTPverifyState();
}

class _OTPverifyState extends State<OTPverify> {
  bool isVerifying = false;
  String otp = "";
  late String _comingSms;
  // TextEditingController controller = TextEditingController();

  // initSmsListener() async {

  //   String comingSms;
  //   try {
  //     comingSms = (await AltSmsAutofill().listenForSms)!;
  //   } on PlatformException {
  //     comingSms = 'Failed to get Sms.';
  //   }
  //   if (!mounted) return;
  //   setState(() {
  //     _comingSms = comingSms;
  //     print("====>Message: ${_comingSms}");
  //     final exp = RegExp(r'(\d{6})');
  //     int idx = comingSms.indexOf(exp);
  //     print(comingSms.substring(idx, idx+6));

  //     controller.text = comingSms.substring(idx, idx+6); //used to set the code in the message to a string and setting it to a textcontroller. message length is 38. so my code is in string index 32-37.
  //   });
  // }controller.text = "";

  @override
  void initState() {
    super.initState();
    // if (widget.fromPage != "pinfo") {
    //   getVerified(context);
    // }
  }

  @override
  void dispose() {
    //  controller.dispose();
    super.dispose();
  }

  getVerifiedNewUser(ctx) async {
    setState(() {
      isVerifying = true;
    });
    //AAdhar verification
    try {
      // apiClient.addDefaultHeader("Client-Secret", clientSecret);
      print(Provider.of<Customer>(context, listen: false).toString());
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? userid = preferences.getString('userId');
      preferences.setString("userId", userid!);

      AadhaarOTPValidate otpValidateBody = AadhaarOTPValidate.fromJson({
        'aadhaar_number':
            Provider.of<Customer>(context, listen: false).aadharNo,
        'otp': otp,
        'access_key': widget.accessKey,
        'is_consented': true,
      });
      final res4 = await aadharVerificationApi.v1AadharVerificationOTPValidate(
          userid,
          otpValidateBody: otpValidateBody);
      if (res4!.isValidated == true) {
        UsersUserIdPutBody userBody = UsersUserIdPutBody.fromJson({
          "customer_name":
              Provider.of<Customer>(context, listen: false).customerName,
          "gender": Provider.of<Customer>(context, listen: false).gender,
          "dob": Provider.of<Customer>(context, listen: false)
              .dateOfBirth
              .toString(),
        });

        // Todo: check for the purpose of update API.
        await userApi.v1UsersUserIdPut(userid, body: userBody);
        await fetchAndUpdateUserDetails(context, userId, UserState.AadharVerified);
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const ProfileBuilding()));
      } else {
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

  getVerified(ctx) async {
    setState(() {
      isVerifying = true;
    });
    try {
      await SmsAutoFill().listenForCode();
      apiClient.addDefaultHeader("Client-Secret", clientSecret);
      var code = widget.accessKey.toString() == 'null' ? otp : widget.accessKey;
      print("$otp ${widget.accessKey} $code");
      final UsersOnboarduserBody onboarduserBody =
          UsersOnboarduserBody.fromJson({
        'client_id': clientId,
        'phone_number':
            Provider.of<Customer>(context, listen: false).primaryPhoneNumber,
        'otp': int.parse(code.toString()),
      });
      // setState(() {
      //   controller.text = code.toString();
      // });
      final res1 = await userApi.v1UsersOnBoardUserPost(onboarduserBody);
      final String token = res1.token.toString();
      final String userId = res1.user.id;
      final String name = res1.user.customerName.toString();

      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setString("token", token);
      sharedPreferences.setString("userId", userId);
      apiClient.setAccessToken(token);

      // Todo: replace name check with aadhaar validation
      if (name != "null") {
        await fetchAndUpdateUserDetails(context, userId, UserState.OTPVerified);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const RootPage()),
            (route) => false);
      } else {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const PersonalInfo()));
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
        child: Stack(fit: StackFit.loose, children: [
          if (isVerifying)
            Container(
              color: Colors.grey,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
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
                  child: Text(
                    otpVerifyText,
                    softWrap: true,
                    style: TextStyle(fontSize: 15),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                      bottom: 20, top: 80, left: 20, right: 20),
                  child: Form(
                    autovalidateMode: AutovalidateMode.disabled,
                    child: PinCodeTextField(
                      beforeTextPaste: (text) {
                        return true;
                      },
                      appContext: context,
                      pastedTextStyle: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      length: widget.fromPage == 'pinfo' ? 6 : 4,
                      // enablePinAutofill: true,
                      obscureText: false,
                      animationType: AnimationType.fade,
                      pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(10),
                          fieldHeight: 50,
                          fieldWidth: 40,
                          inactiveFillColor: Colors.white,
                          inactiveColor: Colors.blueGrey,
                          selectedColor: Colors.blueGrey,
                          selectedFillColor: Colors.white,
                          activeFillColor: Colors.white,
                          activeColor: Colors.blueGrey),
                      cursorColor: Colors.black54,
                      animationDuration: const Duration(milliseconds: 900),
                      enableActiveFill: true,
                      // controller: controller,
                      keyboardType: TextInputType.number,
                      boxShadows: const [
                        BoxShadow(
                          offset: Offset(0, 1),
                          color: Colors.black12,
                          blurRadius: 10,
                        )
                      ],
                      onChanged: (value) {
                        print(value);
                        setState(() {
                          otp = value;
                        });
                      },
                    ),
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      if (widget.fromPage == 'pinfo' && isVerifying == false) {
                        getVerifiedNewUser(context);
                      }else{
                        getVerified(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: otp.length == (widget.fromPage == "pinfo" ? 6 : 4)
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).primaryColor.withOpacity(0.65),
                      alignment: Alignment.bottomCenter,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        submit,
                        style: TextStyle(fontSize: 18),
                      ),
                    )),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      didNotVerify,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    GestureDetector(
                      child: const Text(
                        resendOtp,
                        style:
                            TextStyle(fontSize: 16, color: Color(0xff315d80)),
                      ),
                      onTap: () {
                        if (!isVerifying) {
                         Navigator.of(context).pop();
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
