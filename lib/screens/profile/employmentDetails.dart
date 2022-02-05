import 'package:finandy/modals/customer.dart';
import 'package:finandy/utils/appBar.dart';
import 'package:finandy/utils/textField.dart';
import 'package:finandy/utils/usedButton.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EmploymentDetails extends StatefulWidget {
  const EmploymentDetails({Key? key}) : super(key: key);

  @override
  _EmploymentDetailsState createState() => _EmploymentDetailsState();
}

class _EmploymentDetailsState extends State<EmploymentDetails> {
  // TextEditingController _nameController = TextEditingController();
  // TextEditingController _adharController = TextEditingController();
  // TextEditingController _genderController = TextEditingController();
  // TextEditingController _dateofBirthController = TextEditingController();
  // TextEditingController _residentialPinCodeController = TextEditingController();
  String occupation = "Salaried";
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
      occupation =
          "${Provider.of<Customer>(context, listen: false).professionalInfo!.occupationType}";
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
                    pageName: 'Employment Details',
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  IgnorePointer(
                    ignoring: true,
                    child: dropDownButton(),
                  ),
                  IgnorePointer(
                    ignoring: true,
                    child: Textfield(
                      labelText: 'Company Name',
                      initialText:
                          '${Provider.of<Customer>(context, listen: false).professionalInfo!.occupation}',
                    ),
                  ),
                  IgnorePointer(
                    ignoring: true,
                    child: Textfield(
                      labelText: 'Net Monthly income',
                      initialText: 'Rs. 90000',
                    ),
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

  Container dropDownButton() {
    return Container(
      decoration: BoxDecoration(
          color: const Color(0xffEBEBEB),
          borderRadius: BorderRadius.circular(8.0)),
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
