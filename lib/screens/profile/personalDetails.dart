import 'package:finandy/constants/instances.dart';
import 'package:finandy/constants/texts.dart';
import 'package:finandy/modals/customer.dart';
import 'package:finandy/screens/profile/profile.dart';
import 'package:finandy/utils/profile_ui.dart';
import 'package:finandy/utils/textField.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swagger/api.dart';

class PersonalDetails extends StatefulWidget {
  const PersonalDetails({Key? key}) : super(key: key);

  @override
  _PersonalDetailsState createState() => _PersonalDetailsState();
}

class _PersonalDetailsState extends State<PersonalDetails> {
  // TODO Configure API key authorization: clientSecretKeyAuth
// swagger.api.Configuration.apiKey{'Client-Secret'} = 'YOUR_API_KEY';
// // uncomment below to setup prefix (e.g. Bearer) for API key, if needed
// swagger.api.Configuration.apiKeyPrefix{'Client-Secret'} = "Bearer";

  // TextEditingController _nameController = TextEditingController();
  // TextEditingController _adharController = TextEditingController();
  // TextEditingController _genderController = TextEditingController();
  // TextEditingController _dateofBirthController = TextEditingController();
  // TextEditingController _residentialPinCodeController = TextEditingController();

  sendToscreen(var page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  var api_instance = UsersApi(apiClient);
  var body = UsersOnboarduserBody();
  var userId = '61dd468b5e346c001d24037f';
  UserResponse? result;
  late String customerName;
  late String id;
  late String primaryPhoneNumber;
  late String email;

  getdet() async {
    // String | User Id

    try {
      // var result = await api_instance.v1UsersOnBoardUserPost(body,
      //     clientSecret: '257b1e871085b3433674d416fa743668');
      // defaultApiClient.addDefaultHeader("Client-Secret", "");
      apiClient.setAccessToken(
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7InVzZXJfaWQiOiI2MWRkNDY4YjVlMzQ2YzAwMWQyNDAzN2YiLCJjcmVhdGVkQXQiOiIyMDIyLTAxLTE2VDA2OjE0OjQ5LjU1N1oifSwiaWF0IjoxNjQyMzEzNjg5fQ.Ro4PhbIa4d52inJs9K7osJtmZT7PQj5BjW6TiRMybzI');
      var r = await api_instance.v1UsersUserIdGet('61dd468b5e346c001d24037f');
      setState(() {
        result = r;
        customerName = r?.customerName ?? 'null';
        id = r?.id ?? 'null';
        primaryPhoneNumber = r?.primaryPhoneNumber ?? 'null';
        email = r?.email ?? 'null';
      });
      Provider.of<Customer>(context, listen: false).setCustomer(r, UserState.LoggedIn);
      print(
          'we have ${Provider.of<Customer>(context, listen: false).customerName}');
      print(result);
      // final data = result;
    } catch (e) {
      print("Exception when calling UsersApi->v1UsersUserIdGet: $e\n");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdet();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: result == null
          ? const Center(child: CircularProgressIndicator())
          : Container(
              margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              child: ListView(
                children: [
                  appBar(
                    'Personal Details',
                    context,
                  ),
                  ProfileUi(id: id, name: customerName, profileImg: userImg),
                  Textfield(
                    labelText: 'Name',
                    initialText: customerName,
                  ),
                  Textfield(
                    labelText: 'Aadhar Number',
                    initialText: 'XXXX-XXXX-XXXX-8765',
                  ),
                  Textfield(
                    labelText: 'Gender',
                    initialText: 'Male',
                  ),
                  Textfield(
                    labelText: 'Date Of Birth',
                    initialText: '08/15/1996',
                  ),
                  Textfield(
                    labelText: 'Residential Pincode',
                    initialText: '222018',
                  ),
                ],
              ),
            ),
    ));
  }
}
