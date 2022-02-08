import 'package:finandy/constants/Colors.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';

class RetakeImageSubmit extends StatefulWidget {
  File imageFile;

  RetakeImageSubmit({Key? key, required this.imageFile}) : super(key: key);

  @override
  _RetakeImageSubmitState createState() => _RetakeImageSubmitState();
}

class _RetakeImageSubmitState extends State<RetakeImageSubmit> {
  late File selectFile;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    selectFile = widget.imageFile;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: appWhiteColor,
        body: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: appBlueGColor, width: 1),
                    borderRadius: BorderRadius.circular(5)),
                margin:
                EdgeInsets.only(top: 100, left: 30, right: 30, bottom: 10),
                width: double.infinity,
                child: Column(
                  children: [
                    Expanded(
                      child: Padding(
                        // padding: EdgeInsets,
                        padding: EdgeInsets.all(4),
                        child: Image.file(
                          selectFile,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    // Container(
                    //     width: double.infinity,
                    //     height: 44,
                    //     decoration: BoxDecoration(color: appBlueGColor),
                    //     child: Center(
                    //       child: Text(
                    //         'Front Side',
                    //         style: TextStyle(
                    //             fontSize: 18,
                    //             color: appWhiteColor,
                    //             fontWeight: FontWeight.w500),
                    //       ),
                    //     ))
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 60),
              height: 70,
              child: TextButton(
                onPressed: () async {
                  Navigator.pop(context, selectFile);
                },
                child: Container(
                  margin: const EdgeInsets.only(
                      left: 20, right: 20, bottom: 0, top: 0),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: appBlueGColor,
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
            ),
            Container(
              height: 70,
              margin: EdgeInsets.only(bottom: 40),
              child: TextButton(
                onPressed: () async {

                  final ImagePicker _picker = ImagePicker();
                  //
                  try {
                    final pickedFile =
                    await _picker.pickImage(source: ImageSource.camera);
                    setState(() {
                      // print(pickedFile?.name.toString());
                      if (pickedFile != null) {
                        var imageFile = File(pickedFile.path);

                        setState(() {
                          selectFile = imageFile;
                        });
                      }
                    });
                  } catch (e) {
                    setState(() {
                      // _pickImageError = e;
                    });
                  }
                },
                child: Container(
                  margin: const EdgeInsets.only(
                      left: 20, right: 20, bottom: 0, top: 0),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    // color: appBlueGColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                    child: Center(
                        child: Text(
                          'Retake',
                          style: TextStyle(
                            color: appBlackColor,
                            decoration: TextDecoration.underline,
                          ),
                        )),
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
