import 'dart:io';
import 'package:finandy/constants/Colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'ImageSubmitRetake.dart';

class RCUploadImages extends StatefulWidget {
  const RCUploadImages({Key? key}) : super(key: key);

  @override
  _RCUploadImagesState createState() => _RCUploadImagesState();
}

class _RCUploadImagesState extends State<RCUploadImages> {
  var btnSubmitEnable = false;
  File? selectFileFont;
  File? selectFileBack;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Upload Image'),
          elevation: 0,
        ),
        backgroundColor: appWhiteColor,
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[fontSide(), backSide()],
                ),
              ),
            ),
            Container(
              child: TextButton(
                onPressed: () async {
                  if ((selectFileFont != null) && (selectFileBack != null)) {
                    Navigator.pop(context, [selectFileFont, selectFileBack]);
                  }
                },
                child: Container(
                  margin: const EdgeInsets.only(
                      left: 20, right: 20, bottom: 15, top: 15),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: appBlueGColor
                          .withOpacity((btnSubmitEnable == true) ? 1 : 0.5),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    child: Center(
                        child: Text(
                      'Submit',
                      style: TextStyle(color: appWhiteColor),
                    )),
                  ),
                ),
              ),
            )
          ],
        ));
  }

  Widget fontSide() {
    if (selectFileFont == null) {
      return fontSideWithoutImageContainer();
    } else {
      return fontSideWithImageContainer();
    }
  }

  Widget backSide() {
    if ((selectFileFont != null) && (selectFileBack != null)) {
      btnSubmitEnable = true;
    }

    if (selectFileBack == null) {
      return backSideWithoutImageContainer();
    } else {
      return backSideWithImageContainer();
    }
  }

  Widget fontSideWithoutImageContainer() {
    return Container(
      margin: const EdgeInsets.only(left: 30, right: 30, bottom: 0, top: 30),
      height: 212,
      decoration: BoxDecoration(
          border: Border.all(color: appBlueGColor, width: 1),
          borderRadius: BorderRadius.circular(5)),
      child: TextButton(
        style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size(50, 30),
            alignment: Alignment.centerLeft),
        onPressed: () async {
          // Navigator.push(context,
          //     MaterialPageRoute(builder: (context) => ViewRCSelectImage()));

          // imageSelector(context, "camera");
          openCamera("font");
        },
        child: Container(
          width: double.infinity,
          child: Column(
            children: [
              Expanded(
                  child: Center(
                child: Image.asset(
                  "assets/images/frontSideCam.png",
                  fit: BoxFit.cover,
                  height: 70,
                  width: 70,
                ),
              )),
              Container(
                  width: double.infinity,
                  height: 44,
                  decoration: BoxDecoration(color: appBlueGColor),
                  child: Center(
                    child: Text(
                      'Front Side',
                      style: TextStyle(
                          fontSize: 18,
                          color: appWhiteColor,
                          fontWeight: FontWeight.w500),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Widget backSideWithoutImageContainer() {
    return Container(
      margin: const EdgeInsets.only(left: 30, right: 30, bottom: 20, top: 40),
      height: 212,
      decoration: BoxDecoration(
          border: Border.all(color: appRedBGColor, width: 1),
          borderRadius: BorderRadius.circular(5)),
      child: TextButton(
        style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size(50, 30),
            alignment: Alignment.centerLeft),
        onPressed: () async {
          openCamera("back");
        },
        child: Container(
          width: double.infinity,
          child: Column(
            children: [
              Expanded(
                  child: Center(
                child: Image.asset(
                  "assets/images/backSideCam.png",
                  fit: BoxFit.cover,
                  height: 70,
                  width: 70,
                ),
              )),
              Container(
                  width: double.infinity,
                  height: 44,
                  decoration: BoxDecoration(color: appRedBGColor),
                  child: Center(
                    child: Text(
                      'Back Side',
                      style: TextStyle(
                          fontSize: 18,
                          color: appWhiteColor,
                          fontWeight: FontWeight.w500),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Widget fontSideWithImageContainer() {
    return Container(
      margin: const EdgeInsets.only(left: 30, right: 30, bottom: 0, top: 30),
      height: 212,
      decoration: BoxDecoration(
          border: Border.all(color: appBlueGColor, width: 1),
          borderRadius: BorderRadius.circular(5)),
      child: TextButton(
        style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size(50, 30),
            alignment: Alignment.centerLeft),
        onPressed: () async {
          // Navigator.push(context,
          //     MaterialPageRoute(builder: (context) => ViewRCSelectImage()));

          // imageSelector(context, "camera");
          openCamera("font");
        },
        child: Container(
          width: double.infinity,
          child: Column(
            children: [
              Expanded(
                child: Image.file(
                  selectFileFont!,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                  width: double.infinity,
                  height: 44,
                  decoration: BoxDecoration(color: appBlueGColor),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'Front Side',
                        style: TextStyle(
                            fontSize: 18,
                            color: appWhiteColor,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(),
                      TextButton(
                        onPressed: () async {
                          openCamera("font");
                        },
                        child: Text(
                          'Retake',
                          style: TextStyle(
                              fontSize: 18,
                              color: appWhiteColor,
                              fontWeight: FontWeight.w500,
                              decoration: TextDecoration.underline),
                        ),
                      )
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Widget backSideWithImageContainer() {
    return Container(
      margin: const EdgeInsets.only(left: 30, right: 30, bottom: 0, top: 30),
      height: 212,
      decoration: BoxDecoration(
          border: Border.all(color: appBlueGColor, width: 1),
          borderRadius: BorderRadius.circular(5)),
      child: TextButton(
        style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size(50, 30),
            alignment: Alignment.centerLeft),
        onPressed: () async {
          // Navigator.push(context,
          //     MaterialPageRoute(builder: (context) => ViewRCSelectImage()));

          // imageSelector(context, "camera");
          openCamera("font");
        },
        child: Container(
          width: double.infinity,
          child: Column(
            children: [
              Expanded(
                child: Image.file(
                  selectFileBack!,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                  width: double.infinity,
                  height: 44,
                  decoration: BoxDecoration(color: appRedBGColor),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'Back Side',
                        style: TextStyle(
                            fontSize: 18,
                            color: appWhiteColor,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(),
                      TextButton(
                        onPressed: () async {
                          openCamera("back");
                        },
                        child: Text(
                          'Retake',
                          style: TextStyle(
                              fontSize: 18,
                              color: appWhiteColor,
                              fontWeight: FontWeight.w500,
                              decoration: TextDecoration.underline),
                        ),
                      )
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Future<void> openCamera(String type) async {
    final ImagePicker _picker = ImagePicker();
    //
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.camera);
      setState(() async {
        print(pickedFile?.name.toString());

        if (pickedFile != null) {
          var imageFile = File(pickedFile.path);

          final result = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => RetakeImageSubmit(imageFile: imageFile)),
          );

          if (type == "font") {
            selectFileFont = result;
          } else {
            selectFileBack = result;
          }

          setState(() {});
        }
      });
    } catch (e) {
      setState(() {
        // _pickImageError = e;
      });
    }
  }
}
