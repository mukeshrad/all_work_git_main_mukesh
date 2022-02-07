import 'package:finandy/constants/Colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ViewRCSelectImage extends StatefulWidget {
  const ViewRCSelectImage({Key? key}) : super(key: key);

  @override
  _ViewRCSelectImageState createState() => _ViewRCSelectImageState();
}

class _ViewRCSelectImageState extends State<ViewRCSelectImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: appWhiteColor,
        body: Column(
          children: [
            Expanded(
              child: Container(),
            ),
            Container(
              child: TextButton(
                onPressed: () async {
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => ThanksYouCaseBackPage()));
                },
                child: Container(
                  margin: const EdgeInsets.only(
                      left: 20, right: 20, bottom: 15, top: 15),
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
              child: TextButton(
                onPressed: () async {
                  //
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => ThanksYouCaseBackPage()));
                },
                child: Container(
                  margin: const EdgeInsets.only(
                      left: 20, right: 20, bottom: 15, top: 15),
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
            )
          ],
        ));
  }

  //********************** IMAGE PICKER
  Future imageSelector(BuildContext context, String pickerType) async {
    switch (pickerType) {
      case "gallery":

        /// GALLERY IMAGE PICKER
        //   imageFile = await ImagePicker.pickImage(
        //       source: ImageSource.gallery, imageQuality: 90);
        //   break;
        final ImagePicker _picker = ImagePicker();

        try {
          final pickedFile =
              await _picker.pickImage(source: ImageSource.gallery);
          setState(() {
            // print(pickedFile?.name.toString());
            // _imageFile = pickedFile;
          });
        } catch (e) {
          setState(() {
            // _pickImageError = e;
          });
        }
        break;

      case "camera": // CAMERA CAPTURE CODE
        // imageFile = await ImagePicker.pickImage(
        //     source: ImageSource.camera, imageQuality: 90);

        final ImagePicker _picker = ImagePicker();

        try {
          final pickedFile =
              await _picker.pickImage(source: ImageSource.camera);
          setState(() {
            // print(pickedFile?.name.toString());
            // _imageFile = pickedFile;
          });
        } catch (e) {
          setState(() {
            // _pickImageError = e;
          });
        }

        break;
    }
  }
}
