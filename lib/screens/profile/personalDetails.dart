import 'dart:convert';
import 'dart:io';

import 'package:finandy/modals/customer.dart';
import 'package:finandy/screens/profile/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swagger/api.dart';

import '../../constants/constants.dart';
import '../../constants/instances.dart';
import '../../utils/usedButton.dart';

class PersonalDetails extends StatefulWidget {
  final double profileProgressint;
  const PersonalDetails({Key? key, required this.profileProgressint})
      : super(key: key);

  @override
  _PersonalDetailsState createState() => _PersonalDetailsState();
}

class _PersonalDetailsState extends State<PersonalDetails> {
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
  bool _saving = false;
  bool enableEmailEditing = false;
  bool enableKidsEditing = false;
  bool enableMotherEditing = false;
  bool enableFatherEditing = false;
  bool change = false;
  bool startUpdate = false;
  File? file;
  bool showUpdateButton = false;
  final List<String> martialStatusList = ['Select', 'Married', 'Single'];
  String? initialMartialStatus = 'Select';
  bool isMartialEdit = false;
  sendToscreen(var page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  late FocusNode emailFocusNode;
  late FocusNode noOfKidsFocusNode;
  late FocusNode motherFocusNode;
  late FocusNode fatherFocusNode;
  void showKeyboard(FocusNode focusNode) {
    focusNode.requestFocus();
  }

  Future getImagefromGallery({required ImageSource imageSource}) async {
    try {
      var image = await ImagePicker().pickImage(source: imageSource);

      if (image != null) {
        setState(() {
          final File? file = File(image.path);
          print('asdfsd');
          print(file!.path);
          print(file);
        });
        setState(() {
          _saving = true;
        });
        SharedPreferences preferences = await SharedPreferences.getInstance();
        Object? token = preferences.get("token");
        var data = await putImage(path: image.path, token: '$token');
        if (data != null) {
          var json = jsonDecode(data);
          Provider.of<Customer>(context, listen: false)
              .setProfilePhoto(imageLink: json['data']['profile_image']);
          print(json['data']['profile_image']);
        }
      } else {}
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<String?> putImage({
    required String token,
    required String path,
  }) async {
    // TODO: Move this to dart client
    var headers = {
      'Authorization': 'Bearer $token',
    };
    var request = http.MultipartRequest(
        'PUT',
        Uri.parse(
            'https://devo.resilient-ai.com/v1/users/${Provider.of<Customer>(context, listen: false).userId}/upload'));
    request.files.add(await http.MultipartFile.fromPath('profile_image', path));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      setState(() {
        _saving = false;
      });
      Fluttertoast.showToast(
          msg: "Profile Photo Updated Successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: const Color(0xff084E6C),
          textColor: Colors.white,
          fontSize: 16.0);
      return result;
    } else {
      Fluttertoast.showToast(
        msg: '${response.reasonPhrase}',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: const Color(0xff084E6C),
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return null;
    }
  }

  putData(
      {required bool martialStatus,
      required bool noOfKids,
      required bool email}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    Object? token = preferences.get("token");
    apiClient.setAccessToken(token as String);
    UsersUserIdPutBody userBody = UsersUserIdPutBody.fromJson({
      // "id": Provider.of<Customer>(context, listen: false).clientCustomerId,
      'email': emailController.text,
      'family_info': {
        // 'father_name': 'harhs l',
        // 'mother_name': 'sdfsdf',
        'child_count': 12,
      }
    });

    final res2 = await userApi.v1UsersUserIdPut(
        '${Provider.of<Customer>(context, listen: false).userId}',
        body: userBody);

    Provider.of<Customer>(context, listen: false)
        .setCustomer(res2, UserState.OTPVerified);
  }

  showAlertDialog(BuildContext context) {
    // set up the button

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      alignment: Alignment.center,
      content: Container(
        height: 120,
        width: double.maxFinite,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ListTile(
                leading: Icon(Icons.photo),
                title: Text(
                  'Choose from Gallery',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  getImagefromGallery(imageSource: ImageSource.gallery);
                },
              ),
              ListTile(
                leading: Icon(Icons.camera),
                title: Text(
                  'Take from Camera',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  getImagefromGallery(imageSource: ImageSource.camera);
                },
              ),
            ],
          ),
        ),
      ),
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showPickImageDialouge() {
    return AlertDialog(
      title: Text('sfdsd'),
      content: Column(
        children: [
          TextButton(
            onPressed: () {
              getImagefromGallery(imageSource: ImageSource.gallery);
            },
            child: const Text('Choose from Gallery'),
          ),
          TextButton(
            onPressed: () {
              getImagefromGallery(imageSource: ImageSource.camera);
            },
            child: const Text('Take from Camera'),
          ),
        ],
      ),
    );
  }

  setData() async {
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
  void dispose() {
    super.dispose();
    emailFocusNode.dispose();
    noOfKidsFocusNode.dispose();
    motherFocusNode.dispose();
    fatherFocusNode.dispose();
  }

  @override
  void initState() {
    if (mounted) {
      setState(() {
        emailFocusNode = FocusNode();
        noOfKidsFocusNode = FocusNode();
        motherFocusNode = FocusNode();
        fatherFocusNode = FocusNode();
      });
    }
    super.initState();
    setData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: ModalProgressHUD(
          inAsyncCall: _saving,
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    GestureDetector(
                      child: buildProfileTop(),
                      onTap: () {
                        print('asdfs');
                        showAlertDialog(context);
                      },
                    ),
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
                          ? familyDetailsFields()
                          : profileDetailFields(),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              showUpdateButton ? buildupdateButton() : Container(),
            ],
          ),
        ),
      ),
    );
  }

  Padding buildupdateButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5.0),
      child: UsedButton(
        buttonName: startUpdate
            ? circularProgressIndicator
            : const Center(
                child: Text(
                  'Update',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18.0),
                ),
              ),
        onpressed: () {
          updateProfileFieldData();
        },
      ),
    );
  }

  updateProfileFieldData() async {
    try {
      setState(() {
        startUpdate = true;
      });

      await putData(martialStatus: true, email: false, noOfKids: false);

      setState(() {
        startUpdate = false;
        isMartialEdit = false;
        showUpdateButton = false;
      });
      Fluttertoast.showToast(
        msg: "Data Updated Successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: const Color(0xff084E6C),
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } catch (e) {
      print(e);
    }
  }

  Column familyDetailsFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        buildTitleName(
          title: "Father’s Name",
        ),
        buildTextField(
          haveSufix: true,
          enabled: true,
          focusNode: fatherFocusNode,
          editButtonFunction: () {
            setState(() {
              enableFatherEditing = true;
              showKeyboard(fatherFocusNode);
            });
          },
          controller: fatherNameController,
        ),
        const SizedBox(
          height: 16.5,
        ),
        buildTitleName(
          title: "Mother’s Name",
        ),
        buildTextField(
          haveSufix: true,
          enabled: true,
          controller: motherNameController,
          focusNode: motherFocusNode,
          editButtonFunction: () {
            setState(() {
              enableMotherEditing = true;
              showKeyboard(motherFocusNode);
            });
          },
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
          enabled: true,
          focusNode: noOfKidsFocusNode,
          textInputType: TextInputType.number,
          editButtonFunction: () {
            setState(() {
              enableKidsEditing = true;
              showKeyboard(noOfKidsFocusNode);
            });
          },
        ),
      ],
    );
  }

  DropdownButton dropDownButton({
    required value,
    required List<String> list,
    required void Function(String? value)? onChanged,
  }) {
    return DropdownButton<String>(
      icon: const Padding(
        padding: EdgeInsets.only(right: 17.0),
        child: Icon(
          Icons.edit,
          color: Color(0xff084E6C),
        ),
      ),
      value: value,
      style: const TextStyle(
        fontWeight: FontWeight.w500,
        color: Colors.black,
        overflow: TextOverflow.ellipsis,
        fontSize: 17.0,
      ),
      items: list.map((String s) {
        return DropdownMenuItem<String>(
          value: s,
          child: Text(s),
        );
      }).toList(),
      iconSize: 17.0,
      onChanged: onChanged,
      isExpanded: true,
    );
  }

  Column profileDetailFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // buildTitleName(
        //   title: 'Aadhar Number',
        // ),
        // buildTextField(
        //   controller: adharController,
        // ),

        buildTitleName(
          title: 'Email Id',
        ),
        buildTextField(
          controller: emailController,
          haveSufix: true,
          enabled: true,
          focusNode: emailFocusNode,
          textInputType: TextInputType.emailAddress,
          editButtonFunction: () {
            setState(() {
              enableEmailEditing = true;
              showKeyboard(emailFocusNode);
            });
          },
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
        dropDownButton(
          value: initialMartialStatus,
          list: martialStatusList,
          onChanged: onStateDropDownChanged,
        )
      ],
    );
  }

  void onStateDropDownChanged(String? value) {
    if (value != initialMartialStatus) {
      setState(() {
        initialMartialStatus = value;
        isMartialEdit = true;
        showUpdateButton = true;
        print(value);
        print(initialMartialStatus);
      });
    }
  }

  TextField buildTextField({
    required TextEditingController controller,
    bool? haveSufix,
    bool? enabled,
    FocusNode? focusNode,
    VoidCallback? editButtonFunction,
    TextInputType? textInputType,
  }) {
    return TextField(
      keyboardType: textInputType ?? TextInputType.none,
      onChanged: (e) {
        setState(() {
          showUpdateButton = true;
        });
      },
      focusNode: focusNode,
      enabled: enabled ?? false,
      controller: controller,
      style: const TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 17.0,
      ),
      decoration: InputDecoration(
        suffixIcon: haveSufix == true
            ? IconButton(
                onPressed: editButtonFunction,
                icon: const Icon(
                  Icons.edit,
                  color: Color(0xff084E6C),
                  size: 17.0,
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
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30.0,
                    vertical: 16.0,
                  ),
                  child: Text(
                    "Personal Info",
                    style: TextStyle(
                      color: change
                          ? const Color(0xff5C5C5C)
                          : const Color(0xffDD2E44),
                      fontSize: 17.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Container(
                height: 15,
                width: 2.0,
                color: const Color(0xffF2F2F2),
              ),
              InkWell(
                onTap: callback,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30.0,
                    vertical: 16.0,
                  ),
                  child: Text(
                    "Family Details",
                    style: TextStyle(
                      color: change
                          ? const Color(0xffDD2E44)
                          : const Color(0xff5C5C5C),
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
        context: context,
        progress: widget.profileProgressint,
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
        // const SizedBox(
        //   height: 10.0,
        // ),
        // const Center(
        //   child: Text(
        //     'harsh@icici',
        //     style: TextStyle(
        //       color: Color(0xff5C5C5C),
        //       fontSize: 17.0,
        //     ),
        //   ),
        // ),
      ],
    );
  }

  Stack buildProfileTop() {
    String? profileImage =
        Provider.of<Customer>(context, listen: false).profileImage;
    String? name = Provider.of<Customer>(context, listen: false).customerName;
    String initials() {
      return ((name?.isNotEmpty == true ? name![0] : "")).toUpperCase();
    }

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 16.0,
              ),
              alignment: AlignmentDirectional.topStart,
              height: 122,
              color: const Color(0xff054561),
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
            clipBehavior: Clip.none,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(72.0),
                ),
                child: CircleAvatar(
                  backgroundImage:
                      profileImage != null ? NetworkImage(profileImage) : null,
                  backgroundColor: Colors.grey,
                  child: profileImage == null ? Text(initials()) : null,
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
