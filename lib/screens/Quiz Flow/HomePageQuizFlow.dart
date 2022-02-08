import 'dart:io';

import 'package:finandy/constants/Colors.dart';
import 'package:finandy/constants/texts.dart';
import 'package:flutter/material.dart';

import 'RCUploadImages/RCUploadImage.dart';
import 'ThanksYouCaseback.dart';

class QuizHome extends StatefulWidget {
  const QuizHome({Key? key}) : super(key: key);

  @override
  _QuizHomeState createState() => _QuizHomeState();
}

class _QuizHomeState extends State<QuizHome> {
  final _vehicles = ["Car", "Bike/Scooter", "Planning "];
  var _vehiclesSelect = -1;
  final _textVechileController = TextEditingController();
  final _txtRCImageControler = TextEditingController();

  var btnSubmitEnable = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Text('Quiz Home'),
          ),
          body: Container(
              margin: EdgeInsets.only(top: 50),
              alignment: Alignment.center,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                verticalDirection: VerticalDirection.down,

                children: [
                  ElevatedButton(
                    onPressed: bottomSheetCaseBack, // bottomModalSheet,

                    child: Text(instant),
                  ),
                  ElevatedButton(
                    onPressed: bottomSheetAdditionCaseBack, // bottomModalSheet,
                    child: Text(additional),
                  ),
                  ElevatedButton(
                    onPressed: () async {

                      List<File> result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RCUploadImages()));

                      print("object : ${result.first}");
                      _txtRCImageControler.text =
                          result.first.path.toString();

                      setState(() => () {
                        // fileName = "deepak.png";
                      });
                      // bottomSheetUplodeRCImages();
                    }, // bottomModalSheet,
                    child: Text(rcImageUpload),
                  )
                ],
              )),
        ));
  }

  void bottomSheetCaseBack() {
    showModalBottomSheet<dynamic>(
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (BuildContext context, setState) {
              return SingleChildScrollView(
                // controller: scrollController,
                child: Column(
                  children: <Widget>[
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: const BoxDecoration(
                          color: appWhiteColor,
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Image.asset(
                          "assets/images/DownEro.png",
                          height: 30,
                          width: 30,
                        ),
                      ),
                      margin: EdgeInsets.only(top: 10, bottom: 15),
                    ),
                    Container(
                      child: Column(
                        children: [
                          const Text(
                            'Answer and win ₹ 1 instant cashback',
                            style: TextStyle(
                                fontSize: 18,
                                color: appBlackColor,
                                fontWeight: FontWeight.w500),
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                                left: 30, right: 30, top: 15, bottom: 18),
                            height: 0.5,
                            color: appGrey2Color,
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 30, right: 30),
                            alignment: Alignment.centerLeft,
                            child: const Text(
                              'Do you have a Vehicle?',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: appBlackColor,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: _vehicles.length * 70,
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        // Let the ListView know how many items it needs to build.
                        itemCount: _vehicles.length,
                        // Provide a builder function. This is where the magic happens.
                        // Convert each item into a widget based on the type of item it is.
                        itemBuilder: (context, index) {
                          final item = _vehicles[index];
                          return Container(
                            margin: EdgeInsets.only(top: 10),
                            child: Card(
                              elevation: 4,
                              color: _vehiclesSelect == index
                                  ? appBlueGColor
                                  : appWhiteColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              margin: EdgeInsets.symmetric(horizontal: 28),
                              child: ListTile(
                                onTap: () async {
                                  setState(() {
                                    _vehiclesSelect = index;
                                  });
                                },
                                title: Center(
                                  child: Text(
                                    item.toString(),
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: _vehiclesSelect == index
                                            ? appWhiteColor
                                            : appGrey1Color,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                          left: 30, right: 30, top: 10, bottom: 5),
                      height: 0.5,
                      color: appGrey2Color,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.only(left: 20),
                      child: ListTile(
                        onTap: () {
                          Navigator.pop(context);
                          // Navigator.push(context, pageR(const AgentProfile()));
                        },
                        // tileColor: Colors.blue,
                        leading: const Text(
                          'Terms & Conditions*',
                          style: TextStyle(
                              fontSize: 12,
                              color: appGrey1Color,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          );
        });
  }

  void bottomSheetAdditionCaseBack() {
    showModalBottomSheet<dynamic>(
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
        context: context,
        builder: (context) {
          return Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: StatefulBuilder(
                builder: (BuildContext context, setState) {
                  return SingleChildScrollView(
                    // controller: scrollController,
                    child: Column(
                      children: <Widget>[
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          decoration: const BoxDecoration(
                              color: appWhiteColor,
                              borderRadius:
                              BorderRadius.all(Radius.circular(15))),
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Image.asset(
                              "assets/images/DownEro.png",
                              height: 30,
                              width: 30,
                            ),
                          ),
                          margin: EdgeInsets.only(top: 10, bottom: 15),
                        ),
                        Container(
                          child: Column(
                            children: [
                              const Text(
                                'Answer and win ₹ 1 Additional cashback',
                                style: TextStyle(
                                    fontSize: 18,
                                    color: appBlackColor,
                                    fontWeight: FontWeight.w500),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                    left: 30, right: 30, top: 15, bottom: 18),
                                height: 0.5,
                                color: appGrey2Color,
                              ),
                              Container(
                                margin:
                                const EdgeInsets.only(left: 30, right: 30),
                                alignment: Alignment.centerLeft,
                                child: const Text(
                                  'Enter Vehicle Number',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: appBlackColor,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              )
                            ],
                          ),
                        ),
                        Container(
                          height: 70,
                          margin: const EdgeInsets.only(left: 30, right: 30),
                          child: TextFormField(
                            cursorColor: Colors.black,
                            controller: _textVechileController,
                            onChanged: (text) {
                              if (text.isEmpty) {
                                btnSubmitEnable = false;
                              } else {
                                btnSubmitEnable = true;
                              }

                              setState(() {});
                            }, // keyboardType: inputType,
                            decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: appGrey3Color, width: 0.5),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: appGrey3Color, width: 0.5),
                                ),
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                contentPadding: EdgeInsets.only(
                                    left: 30, bottom: 5, top: 5, right: 30),
                                hintText: "Ex. MHO2 XY1232"),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              left: 30, right: 30, top: 0, bottom: 10),
                          height: 0.5,
                          color: appGrey2Color,
                        ),
                        TextButton(
                          onPressed: () async {
                            if (btnSubmitEnable == true) {
                              Navigator.pop(context);

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ThanksYouCaseBackPage()));
                            }
                          },
                          child: Container(
                            margin: const EdgeInsets.only(
                                left: 20, right: 20, bottom: 0, top: 0),
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: appBlueGColor.withOpacity(
                                    (btnSubmitEnable == true) ? 1 : 0.5),
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 15),
                              child: Center(
                                  child: Text(
                                    'Submit',
                                    style: TextStyle(color: appWhiteColor),
                                  )),
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          // margin: const EdgeInsets.only(left: 20),

                          child: ListTile(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            // tileColor: Colors.blue,
                            title: Center(
                              child: Text(
                                'Terms & Conditions*',
                                style: TextStyle(
                                    fontSize: 12,
                                    color: appGrey1Color,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
              ));
        });
  }

  void bottomSheetUplodeRCImages() {
    showModalBottomSheet<dynamic>(
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
        context: context,
        builder: (context) {
          String fileName = "";

          return Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: StatefulBuilder(
                builder: (BuildContext context, setState) {
                  return SingleChildScrollView(
                    // controller: scrollController,
                    child: Column(
                      children: <Widget>[
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          decoration: const BoxDecoration(
                              color: appWhiteColor,
                              borderRadius:
                              BorderRadius.all(Radius.circular(15))),
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Image.asset(
                              "assets/images/DownEro.png",
                              height: 30,
                              width: 30,
                            ),
                          ),
                          margin: EdgeInsets.only(top: 10, bottom: 15),
                        ),
                        Container(
                          child: Column(
                            children: [
                              const Text(
                                'Attach a File',
                                style: TextStyle(
                                    fontSize: 18,
                                    color: appBlackColor,
                                    fontWeight: FontWeight.w500),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                    left: 30, right: 30, top: 15, bottom: 18),
                                height: 0.5,
                                color: appGrey2Color,
                              ),
                              Container(
                                margin:
                                const EdgeInsets.only(left: 30, right: 30),
                                alignment: Alignment.centerLeft,
                                child: const Text(
                                  'Upload Image of RC',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: appBlackColor,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              )
                            ],
                          ),
                        ),
                        Container(
                          height: 70,
                          margin: const EdgeInsets.only(left: 30, right: 30),
                          child: TextFormField(
                            enableInteractiveSelection: false,
                            focusNode: FocusNode(),
                            //   enabled: false,

                            onTap: () async {
                              FocusScope.of(context).requestFocus(FocusNode());

                              // List<File> result = await Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => RCUploadImages()));
                              //
                              // print("object : ${result.first}");
                              // _txtRCImageControler.text =
                              //     result.first.path.toString();
                              //
                              // setState(() => () {
                              //   fileName = "deepak.png";
                              // });
                            },
                            cursorColor: Colors.black,
                            controller: _txtRCImageControler,
                            onChanged: (text) {
                              if (text.isEmpty) {
                                btnSubmitEnable = false;
                              } else {
                                btnSubmitEnable = true;
                              }

                              setState(() {});
                            }, // keyboardType: inputType,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: appGrey3Color, width: 0.5),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: appGrey3Color, width: 0.5),
                              ),
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              contentPadding: EdgeInsets.only(
                                  left: 30, bottom: 5, top: 5, right: 30),
                              hintText: fileName,
                              suffixIcon: IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.photo_camera),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              left: 30, right: 30, top: 0, bottom: 10),
                          height: 0.5,
                          color: appGrey2Color,
                        ),
                        TextButton(
                          onPressed: () async {
                            if (btnSubmitEnable == true) {
                              Navigator.pop(context);

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ThanksYouCaseBackPage()));
                            }
                          },
                          child: Container(
                            margin: const EdgeInsets.only(
                                left: 20, right: 20, bottom: 0, top: 0),
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: appBlueGColor.withOpacity(
                                    (btnSubmitEnable == true) ? 1 : 0.5),
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 15),
                              child: Center(
                                  child: Text(
                                    'Submit',
                                    style: TextStyle(color: appWhiteColor),
                                  )),
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          // margin: const EdgeInsets.only(left: 20),

                          child: ListTile(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            // tileColor: Colors.blue,
                            title: Center(
                              child: Text(
                                'Terms & Conditions*',
                                style: TextStyle(
                                    fontSize: 12,
                                    color: appGrey1Color,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
              ));
        });
  }

//Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => RCUploadImages()));
}
