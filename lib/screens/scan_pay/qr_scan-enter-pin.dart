import 'dart:async';

import 'package:finandy/constants/instances.dart';
import 'package:finandy/screens/scan_pay/transactionstatus.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:swagger/api.dart';

class Screen3 extends StatefulWidget {
  var Screen2Data;
  Screen3({Key? key, this.Screen2Data}) : super(key: key);

  @override
  State<Screen3> createState() => _Screen3(Screen2Data);
}

//
class _Screen3 extends State<Screen3> {
  var Screen2Data;
  _Screen3(this.Screen2Data);
  var _name = "XYZ";
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "PIN",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        centerTitle: false,
      ),
      body: Container(
        margin: EdgeInsets.only(left: 25, right: 25, top: 30),
        // child: PageForm(value_: Screen2Data),
        child: PageForm(),
      ),
    );
  }
}

class PageForm extends StatefulWidget {
  var value_;
  // PageForm({Key? key, required this.value_}) : super(key: key);
  @override
  _PageFormState createState() => _PageFormState();
}

class _PageFormState extends State<PageForm> {
  var value_;
  final _formKey = GlobalKey<FormState>();
  bool isChecked = false;
  var _autoValidate;
  late int currentText;
  TextEditingController textEditingController = TextEditingController();

  late StreamController<ErrorAnimationType> errorController;
  @override
  void initState() {
    super.initState();
    value_ = widget.value_;
    errorController = StreamController<ErrorAnimationType>();
  }

  @override
  void dispose() {
    errorController.close();

    super.dispose();
  }

  Position? position;

  initiateTransaction(ctx) async {
    var cardId = "61e59ae1d24908001d5fa93d"; // String | Card Id | Apoorv
    var trId = "trId_example"; // String | Transaction Id
    final TrIdInitiateBody body_ =
        TrIdInitiateBody.fromJson({"pin": currentText}); // TrIdInitiateBody |

    try {
      var result = await transactionInstance
          .v1CardsCardIdTransactionsTrIdInitiatePut(cardId, trId, body: body_);
      print(result);
    } catch (e) {
      print(
          "Exception when calling TransactionsApi->v1CardsCardIdTransactionsTrIdInitiatePut: $e\n");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Card(
            child: ListTile(
              leading: Icon(Icons.assignment_turned_in_outlined),
              // title: Text(value_["upiname"]),
              // subtitle: Text("${value_["upiId"]}"),
              title: Text("XYZ"),
              subtitle: Text("XYZ"),
            ),
          ),
          Spacer(),
          // SizedBox(height: 200),
          PinCodeTextField(
            // onSubmitted: ,
            length: 4,
            obscureText: true,
            obscuringCharacter: '●',
            animationType: AnimationType.fade,
            pinTheme: PinTheme(
              shape: PinCodeFieldShape.underline,
              borderRadius: BorderRadius.circular(5),
              fieldHeight: 50,
              fieldWidth: 30,
            ),
            animationDuration: Duration(milliseconds: 300),
            // backgroundColor: Colors.white,
            onChanged: (value) {
              if(value.length == 4){
                setState(() {
                  currentText = int.parse(value);
                });
              }else{
                setState(() {
                  currentText = int.parse(value);
                });
              }
            },
            appContext: context,
          ),
          // SizedBox(height: 200),
          Spacer(),
          Flexible(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 20),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => TransactionStatus()));
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      "Pay",
                      style: TextStyle(fontSize: 20),
                    ),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
