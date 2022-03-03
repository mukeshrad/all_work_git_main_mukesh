import 'package:finandy/constants/instances.dart';
import 'package:finandy/modals/customer.dart';
import 'package:finandy/utils/appBar.dart';
import 'package:finandy/utils/textField.dart';
import 'package:finandy/utils/usedButton.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:swagger/api.dart';

class AddressInfo extends StatefulWidget {
  const AddressInfo({Key? key}) : super(key: key);

  @override
  _AddressInfoState createState() => _AddressInfoState();
}

class _AddressInfoState extends State<AddressInfo> {
  TextEditingController houseNoController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController landmarkController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController pinCodeController = TextEditingController();

  bool isEdit = false;
  bool startUpdate = false;
  String initialownership = "Select";
  String? intialLocation = 'Select';

  final List<String> ownershipList = ['Select', 'Owned', 'Rented'];
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
    final UsersUserIdPutBody userBody = UsersUserIdPutBody();
    final updatedAddress = CurrentAddress();
    updatedAddress.ownership = initialownership.trim().toLowerCase();
    updatedAddress.line_1 = houseNoController.text.trim().toLowerCase();
    updatedAddress.line_2 = areaController.text.trim().toLowerCase();
    updatedAddress.landmark = landmarkController.text.trim().toLowerCase();
    updatedAddress.city = cityController.text.trim().toLowerCase();
    updatedAddress.pincode = int.parse(pinCodeController.text);
    updatedAddress.state = intialLocation?.trim().toLowerCase();
    userBody.currentAddress = updatedAddress;

    final userResponse = await userApi.v1UsersUserIdPut(
        '${Provider.of<Customer>(context, listen: false).userId}',
        body: userBody);
    Provider.of<Customer>(context, listen: false)
        .setCustomer(userResponse, UserState.OTPVerified);
    print('${Provider.of<Customer>(context, listen: false).currentAddress}');
    print(userResponse);
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
    String ownerShipType =
        '${Provider.of<Customer>(context, listen: false).currentAddress?.ownership}';
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
    if (ownerShipType == 'null' ||
        ownerShipType == '' ||
        ownerShipType == null) {
      setState(() {
        initialownership = 'Select';
      });
    } else {
      setState(() {
        initialownership = ownerShipType;
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
      initialownership = value!;
      isEdit = true;
      print(value);
      print(initialownership);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      initialownership = "Select";
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
                  dropDownButton(
                    value: initialownership,
                    list: ownershipList,
                    onChanged: onOccupationTypeDropDownChanged,
                    fieldName: 'Ownership Type',
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  Textfield(
                    labelText: 'Flat/House No./Building/Apartment',
                    onChanged: onChanged,
                    controller: houseNoController,
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  Textfield(
                    labelText: 'Area/Street/Sector/Village',
                    onChanged: onChanged,
                    controller: areaController,
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  Textfield(
                    labelText: 'Landmark',
                    onChanged: onChanged,
                    controller: landmarkController,
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  Textfield(
                    labelText: 'Town/City',
                    onChanged: onChanged,
                    controller: cityController,
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  Textfield(
                    labelText: 'Pin Code',
                    onChanged: onChanged,
                    textInputType: TextInputType.number,
                    controller: pinCodeController,
                    noOfAlphabets: 6,
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  dropDownButton(
                    value: intialLocation,
                    list: _locationList,
                    onChanged: onStateDropDownChanged,
                    fieldName: 'State*',
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
}
