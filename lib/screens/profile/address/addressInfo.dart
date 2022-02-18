import 'package:finandy/constants/instances.dart';
import 'package:finandy/modals/customer.dart';
import 'package:finandy/utils/appBar.dart';
import 'package:finandy/utils/textField.dart';
import 'package:finandy/utils/usedButton.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swagger/api.dart';

class AdressInfo extends StatefulWidget {
  const AdressInfo({Key? key}) : super(key: key);

  @override
  _AdressInfoState createState() => _AdressInfoState();
}

class _AdressInfoState extends State<AdressInfo> {
  TextEditingController houseNoController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController landmarkController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController pinCodeController = TextEditingController();

  bool isEdit = false;
  bool startUpdate = false;
  String intial_occupation = "Select";
  String? intialLocation = 'Select';

  final List<String> _occupation = ['Select', 'Owned', 'Rented'];
  final List<String> _locationList = [
    'Select',
    'Delhi',
    'Haryana',
    'Bihar',
    'Assam',
    'Uttar Pradesh',
    'Andhra Pradesh',
    'Arunachal Pradesh',
    'Chhattisgarh',
    'Goa',
    'Gujarat',
    'Himachal Pradesh',
    'Jharkhand',
    'Karnataka',
    'Kerala',
    'Madhya Pradesh',
    'Maharashtra',
    'Manipur',
    'Meghalaya',
    'Mizoram',
    'Nagaland',
    'Odisha',
    'Punjab	',
    'Rajasthan',
    'Sikkim',
    'Tamil Nadu',
    'Telangana',
    'Tripura',
    'Uttarakhand',
    'West Bengal',
    'Andaman and Nicobar Island',
    'Chandigarh',
    'Dadra and Nagar Haveli and Daman and Diu',
    'Ladakh',
    'Lakshadweep',
    'Jammu and Kashmir',
    'Puducherry',
  ];
  sendToscreen(var page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  putData() async {
    print('${DateTime.now().toString()}');
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    UserResponse userBody = UserResponse.fromJson({
      "_id": Provider.of<Customer>(context, listen: false).userId,
      'current_address': {
        'line_1': houseNoController.text,
        'line_2': areaController.text,
        'landmark': landmarkController.text,
        'city': cityController.text,
        'pincode': int.parse(pinCodeController.text),
        'state': intialLocation,
      },
    });
    final res2 = await userApi.v1UsersUserIdPut(
        '${Provider.of<Customer>(context, listen: false).userId}',
        body: userBody);
    Provider.of<Customer>(context, listen: false)
        .setCustomer(res2?.toJson(), UserState.OTPVerified);
    print('${Provider.of<Customer>(context, listen: false).currentAddress}');
    print(res2);
  }

  setData() {
    setState(() {
      houseNoController.text = Provider.of<Customer>(context, listen: false)
              .currentAddress
              ?.line_1 ??
          "";
      areaController.text = Provider.of<Customer>(context, listen: false)
              .currentAddress
              ?.line_2 ??
          "";
      landmarkController.text = Provider.of<Customer>(context, listen: false)
              .currentAddress
              ?.landmark ??
          "";
      cityController.text =
          Provider.of<Customer>(context, listen: false).currentAddress?.city ??
              "";
      pinCodeController.text =
          '${Provider.of<Customer>(context, listen: false).currentAddress?.pincode ?? ""}';
    });
    String state =
        '${Provider.of<Customer>(context, listen: false).currentAddress?.state}';
    if (state == 'null' || state == '') {
      setState(() {
        print(1);
        intialLocation = "Select";
        print(intialLocation);
        print(1);
      });
    } else {
      setState(() {
        intialLocation = state;
        print(2);
        print(intialLocation);
        print(2);
      });
    }
  }

  void onChanged(String value) {
    setState(() => isEdit = true);
  }

  void onStateDropDownChanged(String? value) {
    setState(() {
      intialLocation = value;
      isEdit = true;
      print(value);
      print(intialLocation);
    });
  }

  void onOccupationTypeDropDownChanged(String? value) {
    setState(() {
      intial_occupation = value!;
      isEdit = true;
      print(value);
      print(intialLocation);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      intial_occupation = "Select";
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
                  const NewAppBar(
                    pageName: 'Adress Details',
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  IgnorePointer(
                    ignoring: false,
                    child: dropDownButton(
                        value: intial_occupation,
                        list: _occupation,
                        onChanged: onOccupationTypeDropDownChanged),
                  ),
                  IgnorePointer(
                    ignoring: false,
                    child: Textfield(
                      labelText: 'Flat/House No./Building/Apartment',
                      onChanged: onChanged,
                      controller: houseNoController,
                    ),
                  ),
                  IgnorePointer(
                    ignoring: false,
                    child: Textfield(
                      labelText: 'Area/Street/Sector/Village',
                      onChanged: onChanged,
                      controller: areaController,
                    ),
                  ),
                  IgnorePointer(
                    ignoring: false,
                    child: Textfield(
                      labelText: 'Landmark',
                      onChanged: onChanged,
                      controller: landmarkController,
                    ),
                  ),
                  IgnorePointer(
                    ignoring: false,
                    child: Textfield(
                      labelText: 'Town/City',
                      onChanged: onChanged,
                      controller: cityController,
                    ),
                  ),
                  IgnorePointer(
                    ignoring: false,
                    child: Textfield(
                      labelText: 'Pin Code',
                      onChanged: onChanged,
                      textInputType: TextInputType.number,
                      controller: pinCodeController,
                    ),
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  IgnorePointer(
                    ignoring: false,
                    child: dropDownButton(
                        value: intialLocation,
                        list: _locationList,
                        onChanged: onStateDropDownChanged,),
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
                    },
                  )
                : Container(),
          ],
        ),
      ),
    ));
  }

  Container dropDownButton({
    required value,
    required List<String> list,
    required void Function(String? value)? onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
          color: const Color(0xffEBEBEB),
          borderRadius: BorderRadius.circular(8.0)),
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
        decoration: const InputDecoration(
          labelText: "State*",
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
        ),
      ),
    );
  }
}
