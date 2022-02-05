import 'package:finandy/constants/instances.dart';
import 'package:finandy/screens/scan_pay/transactionstatus.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
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
        title: Text("Pay to ${_name}"),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 25, right: 25, top: 30, bottom: 90),
          child: PageForm(value_: Screen2Data),
        ),
      ),
    );
  }
}

class PageForm extends StatefulWidget {
  var value_;
  PageForm({Key? key, required this.value_}) : super(key: key);
  @override
  _PageFormState createState() => _PageFormState(value_);
}

class _PageFormState extends State<PageForm> {
  var value_;
  _PageFormState(this.value_);
  final _formKey = GlobalKey<FormState>();
  bool isChecked = false;
  var _user;
  var _autoValidate;
  Position? position;

  initiateTransaction(ctx) async {
    var cardId = "61e59ae1d24908001d5fa93d"; // String | Card Id | Apoorv
    var trId = "trId_example"; // String | Transaction Id
    final TrIdInitiateBody body_ = TrIdInitiateBody.fromJson({
      "preferences": {"status": "Pending"}
    }); // TrIdInitiateBody |

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
        // autovalidateMode: AutovalidateMode.always,
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Card(
              child: ListTile(
                leading: Icon(Icons.assignment_turned_in_outlined),
                title: Text(value_["upiname"]),
                subtitle: Text("${value_["upiId"]}"),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Pin',
              ),
              onSaved: (value) {
                _user = value;
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please enter your Pin";
                }
                return null;
              },
            ),
            SizedBox(height: 120),
            Container(
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
          ],
        ));
  }
}
