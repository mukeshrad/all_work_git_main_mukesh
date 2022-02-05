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

  //  sendRequest() async{
  //   //  final res = await api_instance.v1UsersUserIdGet("61dd468b5e346c001d24037f");
  //   //  print(res.toString());
  //   Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const OTPverify()));
  //  }

  _getPincode(BuildContext context) async {
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

    List<Placemark> placemark = await placemarkFromCoordinates(geolocation.latitude, geolocation.longitude);
    Placemark place = placemark[0];
    
    String? pinCode = place.postalCode;
    setState(() {
      position = geolocation;
      pinController.text = "$pinCode";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false,elevation: 0, backgroundColor: Colors.white,),
    body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
          child: Column(
             children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 5),
                  child: const Text("Personal Info", 
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 33
                  ),
              ),
                ),
              Container(
                margin: const EdgeInsets.only(bottom: 15),
                child: const Text("Fill in the details below to\nGet Started", 
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
                              border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                              labelText: 'Name*',
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
                          border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                          labelText: 'Aadhar Number*',
                        ),
                        keyboardType: TextInputType.number,
                        controller: aadharController,
                        smartDashesType: SmartDashesType.enabled,
                        maxLength: 16,
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
                         DropdownButtonFormField(
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                           validator: (value) {
                                if (value == null) {
                                  return 'Required';
                                }
                                return null;
                              },    
                          items: const [
                            DropdownMenuItem(child: Text("Male"), value: "Male",),
                            DropdownMenuItem(child: Text("Female"), value: "Female",),
                            DropdownMenuItem(child: Text("Other"), value: "Other",),
                          ],
                          onChanged: (c){
                            String genderType = c.toString();
                            setState(() {
                              gender = genderType;
                            });
                          },
                          decoration: const InputDecoration(
                            labelText: "Gender*",
                            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                          ),
                        ),
                        const SizedBox(height: 15,),
                        TextFormField(
                          controller: dobController,
                           autovalidateMode: AutovalidateMode.onUserInteraction,
                          keyboardType: TextInputType.none,
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
                          decoration: InputDecoration(
                            hintText: "Select Date",
                            border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                            labelText: "Date of Birth*",   
                            enabled: true,
                            suffixIcon: IconButton( onPressed: ()=>_selectDate(context), icon: const Icon(Icons.calendar_today_sharp,))  
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
                          decoration: InputDecoration(
                            hintText: "Pincode",
                            border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                            labelText: "Pincode*",   
                            enabled: true,
                            suffixIcon: IconButton( onPressed: ()=>_getPincode(context), icon: const Icon(Icons.gps_fixed,))  
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
                             formKey.currentState!.save();
                             final signature = await SmsAutoFill().getAppSignature;
                             context.read<Customer>().setPersonalInfo(
                                nm: name.trim(),
                                address: position!.toJson().toString(),
                                adh: aadhar,
                                dateTime: selectedDate,
                                gen: gender
                               );
                               Navigator.of(context).push(MaterialPageRoute(builder: (context) => const OTPverify(fromPage: "pinfo",)));
                            }
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
      ),
  );
  }
}