import 'package:finandy/constants/instances.dart';
import 'package:finandy/modals/require.dart';
import 'package:finandy/screens/scan_pay/qr_scan-enter-pin.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swagger/api.dart';

class PayScreen extends StatefulWidget {
  String? value;
  PayScreen({Key? key, required this.value}) : super(key: key);

  @override
  State<PayScreen> createState() => _PayScreen(value);
}

//
class _PayScreen extends State<PayScreen> {
  String? value;
  _PayScreen(this.value);
  RegExp regExpupiid = RegExp(
    r":\/\/pay\?pa=(\w+)@(\w+)&",
    caseSensitive: false,
    multiLine: false,
  );
  late String UPIID = regExpupiid.stringMatch(value!).toString().substring(10);
  late String _UPIID = UPIID.substring(0, UPIID.length - 1);
  RegExp regExpupiname = RegExp(
    r";pn=(\w+)\s(\w+)\s&",
    caseSensitive: false,
    multiLine: false,
  );
  String _upiname = "XYZ";
  // late String upiname = regExpupiname.stringMatch(value).toString().substring(4);
  // late String _upiname = upiname.substring(0, upiname.length - 3);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title:
            Text("Pay to ${_upiname}", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        centerTitle: false,
      ),
      body: Container(
        margin:
            const EdgeInsets.only(left: 25, right: 25, top: 30, bottom: 0.0),
        child: PageForm(value_: [_UPIID, _upiname]),
      ),
    );
  }
}

class PageForm extends StatefulWidget {
  final List<String> value_;
  const PageForm({Key? key, required this.value_}) : super(key: key);
  @override
  _PageFormState createState() => _PageFormState();
}

class _PageFormState extends State<PageForm> {
  // List<String> value_;
  // _PageFormState(this.value_);
  bool isButtonActive = false;
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    locationHandler(_getUserPosition);
    controller = TextEditingController();
    controller.addListener(() {
      final isButtonActive = controller.text.isNotEmpty;
      setState(() => this.isButtonActive = isButtonActive);
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Position? position;
  locationHandler(getLocation) {
    Requires req = Requires();
    req.checkStatus(req.location, getLocation);
  }

  void _getUserPosition() async {
    Position userLocation = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      position = userLocation;
    });
  }

  createTransaction(value_) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    Object? token = preferences.get("token");
    apiClient.addDefaultHeader("Client-Secret", "");
    apiClient.setAccessToken(token.toString());
    print(token.toString());
    var cardId = "61e3fb775e346c001d2404ca";
    final CardIdTransactionsBody body_ = CardIdTransactionsBody.fromJson({
      "merchant_upi_id": value_["upiId"],
      "merchant_bank_account": "786655824565",
      "merchant_ifsc_code": "dsv",
      "merchant_category_code": "1761",
      "amount": value_["amount"],
      "location": position,
    });
    try {
      var result = await transactionInstance
          .v1CardsCardIdTransactionsPost(cardId, body: body_);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Screen3(Screen2Data: SendData)));
      print("result:${result.toString()}");
    } catch (e) {
      print(
          "Exception when calling TransactionsApi->v1CardsCardIdTransactionsPost: $e\n");
    }
  }

  late Map SendData;
  final _formKey = GlobalKey<FormState>();
  double _Amount = 0;
  var _Description;
  @override
  Widget build(BuildContext context) {
    return Form(
      // autovalidateMode: AutovalidateMode.always,
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Card(
            child: ListTile(
              leading: Icon(Icons.assignment_turned_in_outlined),
              title: Text(widget.value_[1]),
              subtitle: Text(widget.value_[0]),
            ),
          ),
          SizedBox(height: 20),
          TextFormField(
            decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter Amount',
                labelText: 'Amount',
                alignLabelWithHint: true),
            keyboardType: TextInputType.number,
            controller: controller,
            onChanged: (amountValue) {
              setState(() {
                _Amount = double.parse(amountValue);
              });
            },
            validator: (amountValue) {
              if (amountValue!.isEmpty) {
                return "Please enter Amount";
              }
              return null;
            },
          ),
          SizedBox(height: 20),
          TextFormField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Description",
              hintText: "Description",
              alignLabelWithHint: true,
              // alignLabelWithHint:
            ),
            onSaved: (value) {
              _Description = value;
            },
            maxLines: 5,
          ),
          Spacer(),
          Flexible(
            child: Container(
              margin: const EdgeInsets.only(top: 50),
              child: ElevatedButton(
                  onPressed: isButtonActive
                      ? () {
                          final Map someMap = {
                            "upiId": widget.value_[0],
                            "upiname": widget.value_[1],
                            "amount": _Amount,
                            "location": position
                          };
                          setState(() {
                            SendData = someMap;
                            isButtonActive = false;
                          });
                          print(SendData);
                          print(position.toString());
                          print(widget.value_);
                          createTransaction(SendData);
                          // if(_Amount.isFinite){

                          // }
                          controller.clear();
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                    onSurface: Colors.redAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        "Pay",
                        style: TextStyle(fontSize: 20),
                      ))),
            ),
          ),
        ],
      ),
    );
  }
}
