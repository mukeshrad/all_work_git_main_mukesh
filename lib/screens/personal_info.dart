import 'package:finandy/constants/instances.dart';
import 'package:finandy/constants/texts.dart';
import 'package:finandy/modals/customer.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/src/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:swagger/api.dart';

import 'package:finandy/screens/otp_verify.dart';

class PersonalInfo extends StatefulWidget {
  static String id = 'personalInfo';
  const PersonalInfo({ Key? key }) : super(key: key);

  @override
  State<PersonalInfo> createState() => _PersonalInfo();
}

class _PersonalInfo extends State<PersonalInfo> {
  late Image aadharLogo;

  TextEditingController aadharController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  final formKey = GlobalKey<FormState>();
  Position? position;

  int dob = 0;

  TextEditingController pinController = TextEditingController();

  String gender = "";

  String name = "";
  String aadhar = "";

   generateDateFormat(DateTime dateTime){
    int monthNo = dateTime.month; 
    String day = dateTime.day.toString();
    String month = monthNo < 10 ? "0$monthNo" : "$monthNo";   
    String year = dateTime.year.toString();

    String date = "$month/$day/$year";
    return date;
  }

   _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDatePickerMode: DatePickerMode.day,
        initialDate: selectedDate,
        firstDate: DateTime(1945, 1),
        lastDate: DateTime.now()
        );
    if (picked != null && picked != selectedDate) {
      
      setState(() {
        dob = picked.millisecondsSinceEpoch;
        selectedDate = picked;
        dobController.text = generateDateFormat(picked);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    aadharLogo = Image.asset("assets/images/aadharicon.png",);
  }

   @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(aadharLogo.image, context);
  }

  _getPincode(BuildContext context) async {
    try {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    LocationPermission permission = await Geolocator.checkPermission();

    if(!serviceEnabled){
      await Geolocator.openLocationSettings();
    }
    
    if(permission == LocationPermission.denied){
      permission = await Geolocator.requestPermission();
      if(permission == LocationPermission.denied){
        return Future.error("Location permissions are denied");
      }
    }

    if(permission == LocationPermission.deniedForever){
      return Future.error("Location permissions are denied for forever");
    }

    Position geolocation = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
     print(geolocation);
    List<Placemark> placemark = await placemarkFromCoordinates(geolocation.latitude, geolocation.longitude);
    Placemark place = placemark[0];
    
    String? pinCode = place.postalCode;
    setState(() {
      position = geolocation;
      pinController.text = "$pinCode";
    });
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 40, left: 20, right: 20, bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
             children: [
                 Center(
                child: SizedBox(
                  height: 60,
                  child: aadharLogo
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(top: 10, bottom: 5),
                  child: const Text(personalInfo, 
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30
                  ),
              ),
                ),
              Container(
                margin: const EdgeInsets.only(bottom: 15),
                child: const Text(fillBelow, 
                   textAlign: TextAlign.center,
                   style: TextStyle(
                     fontSize: 19,
                   ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 25),
                child: Form(
                  key: formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                        TextFormField(
                           autovalidateMode: AutovalidateMode.onUserInteraction,
                            decoration: const InputDecoration(
                               contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                              border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                              labelText: naMe,
                            ),
                            onChanged: (value){
                              setState(() {
                                name = value;
                              });
                            },
                            validator: (value) {
                              if(value!.isEmpty){
                                return "Please enter your username";
                              }
                              return null;
                            },
                          ),
                        const SizedBox(height: 15,),
                        TextFormField(
                           autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: const InputDecoration(
                           contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                          border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                          labelText: 'Aadhar Number*',
                        ),
                        keyboardType: TextInputType.number,
                        controller: aadharController,
                        smartDashesType: SmartDashesType.enabled,
                        maxLength: 12,
                        onChanged: (value) {
                          var sizeVal = value.length;
                          setState(() {
                            aadhar = value;
                          });
                          // String mask = '';
                          // // for(int i=0;i<min(sizeVal, 12);i++){
                          // //   if(i!= 0 && i%4 == 0){
                          // //     XXX = XXX+ "-";
                          // //   }
                          // //   XXX = XXX + "X";
                          // // }
                          // print(aadharController.value);
                          // aadharController.value = TextEditingValue(
                          //     text: mask,
                          //     selection: TextSelection.fromPosition(
                          //       TextPosition(offset: aadharController.selection.base.offset),
                          //     ),
                          //   );
                        },
                        validator: (value) {
                          if(value!.isEmpty){
                            return "Enter correct Aadhar Number";
                          }
                          return null;
                        },
                      ),
                        const SizedBox(height: 15,),
                         DropdownButtonHideUnderline(
                           child: ButtonTheme(
                             alignedDropdown: true,
                             child: DropdownButtonFormField(
                               isExpanded: true,
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                               validator: (value) {
                                    if (value == null) {
                                      return 'Required';
                                    }
                                    return null;
                                  },    
                              items: const [
                                DropdownMenuItem(child: Text("Male"), value: "male",),
                                DropdownMenuItem(child: Text("Female"), value: "female",),
                                DropdownMenuItem(child: Text("None"), value: "none",),
                              ],
                              onChanged: (c){
                                String genderType = c.toString();
                                setState(() {
                                  gender = genderType;
                                });
                              },
                              decoration: const InputDecoration(
                                labelText: "Gender*",
                                contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                // enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                              ),
                                                   ),
                           ),
                         ),
                        const SizedBox(height: 15,),
                        TextFormField(
                          controller: dobController,
                           autovalidateMode: AutovalidateMode.onUserInteraction,
                          keyboardType: TextInputType.none,onTap: () => _selectDate(context),
                          enabled: true,
                          // initialValue: selectedDate.toString(),
                          readOnly: true,
                          textCapitalization: TextCapitalization.characters,
                          validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Required';
                                }
                                return null;
                              },
                          decoration: const InputDecoration(
                            hintText: "Select Date",
                            border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                            labelText: "Date of Birth*",   
                            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                            enabled: true,
                            suffixIcon: Icon(Icons.calendar_today_sharp,) 
                          ),
                        ),
                        const SizedBox(height: 15,),
                        TextFormField(
                          controller: pinController,
                          keyboardType: TextInputType.none,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          enabled: true,
                          readOnly: true,
                          textCapitalization: TextCapitalization.characters,
                          validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Required';
                                }
                                return null;
                              },
                          onTap: ()=>_getPincode(context),  
                          decoration:  const InputDecoration(
                            hintText: "Pincode",
                            border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                            labelText: "Pincode",   
                            enabled: true,
                            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                            suffixIcon: Icon(Icons.gps_fixed,)  
                          ),
                        ),
                    ],
                   ),
                  ),
              ),
                Container(
                        margin: const EdgeInsets.symmetric(vertical: 20),
                        child: ElevatedButton(onPressed: () async{
                          
                          // print("$name, $gender, $aadhar, $dob, ${pinController.text}");
                          if(name == "" || gender == "" || aadhar == "" || dob == 0  || pinController.text == ""){
                             return;
                          } else {
                            if(formKey.currentState!.validate()){
                             formKey.currentState!.save();
                             context.read<Customer>().setPersonalInfo(
                                nm: name.trim(),
                                // address: position!.toJson(),
                                adh: aadhar.trim(),
                                dateTime: selectedDate,
                                gen: gender
                               );
                               try {
                                 AadharGenerateOTPBody generateOTPBody = AadharGenerateOTPBody.fromJson({
                                      'entered_name': name.trim(),
                                      'aadhaar_number': aadhar.trim(),
                                      'is_consented': true,
                                      'consent_text': "lorem ipsum",
                                      'consent_time': (DateTime.now().millisecondsSinceEpoch/1000).toString()
                                  });
                                  SharedPreferences preferences = await SharedPreferences.getInstance();
                                 String? userid = preferences.getString('userId');
                                 String? token = preferences.getString('token');
                                 apiClient.setAccessToken(token!);
                                 
                                 final res3 = await aadharVerificationApi.v1AadharVerificationOTPRequest(userid!, generateOTPBody: generateOTPBody);
                                 final signature = await SmsAutoFill().getAppSignature;
                                 print(signature);
                                 Navigator.of(context).push(MaterialPageRoute(builder: (context) => OTPverify(fromPage: "pinfo", accessKey: res3!.accessKey,))); 
                               } catch (e) {
                                 print(e.toString());
                               }
                            }
                            }
                          },
                           style: ElevatedButton.styleFrom(
                             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Text("Verify and Submit", style: TextStyle(fontSize: 20),),
                          ) 
                     ),
                  ),
             ],
          ),
        ),
      ),
  );
  }
}