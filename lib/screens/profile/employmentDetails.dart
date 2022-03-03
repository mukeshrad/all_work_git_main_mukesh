import 'package:finandy/constants/instances.dart';
import 'package:finandy/modals/customer.dart';
import 'package:finandy/utils/appBar.dart';
import 'package:finandy/utils/textField.dart';
import 'package:finandy/utils/usedButton.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swagger/api.dart';

import '../../constants/constants.dart';

class EmploymentDetails extends StatefulWidget {
  const EmploymentDetails({Key? key}) : super(key: key);

  @override
  _EmploymentDetailsState createState() => _EmploymentDetailsState();
}

class _EmploymentDetailsState extends State<EmploymentDetails> {
  TextEditingController companyNameController = TextEditingController();
  TextEditingController netMonthlyIncomeController = TextEditingController();
  // TextEditingController _genderController = TextEditingController();
  // TextEditingController _dateofBirthController = TextEditingController();
  // TextEditingController _residentialPinCodeController = TextEditingController();
  String _occupation = 'Select';
  bool isEdit = false;
  bool startUpdate = false;
  final List<String> occupationList = [
    'select',
    'salaried',
    'self-employed-business owner',
    'self-employed-business professional',
    'student',
  ];

  putData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    Object? token = preferences.get("token");
    apiClient.setAccessToken(token as String);

    UsersUserIdPutBody userBody = UsersUserIdPutBody.fromJson({
      // "id": Provider.of<Customer>(context, listen: false).clientCustomerId,
      // "customer_name":
      //     Provider.of<Customer>(context, listen: false).customerName,
      // "gender": Provider.of<Customer>(context, listen: false).gender,
      // "dob": DateTime.now().toString(),
      // 'primary_phone_number':
      //     Provider.of<Customer>(context, listen: false).primaryPhoneNumber,
      // 'client_id': clientId,
      // // 'image_url': instance.imageUrl,
      // 'client_customer_id': userId,
      // 'email': 'Provider.of<Customer>(context, listen: false).email',
      // 'current_address': {
      //   'line_1': 'o',
      //   'line_2': 'String',
      //   'city': 'String',
      //   'state': 'String',
      //   'pincode': 90,
      //   'landmark': 'String',
      // },
      // 'is_verified': Provider.of<Customer>(context, listen: false).isVerified,
      // 'customer_preference':
      //     Provider.of<Customer>(context, listen: false).customerPreference,
      'professional_info': {
        'occupation_type': _occupation.toLowerCase(),
        'occupation': companyNameController.text,
        'monthly_earning': int.parse(netMonthlyIncomeController.text),
      },
      // 'notification_preference': {
      //   'whatsapp': false,
      //   'sms': true,
      //   'email': true
      // },
      // Provider.of<Customer>(context, listen: false).notificationPreference,
    });
    final UserResponse res2 = await userApi.v1UsersUserIdPut(
        '${Provider.of<Customer>(context, listen: false).userId}',
        body: userBody);

    Provider.of<Customer>(context, listen: false)
        .setCustomer(res2, UserState.OTPVerified);
    print('${Provider.of<Customer>(context, listen: false).currentAddress}');
    // print(res2?.email);
    print(res2);
    // print(res2?.professionalInfo);
    // print(res2?.notificationPreference);
  }

  sendToscreen(var page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  setData() {
    setState(() {
      companyNameController.text = Provider.of<Customer>(context, listen: false)
              .professionalInfo
              ?.occupation ??
          "";
      netMonthlyIncomeController.text =
          '${Provider.of<Customer>(context, listen: false).professionalInfo?.monthlyEarning?.round() ?? ""}';
    });
    String localOccupation =
        '${Provider.of<Customer>(context, listen: false).professionalInfo?.occupationType}';
    if (localOccupation == 'null' || localOccupation == '') {
      setState(() {
        _occupation = "Select";
      });
    } else {
      setState(() {
        _occupation = localOccupation;
      });
    }
  }

  void onChanged(String value) {
    setState(() => isEdit = true);
  }

  void onOccupationTypeDropDownChanged(String? value) {
    setState(() {
      _occupation = value!;
      isEdit = true;
      print(value);
      print(_occupation);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _occupation = "Select";
    });
    setData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ListView(
                children: [
                  NewAppBar(
                    pageName: 'Employment Details',
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  dropDownButton(
                    value: _occupation,
                    list: occupationList,
                    onChanged: onOccupationTypeDropDownChanged,
                    fieldName: 'Occupation Type',
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  IgnorePointer(
                    ignoring: false,
                    child: Textfield(
                      labelText: 'Company Name',
                      onChanged: onChanged,
                      controller: companyNameController,
                    ),
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  IgnorePointer(
                    ignoring: false,
                    child: Textfield(
                      labelText: 'Net Monthly income',
                      onChanged: onChanged,
                      textInputType: TextInputType.number,
                      controller: netMonthlyIncomeController,
                      prefix: Container(
                        padding: EdgeInsets.all(2.0),
                        color: Color(0xffF5FBFF),
                        child: const Text(
                          'Rs. ',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            isEdit ? buildupdateButton() : Container(),
          ],
        ),
      ),
    ));
  }

  UsedButton buildupdateButton() {
    return UsedButton(
      buttonName: startUpdate
          ? circularProgressIndicator
          : const Center(
              child: Text(
                'Update',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18.0),
              ),
            ),
      onpressed: () async {
        updateEmploymentData();
      },
    );
  }

  updateEmploymentData() async {
    setState(() {
      startUpdate = true;
    });
    await putData();
    print('donw');

    setState(() {
      startUpdate = false;
      isEdit = false;
    });
    Fluttertoast.showToast(
        msg: "Data Updated Successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Color(0xff084E6C),
        textColor: Colors.white,
        fontSize: 16.0);
  }

  Container dropDownButton({
    required value,
    required String fieldName,
    required List<String> list,
    required void Function(String? value)? onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: DropdownButtonFormField<String>(
        validator: (value) {
          if (value == null) {
            return 'Required';
          }
          return null;
        },
        value: value,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          color: Colors.black,
          overflow: TextOverflow.ellipsis,
          fontSize: 16.0,
        ),
        items: list.map((String s) {
          return DropdownMenuItem<String>(
            value: s,
            child: Text(s),
          );
        }).toList(),
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: fieldName,
          focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
        ),
      ),
    );
  }
  // Container dropDownButton() {
  //   return Container(
  //     decoration: BoxDecoration(
  //       color: const Color(0xffFAFAFA),
  //       borderRadius: BorderRadius.circular(8.0),
  //     ),
  //     child: DropdownButtonFormField(
  //       validator: (value) {
  //         if (value == null) {
  //           return 'Required';
  //         }
  //         return null;
  //       },
  //       value: _occupation,
  //       style: const TextStyle(
  //         fontWeight: FontWeight.w500,
  //         color: Colors.black,
  //         fontSize: 16.0,
  //       ),
  //       items: const [
  //         DropdownMenuItem(
  //           child: Text(
  //             "Select",
  //             style: TextStyle(
  //               color: Colors.black,
  //             ),
  //           ),
  //           value: "Select",
  //         ),
  //         DropdownMenuItem(
  //           child: Text(
  //             "Salaried",
  //           ),
  //           value: "Salaried",
  //         ),
  //         DropdownMenuItem(
  //           child: Text("Self-Employed-Business Owner"),
  //           value: "Self-Employed-Business Owner",
  //         ),
  //         DropdownMenuItem(
  //           child: Text(
  //             "Self-Employed-Business Professional",
  //           ),
  //           value: "Self-Employed-Business Professional",
  //         ),
  //         DropdownMenuItem(
  //           child: Text("Student"),
  //           value: "Student",
  //         ),
  //       ],
  //       onChanged: (c) {
  //         String occuType = c.toString();
  //         setState(() {
  //           _occupation = occuType;
  //           isEdit = true;
  //         });
  //       },
  //       decoration: const InputDecoration(
  //         labelText: "Occupation Type*",
  //         enabledBorder: OutlineInputBorder(
  //             borderRadius: BorderRadius.all(Radius.circular(10))),
  //       ),
  //     ),
  //   );
  // }
}
