import 'package:finandy/constants/Colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class RCUploadImages extends StatefulWidget {
  const RCUploadImages({Key? key}) : super(key: key);

  @override
  _RCUploadImagesState createState() => _RCUploadImagesState();
}

class _RCUploadImagesState extends State<RCUploadImages> {
  var btnSubmitEnable = false;
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
                  children: <Widget>[
                    fontSideWithoutImageContainer(),
                    backSideWithoutImageContainer()
                  ],
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
        onPressed: () async {},
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

  // //********************** IMAGE PICKER
  // Future imageSelector(BuildContext context, String pickerType) async {
  //   switch (pickerType) {
  //     case "gallery":
  //
  //     /// GALLERY IMAGE PICKER
  //     //   imageFile = await ImagePicker.pickImage(
  //     //       source: ImageSource.gallery, imageQuality: 90);
  //     //   break;
  //       final ImagePicker _picker = ImagePicker();
  //
  //       try {
  //         final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
  //         setState(() {
  //           print(pickedFile?.name.toString());
  //           // _imageFile = pickedFile;
  //         });
  //       } catch (e) {
  //         setState(() {
  //          // _pickImageError = e;
  //         });
  //       }
  //       break;
  //
  //     case "camera": // CAMERA CAPTURE CODE
  //       // imageFile = await ImagePicker.pickImage(
  //       //     source: ImageSource.camera, imageQuality: 90);
  //
  //       final ImagePicker _picker = ImagePicker();
  //
  //       try {
  //         final pickedFile = await _picker.pickImage(source: ImageSource.camera);
  //         setState(() {
  //           print(pickedFile?.name.toString());
  //           // _imageFile = pickedFile;
  //         });
  //       } catch (e) {
  //         setState(() {
  //           // _pickImageError = e;
  //         });
  //       }
  //
  //       break;
  //   }
  //
  // }
  //
  // Image picker
  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                    title: new Text('Gallery'),
                    onTap: () => {
                          // imageSelector(context, "gallery"),
                          Navigator.pop(context),
                        }),
                new ListTile(
                  title: new Text('Camera'),
                  onTap: () => {
                    // imageSelector(context, "camera"),
                    Navigator.pop(context)
                  },
                ),
              ],
            ),
          );
        });
  }
}
