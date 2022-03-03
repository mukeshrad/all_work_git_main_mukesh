import 'package:finandy/constants/instances.dart';
import 'package:finandy/modals/card_schema.dart';
import 'package:finandy/modals/require.dart';
import 'package:finandy/screens/scan_pay/qr_scan-enter-pin.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swagger/api.dart';

class PayScreen extends StatefulWidget {
  Map mercDetails;
  PayScreen({Key? key, required this.mercDetails}) : super(key: key);

  @override
  State<PayScreen> createState() => _PayScreen();
}

//
class _PayScreen extends State<PayScreen> {
  bool isButtonActive = false;
  late TextEditingController controller;
  late int? monthlyLimit;
  @override
  void initState() {
    super.initState();
    mercDetails = widget.mercDetails;
    monthlyLimit =
        Provider.of<CardSchema>(context, listen: false).limits!.monthly;
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
    if (mounted) {
      setState(() {
        position = userLocation;
      });
    }
  }

  Widget handleDefaultAvatar() {
    String x = mercDetails["name"];
    List<String> nameparts = x.split(" ");
    String initials;
    if (nameparts.isEmpty) {
      initials = "AZ";
    } else {
      initials = nameparts[0][0].toUpperCase() +
          nameparts[nameparts.length - 1][0].toUpperCase();
    }

    if (mercDetails["image"] != null) {
      return const CircleAvatar(
          // backgroundImage: NetworkImage(mercDetails["image"]),
          );
    } else {
      return CircleAvatar(
        backgroundColor: Colors.blueAccent,
        child: Text(initials),
      );
    }
  }

  createTransaction(ctx) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    Object? token = preferences.get("token");
    apiClient.setAccessToken(token as String);
    String cardId = Provider.of<CardSchema>(context, listen: false).id ?? "";
    final CardIdTransactionsBody body_ = CardIdTransactionsBody.fromJson({
      "merchant_upi_id": ctx["upi_id"],
      "merchant_category_code": ctx["merchantCategoryCode"],
      "amount": ctx["amount"],
      'location': position,
      'qr_code': ctx["qr_code"],
      "merchantName": ctx["name"]
    });
    try {
      UserTransaction? transaction = await transactionApi.v1CardsCardIdTransactionsPost(cardId,
          body: body_);
      if (transaction == null) {
        throw Exception("Create transaction result is empty");
      }
      ctx["trId"] = transaction.id;
      print("Final Result --> $ctx");
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => EnterPin(tctDetails: ctx)));
    } catch (e) {
      print(
          "Exception when calling TransactionsApi->v1CardsCardIdTransactionsPost: $e\n");
      rethrow;
    }
  }

  final _formKey = GlobalKey<FormState>();
  double amt = 0;
  var desc;
  late Map mercDetails;

  @override
  Widget build(BuildContext context) {
    print('in $mercDetails');
    String name = mercDetails["name"] ?? "Default Name";
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(true),
        ),
        title:
            Text("Pay to $name", style: const TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 30.0,
          vertical: 15.0,
        ),
        child: Form(
          // autovalidateMode: AutovalidateMode.always,
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: ListView(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7.0),
                        border: Border.all(
                          color: const Color(0xffF0F0F0),
                        ),
                      ),
                      child: ListTile(
                        leading: handleDefaultAvatar(),
                        title: Text(
                          mercDetails["name"],
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16.0,
                          ),
                        ),
                        subtitle: Text(
                          mercDetails["upi_id"],
                          style: const TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xffF0F0F0), width: 1.5),
                        ),
                        border: OutlineInputBorder(),
                        hintText: 'Enter Amount',
                        labelText: 'Amount',
                        alignLabelWithHint: true,
                      ),
                      keyboardType: TextInputType.number,
                      controller: controller,
                      onChanged: (amountValue) {
                        setState(() {
                          amt = double.parse(amountValue);
                        });
                      },
                      validator: (amountValue) {
                        if (amountValue!.isEmpty) {
                          return "Please enter Amount";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xffF0F0F0), width: 1.5),
                        ),
                        border: OutlineInputBorder(),
                        labelText: "Description",
                        hintText: "Description",
                        alignLabelWithHint: true,
                        // alignLabelWithHint:
                      ),
                      onSaved: (value) {
                        desc = value;
                      },
                      maxLines: 5,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: ElevatedButton(
                  onPressed: isButtonActive
                      ? () {
                          doTransaction();
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                    onSurface: Colors.redAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Text(
                      "Pay",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void monthlyLimitSheet() {
    showModalBottomSheet<dynamic>(
        context: context,
        builder: (context) => Wrap(alignment: WrapAlignment.center, children: [
              Column(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_drop_down_circle),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  const Text(
                    "Monthly Limit Exceeded",
                    textAlign: TextAlign.center,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blueAccent,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Text(
                            "Please try again",
                            style: TextStyle(fontSize: 20),
                          ),
                        )),
                  ),
                ],
              ),
            ]));
  }

  doTransaction() {
    try {
      final Map someMap = {
        "upi_id": mercDetails["upi_id"],
        "name": mercDetails["name"],
        "merchantCategoryCode": mercDetails["merchantCategoryCode"],
        "qr_code": mercDetails["qr_code"],
        "image": mercDetails["image"],
        "amount": amt,
        "location": position,
        "Description": desc
      };

      setState(() {
        isButtonActive = false;
      });
      if (monthlyLimit != null && amt > monthlyLimit!) {
        monthlyLimitSheet();
      } else {
        createTransaction(someMap);
      }
      controller.clear();
    } catch (e) {
      print(e.toString());
    }
  }
}
