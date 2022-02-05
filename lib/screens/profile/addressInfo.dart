import 'package:finandy/utils/appBar.dart';
import 'package:finandy/utils/textField.dart';
import 'package:finandy/utils/usedButton.dart';
import 'package:flutter/material.dart';

class AdressInfo extends StatefulWidget {
  const AdressInfo({Key? key}) : super(key: key);

  @override
  _AdressInfoState createState() => _AdressInfoState();
}

class _AdressInfoState extends State<AdressInfo> {
  // TextEditingController _nameController = TextEditingController();
  // TextEditingController _adharController = TextEditingController();
  // TextEditingController _genderController = TextEditingController();
  // TextEditingController _dateofBirthController = TextEditingController();
  // TextEditingController _residentialPinCodeController = TextEditingController();
  String intial_occupation = "Salaried";
  String intial_Location = 'Haryana';

  List<String> _occupation = ['Owned', 'Rented'];
  List<String> _locationList = ['Haryana', 'Bihar', 'Assam', 'Uttar Pradesh'];
  sendToscreen(var page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      intial_occupation = "Owned";
      intial_Location = 'Haryana';
    });
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
                        value: intial_occupation, list: _occupation),
                  ),
                  IgnorePointer(
                    ignoring: true,
                    child: Textfield(
                      labelText: 'Flat/House No./Building/Apartment',
                      initialText: '27-A',
                    ),
                  ),
                  IgnorePointer(
                    ignoring: true,
                    child: Textfield(
                      labelText: 'Area/Street/Sector/Village',
                      initialText: 'Sushant Lok 1',
                    ),
                  ),
                  IgnorePointer(
                    ignoring: true,
                    child: Textfield(
                      labelText: 'Landmark',
                      initialText: 'Near ABC',
                    ),
                  ),
                  IgnorePointer(
                    ignoring: true,
                    child: Textfield(
                      labelText: 'Town/City',
                      initialText: 'Gurugram',
                    ),
                  ),
                  IgnorePointer(
                    ignoring: true,
                    child: Textfield(
                      labelText: 'Pin Code',
                      initialText: '132432',
                    ),
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  IgnorePointer(
                    ignoring: false,
                    child: dropDownButton(
                        value: intial_Location, list: _locationList),
                  ),
                ],
              ),
            ),
            UsedButton(
              buttonName: 'Edit',
              onpressed: () {},
            )
          ],
        ),
      ),
    ));
  }

  Padding defaultButton({required String buttonName}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      child: ElevatedButton(
        onPressed: () {},
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.grey),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 130.0,
            vertical: 14.0,
          ),
          child: Text(
            buttonName,
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18.0),
          ),
        ),
      ),
    );
  }

  Container dropDownButton({required value, required List<String> list}) {
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
          fontSize: 16.0,
        ),
        items: list.map((String s) {
          return DropdownMenuItem<String>(
            value: s,
            child: Text(s),
          );
        }).toList(),
        onChanged: (c) {
          String occuType = c.toString();
          setState(() {
            value = occuType;
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
