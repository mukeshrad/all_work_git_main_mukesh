import 'package:finandy/modals/customer.dart';
import 'package:finandy/screens/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController martialStatusController = TextEditingController();
  TextEditingController adharController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController dateofBirthController = TextEditingController();
  TextEditingController residentialPinCodeController = TextEditingController();
  TextEditingController fatherNameController = TextEditingController();
  TextEditingController motherNameController = TextEditingController();
  TextEditingController noOfKidsController = TextEditingController();

  sendToscreen(var page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  // UserResponse? result;
  bool change = false;

  // getdet() async {
  //   // String | User Id
  //
  //   try {
  //     // var result = await api_instance.v1UsersOnBoardUserPost(body,
  //     //     clientSecret: '257b1e871085b3433674d416fa743668');
  //     // defaultApiClient.addDefaultHeader("Client-Secret", "");
  //     apiClient.setAccessToken(
  //         'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7InVzZXJfaWQiOiI2MWRkNDY4YjVlMzQ2YzAwMWQyNDAzN2YiLCJjcmVhdGVkQXQiOiIyMDIyLTAxLTE2VDA2OjE0OjQ5LjU1N1oifSwiaWF0IjoxNjQyMzEzNjg5fQ.Ro4PhbIa4d52inJs9K7osJtmZT7PQj5BjW6TiRMybzI');
  //     var r = await api_instance.v1UsersUserIdGet('61dd468b5e346c001d24037f');
  //     print('as $r');
  //     setState(() {
  //       result = r;
  //       // customerName = r?.customerName ?? 'null';
  //       // id = r?.id ?? 'null';
  //       // primaryPhoneNumber = r?.primaryPhoneNumber ?? 'null';
  //       // email = r?.email ?? 'null';
  //     });
  //     // Provider.of<Customer>(context, listen: false)
  //     //     .setCustomer(r?.toJson(), UserState.LoggedIn);
  //     // print(
  //     //     'we have ${Provider.of<Customer>(context, listen: false).customerName}');
  //     print(result);
  //     // final data = result;
  //   } catch (e) {
  //     print("Exception when calling UsersApi->v1UsersUserIdGet: $e\n");
  //   }
  // }

  setData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    print(preferences.getString('userId'));
    print(Provider.of<Customer>(context, listen: false).email);
    setState(
      () {
        nameController.text =
            Provider.of<Customer>(context, listen: false).customerName ?? "";
        adharController.text =
            Provider.of<Customer>(context, listen: false).aadharNo ?? "";
        genderController.text =
            Provider.of<Customer>(context, listen: false).gender ?? "";
        String text =
            '${Provider.of<Customer>(context, listen: false).dateOfBirth ?? ""}';
        String formattedDate = DateFormat.yMMMMd().format(
          DateTime.parse(text),
        );
        dateofBirthController.text = formattedDate;
        residentialPinCodeController.text =
            '${Provider.of<Customer>(context, listen: false).currentAddress?.pincode ?? " "}';
        emailController.text =
            Provider.of<Customer>(context, listen: false).email ?? " ";
      },
    );
  }

  changeDetails() {
    setState(() {
      if (change) {
        change = false;
      } else {
        change = true;
      }
    });
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
        backgroundColor: Colors.white,
        body: ListView(
          children: [
            buildProfileTop(),
            const SizedBox(
              height: 78.0,
            ),
            buildName(context),
            const SizedBox(
              height: 10.0,
            ),
            buildProgressWidget(context),
            const SizedBox(
              height: 16.0,
            ),
            buildChoiceTile(
              callback: changeDetails,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 40.0,
                vertical: 20.0,
              ),
              child: change
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildTitleName(
                          title: "Father’s Name",
                        ),
                        buildTextField(
                          controller: fatherNameController,
                        ),
                        const SizedBox(
                          height: 16.5,
                        ),
                        buildTitleName(
                          title: "Mother’s Name",
                        ),
                        buildTextField(
                          controller: motherNameController,
                        ),
                        const SizedBox(
                          height: 16.5,
                        ),
                        buildTitleName(
                          title: 'No of Kids',
                        ),
                        buildTextField(
                          controller: noOfKidsController,
                          haveSufix: true,
                          editButtonFunction: () {},
                        ),
                      ],
                    )
                  : profileFields(),
            ),
          ],
        ),
      ),
    );
  }

  Column profileFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildTitleName(
          title: 'Aadhar Number',
        ),
        buildTextField(
          controller: adharController,
        ),
        const SizedBox(
          height: 16.5,
        ),
        buildTitleName(
          title: 'Email Id',
        ),
        buildTextField(
          controller: emailController,
          haveSufix: true,
          editButtonFunction: () {},
        ),
        const SizedBox(
          height: 16.5,
        ),
        buildTitleName(
          title: 'Date of Birth',
        ),
        buildTextField(
          controller: dateofBirthController,
        ),
        const SizedBox(
          height: 16.5,
        ),
        buildTitleName(
          title: 'Gender',
        ),
        buildTextField(
          controller: genderController,
        ),
        const SizedBox(
          height: 16.5,
        ),
        buildTitleName(
          title: 'Martial Status',
        ),
        buildTextField(
          controller: martialStatusController,
        ),
      ],
    );
  }

  TextField buildTextField(
      {required TextEditingController controller,
      bool? haveSufix,
      VoidCallback? editButtonFunction}) {
    return TextField(
      controller: controller,
      style: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 17.0,
      ),
      decoration: InputDecoration(
        suffixIcon: haveSufix == true
            ? IconButton(
                onPressed: editButtonFunction,
                icon: Icon(
                  Icons.edit,
                  color: Color(0xff084E6C),
                  size: 15.0,
                ),
              )
            : null,
      ),
    );
  }

  Text buildTitleName({
    required String title,
  }) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 15.0,
        color: Color(0xff5C5C5C),
      ),
    );
  }

  Container buildChoiceTile({required VoidCallback callback}) {
    return Container(
      decoration: const BoxDecoration(
        // color: Colors.white,
        border: Border(
          top: BorderSide(
            color: Color(0xffF2F2F2),
            width: 1,
          ),
          bottom: BorderSide(
            color: Color(0xffF2F2F2),
            width: 1,
          ),
        ),
      ),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              InkWell(
                onTap: callback,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 30.0,
                    vertical: 16.0,
                  ),
                  child: Text(
                    "Personal Info",
                    style: TextStyle(
                      color: change ? Color(0xff5C5C5C) : Color(0xffDD2E44),
                      fontSize: 17.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Container(
                height: 15,
                width: 2.0,
                color: Color(0xffF2F2F2),
              ),
              InkWell(
                onTap: callback,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 30.0,
                    vertical: 16.0,
                  ),
                  child: Text(
                    "Family Details",
                    style: TextStyle(
                      color: change ? Color(0xffDD2E44) : Color(0xff5C5C5C),
                      fontSize: 17.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Align(
            alignment: change ? Alignment.bottomRight : Alignment.bottomLeft,
            child: Container(
              color: const Color(0xffDD2E44),
              width: MediaQuery.of(context).size.width * 0.5,
              height: 2.0,
            ),
          ),
        ],
      ),
    );
  }

  Padding buildProgressWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 30.0,
      ),
      child: profileProgress(
        progress: .45,
        name: '${Provider.of<Customer>(context, listen: false).customerName}',
        upiId: 'harsh@icici',
        profileImg: '',
      ),
    );
  }

  Column buildName(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Text(
            '${Provider.of<Customer>(context, listen: false).customerName}',
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 19.0,
            ),
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        const Center(
          child: Text(
            'harsh@icici',
            style: TextStyle(
              color: Color(0xff5C5C5C),
              fontSize: 17.0,
            ),
          ),
        ),
      ],
    );
  }

  Stack buildProfileTop() {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 16.0,
              ),
              alignment: AlignmentDirectional.topStart,
              height: 122,
              color: Color(0xff054561),
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back_outlined,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
        Positioned(
          bottom: -66.0,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(72.0),
                ),
                child: const CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8dXNlcnxlbnwwfHwwfHw%3D&w=1000&q=80'),
                  // radius: ,
                  maxRadius: 70,
                ),
              ),
              Positioned(
                right: 10,
                bottom: 10,
                child: Container(
                  padding: const EdgeInsets.all(5),
                  alignment: Alignment.topLeft,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey, width: 0.5),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.camera_enhance,
                    color: Colors.blueGrey,
                    size: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
