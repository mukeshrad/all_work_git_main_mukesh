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
  late String occupation;
  bool isEdit = false;
  bool startUpdate = false;

  putData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    Object? token = preferences.get("token");
    apiClient.setAccessToken(token as String);

    UserResponse userBody = UserResponse.fromJson({
      "_id": Provider.of<Customer>(context, listen: false).userId,
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
        'occupation_type': occupation,
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
    final res2 = await userApi.v1UsersUserIdPut(
        '${Provider.of<Customer>(context, listen: false).userId}',
        body: userBody);

    Provider.of<Customer>(context, listen: false)
        .setCustomer(res2.toJson(), UserState.OTPVerified);
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
        occupation = "Select";
      });
    } else {
      setState(() {
        occupation = localOccupation;
      });
    }
  }

  void onChanged(String value) {
    setState(() => isEdit = true);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
                  IgnorePointer(
                    ignoring: false,
                    child: dropDownButton(),
                  ),
                  IgnorePointer(
                    ignoring: false,
                    child: Textfield(
                      labelText: 'Company Name',
                      onChanged: onChanged,
                      controller: companyNameController,
                    ),
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
            isEdit
                ? UsedButton(
                    buttonName: startUpdate
                        ? const CircularProgressIndicator()
                        : const Center(
                            child: Text(
                              'Update',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 18.0),
                            ),
                          ),
                    onpressed: () async {
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
                    },
                  )
                : Container(),
          ],
        ),
      ),
    ));
  }

  Container dropDownButton() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xffFAFAFA),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: DropdownButtonFormField(
        validator: (value) {
          if (value == null) {
            return 'Required';
          }
          return null;
        },
        value: occupation,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          color: Colors.black,
          fontSize: 16.0,
        ),
        items: const [
          DropdownMenuItem(
            child: Text(
              "Select",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            value: "Select",
          ),
          DropdownMenuItem(
            child: Text(
              "Salaried",
            ),
            value: "Salaried",
          ),
          DropdownMenuItem(
            child: Text("Self-Employed-Business Owner"),
            value: "Self-Employed-Business Owner",
          ),
          DropdownMenuItem(
            child: Text(
              "Self-Employed-Business Professional",
            ),
            value: "Self-Employed-Business Professional",
          ),
          DropdownMenuItem(
            child: Text("Student"),
            value: "Student",
          ),
        ],
        onChanged: (c) {
          String occuType = c.toString();
          setState(() {
            occupation = occuType;
            isEdit = true;
          });
        },
        decoration: const InputDecoration(
          labelText: "Occupation Type*",
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
        ),
      ),
    );
  }
}
