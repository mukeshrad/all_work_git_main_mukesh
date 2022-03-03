import 'dart:async';
import 'dart:ffi';

import 'package:finandy/constants/instances.dart';
import 'package:finandy/modals/card_schema.dart';
import 'package:finandy/screens/scan_pay/transactionstatus.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:swagger/api.dart';

class EnterPin extends StatefulWidget {
  Map tctDetails;
  EnterPin({Key? key, required this.tctDetails}) : super(key: key);

  @override
  State<EnterPin> createState() => _Screen3();
}

//
class _Screen3 extends State<EnterPin> {
  late Map tctDetails;
  bool isButtonActive = false;
  final _formKey = GlobalKey<FormState>();
  bool isChecked = false;
  late int currentText;
  TextEditingController textEditingController = TextEditingController();
  late int trial;

  late StreamController<ErrorAnimationType> errorController;
  @override
  void initState() {
    super.initState();
    trial = 0;
    tctDetails = widget.tctDetails;
    errorController = StreamController<ErrorAnimationType>();
  }

  @override
  void dispose() {
    errorController.close();
    super.dispose();
  }

  Future<UserTransaction> initiateTransaction(ctx) async {
    String cardId = Provider.of<CardSchema>(context, listen: false).id ?? "";
    String trId = ctx["trId"];
    final TrIdInitiateBody body_ =
        TrIdInitiateBody.fromJson({"pin": currentText}); // TrIdInitiateBody |

    try {
      final UserTransaction result = await transactionApi
          .v1CardsCardIdTransactionsTrIdInitiatePut(cardId, trId, body: body_);
      return result;
    } catch (e) {
      print(
          "Exception when calling TransactionsApi->v1CardsCardIdTransactionsTrIdInitiatePut: $e\n");
      rethrow;
    }
  }

  Widget handleDefaultAvatar() {
    String x = tctDetails["name"];
    List<String> nameparts = x.split(" ");
    String initials;
    if (nameparts.isEmpty) {
      initials = "AZ";
    } else {
      initials = nameparts[0][0].toUpperCase() +
          nameparts[nameparts.length - 1][0].toUpperCase(); //Output: SR
    }
    if (tctDetails["images"] != null) {
      return const CircleAvatar(
          // backgroundImage: NetworkImage(tctDetails["images"]),
          );
    } else {
      return CircleAvatar(
        backgroundColor: Colors.blueAccent,
        child: Text(initials),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          "PIN",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        centerTitle: false,
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 25, right: 25, top: 30),
        // child: PageForm(value_: Screen2Data),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Card(
                child: ListTile(
                  leading: handleDefaultAvatar(),
                  title: Text(tctDetails["name"]),
                  subtitle: Text(tctDetails["upi_id"]),
                ),
              ),
              const Spacer(),
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
                animationDuration: const Duration(milliseconds: 300),
                // backgroundColor: Colors.white,
                onChanged: (value) {
                  if (value.length == 4) {
                    setState(() {
                      trial++;
                      isButtonActive = true;
                      currentText = int.parse(value);
                    });
                  } else {
                    setState(() {
                      currentText = int.parse(value);
                    });
                  }
                },
                appContext: context,
              ),
              if (trial != 0)
                Positioned(
                  right: 1,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 12),
                    ),
                    onPressed: () {},
                    child: const Text('Reset Pin'),
                  ),
                ),
              const Spacer(),
              Flexible(
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  child: ElevatedButton(
                      onPressed: isButtonActive
                          ? () {
                        print("Calling do transcation");
                        doTransaction().then((transaction) {
                          print("Initiate transaction completed.");
                          print('Updated transaction: $transaction');
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) => TransactionStatus(transaction: transaction)));
                              });
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Text(
                          "Pay",
                          style: TextStyle(fontSize: 20),
                        ),
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('AlertDialog Title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('3  Wrong Trials'),
                Text('Now you can enter the pin after 24 hours.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<UserTransaction> doTransaction() async {
    try {
      setState(() {
        isButtonActive = false;
      });
      return await initiateTransaction(tctDetails);
    } catch (e) {
      print("Error in calling initiate transaction !!");
      print(e.toString());
      setState(() {
        isButtonActive = true;
      });
      rethrow;
    }
  }
}
