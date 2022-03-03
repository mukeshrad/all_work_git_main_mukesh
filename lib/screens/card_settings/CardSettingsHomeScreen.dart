import 'package:finandy/constants/instances.dart';
import 'package:finandy/modals/card_schema.dart';
import 'package:finandy/screens/card_settings/ManageUPI/ManageUPI.dart';
import 'package:finandy/screens/card_settings/card-Statements/card_Statements.dart';
import 'package:finandy/screens/rootPageScreens/unbilled_transactions.dart';
import 'package:finandy/utils/credit_card.dart';
import 'package:finandy/utils/menuOption.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swagger/api.dart';

class CSHomepage extends StatefulWidget {
  const CSHomepage({Key? key}) : super(key: key);

  @override
  _CSHomepage createState() => _CSHomepage();
}

class _CSHomepage extends State<CSHomepage> {
  late SvgPicture quickPayicon;
  late String? cardStatus;
  late String cardId;
  @override
  void initState() {
    super.initState();
    if (mounted) {
      setState(() {
        cardId = Provider.of<CardSchema>(context, listen: false).id ?? "";
        print("cardId $cardId");
        cardStatus = Provider.of<CardSchema>(context, listen: false).status;
        print("cardStatus --> $cardStatus");
      });
    }
    quickPayicon = SvgPicture.asset(
      "assets/images/quickpay.svg",
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precachePicture(quickPayicon.pictureProvider, context);
  }

  sendToscreen(var page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  deactivateCard() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userId = preferences.getString('userId');
    final CardsIdBody body_ = CardsIdBody.fromJson({
      'preferences': context.read<CardSchema>().preference!.toJson(),
      'status': cardStatus,
    });
    try {
      var result =
          cardsApi.v1UsersUserIdCardIdDeactivate(userId!, cardId, body: body_);
      print(result);
    } catch (e) {
      print(
          "Exception when calling CardsApi->v1UsersUserIdCardIdDeactivate: $e\n");
    }
  }

  reactivate() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userId = preferences.getString('userId');
    final CardsIdBody body_ = CardsIdBody.fromJson({
      'preferences': context.read<CardSchema>().preference!.toJson(),
      'status': cardStatus,
    });
    try {
      var result =
          cardsApi.v1UsersUserIdCardIdReActivate(userId!, cardId, body: body_);
      print(result);
    } catch (e) {
      print(
          "Exception when calling CardsApi->v1UsersUserIdCardIdDeactivate: $e\n");
    }
  }

  Widget cardStatusWidget() {
    switch (cardStatus) {
      case "Active":
        return Card(
          margin: const EdgeInsets.only(left: 0, top: 0, bottom: 0, right: 1),
          child: InkWell(
            onTap: () {},
            splashColor: Colors.blue.withAlpha(30),
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: const [
                    Icon(
                      Icons.credit_card_off,
                      color: Color(0xffEF1F33),
                    ),
                    Text("Pause Card")
                  ],
                )),
          ),
        );
      case "UserDeactivated":
        return Card(
          margin: const EdgeInsets.only(left: 0, top: 0, bottom: 0, right: 1),
          child: InkWell(
            onTap: () {},
            splashColor: Colors.blue.withAlpha(30),
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: const [
                    Icon(
                      Icons.credit_card,
                      color: Colors.amber,
                    ),
                    Text("Continue Card")
                  ],
                )),
          ),
        );
      case "Defaulted":
        return Card(
          color: Colors.grey,
          margin: const EdgeInsets.only(left: 0, top: 0, bottom: 0, right: 1),
          child: InkWell(
            onTap: null,
            splashColor: Colors.blue.withAlpha(30),
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: const [
                    Icon(
                      Icons.credit_card_off,
                      color: Color(0xffEF1F33),
                    ),
                    Text("Pause Card")
                  ],
                )),
          ),
        );
      case "Fraud":
        return Card(
          color: Colors.grey,
          margin: const EdgeInsets.only(left: 0, top: 0, bottom: 0, right: 1),
          child: InkWell(
            onTap: null,
            splashColor: Colors.blue.withAlpha(30),
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: const [
                    Icon(
                      Icons.credit_card_off,
                      color: Color(0xffEF1F33),
                    ),
                    Text("Pause Card")
                  ],
                )),
          ),
        );
      case "SystemDeactivated":
        return Card(
          color: Colors.grey,
          margin: const EdgeInsets.only(left: 0, top: 0, bottom: 0, right: 1),
          child: InkWell(
            onTap: null,
            splashColor: Colors.blue.withAlpha(30),
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: const [
                    Icon(
                      Icons.credit_card_off,
                      color: Color(0xffEF1F33),
                    ),
                    Text("Pause Card")
                  ],
                )),
          ),
        );
      case "Locked":
        return Card(
          color: Colors.grey,
          margin: const EdgeInsets.only(left: 0, top: 0, bottom: 0, right: 1),
          child: InkWell(
            onTap: null,
            splashColor: Colors.blue.withAlpha(30),
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: const [
                    Icon(
                      Icons.credit_card_off,
                      color: Color(0xffEF1F33),
                    ),
                    Text("Pause Card")
                  ],
                )),
          ),
        );
      default:
        return Card(
          color: Colors.grey,
          margin: const EdgeInsets.only(left: 0, top: 0, bottom: 0, right: 1),
          child: InkWell(
            onTap: null,
            splashColor: Colors.blue.withAlpha(30),
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: const [
                    Icon(
                      Icons.credit_card_off,
                      color: Color(0xffEF1F33),
                    ),
                    Text("Pause Card")
                  ],
                )),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         backgroundColor: Color(0xff084E6C), 
         title: const Text("Card Settings")),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Colors.red,
      //   // elevation: 4.0,
      //   child: const Icon(
      //     Icons.qr_code_scanner_sharp,
      //   ),
      //   onPressed: () {
      //     Navigator.push(
      //         context, MaterialPageRoute(builder: (context) => QrScanPage()));
      //   },
      // ),
      // drawer: const NavDrawer(),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // bottomNavigationBar: BottomAppBar(
      //   child: BottomAppBar(
      //       child: Row(
      //     mainAxisSize: MainAxisSize.max,
      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //     crossAxisAlignment: CrossAxisAlignment.end,
      //     children: <Widget>[
      //       GestureDetector(
      //         onTap: () {},
      //         child: Container(
      //           padding: const EdgeInsets.all(5),
      //           child: Column(
      //             mainAxisSize: MainAxisSize.min,
      //             mainAxisAlignment: MainAxisAlignment.end,
      //             children: [quickPayicon, const Text(quickPay)],
      //           ),
      //         ),
      //       ),
      //       // if (centerLocations.contains(fabLocation)) const Spacer(),
      //       Container(
      //           margin: const EdgeInsets.only(left: 20, bottom: 5),
      //           child: const Text(
      //             scanAndPay,
      //             textAlign: TextAlign.center,
      //           )),
      //       GestureDetector(
      //         onTap: () {
      //           Navigator.push(context,
      //               MaterialPageRoute(builder: (context) => CSHomepage()));
      //         },
      //         child: Container(
      //           padding: const EdgeInsets.all(5),
      //           child: Column(
      //             mainAxisSize: MainAxisSize.min,
      //             mainAxisAlignment: MainAxisAlignment.end,
      //             children: const [
      //               Icon(Icons.credit_card_rounded),
      //               Text(cardSettings)
      //             ],
      //           ),
      //         ),
      //       ),
      //     ],
      //   )),
      // ),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(left: 15, right: 15, bottom: 10, top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Container(
              //   decoration: BoxDecoration(
              //     // color: Color(0xffFFFFFF),
              //     borderRadius: BorderRadius.circular(7.0),
              //     boxShadow: [
              //       BoxShadow(
              //         color: Colors.grey.shade300,
              //         offset: const Offset(0.0, 5.0),
              //         blurRadius: 30.0,
              //       ),
              //     ],
              //   ),
              //   child: ,
              // ),
              UptrackCard(
                  bankName: "${context.watch<CardSchema>().bankName}",
                  cardNumber: "${context.watch<CardSchema>().cardNumber}",
                  cardType: "${context.watch<CardSchema>().cardType}",
                  expiry: "${context.watch<CardSchema>().expiry}",
                  ownerName: "${context.watch<CardSchema>().ownerName}",
                  cardNoTitle: "Card Number",
                  monthlyLimit:
                      "${context.watch<CardSchema>().limits!.monthly}"),
              Container(
                // padding: EdgeInsets.only(),
                // margin: EdgeInsets.only(left: 9, right: 9, top: 0),
                decoration: BoxDecoration(
                  color: const Color(0xffFFFFFF),
                  borderRadius: BorderRadius.circular(7.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      offset: const Offset(0.0, 5.0),
                      blurRadius: 30.0,
                    ),
                  ],
                ),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(child: cardStatusWidget()),
                    Expanded(
                      child: Card(
                        margin: const EdgeInsets.only(
                            left: 1, top: 0, bottom: 0, right: 0),
                        child: InkWell(
                          onTap: () {},
                          splashColor: Colors.blue.withAlpha(30),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: const [
                                Icon(
                                  Icons.vpn_key_outlined,
                                  color: Colors.blueAccent,
                                ),
                                Text("Reset PIN")
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 11.0,
              ),
              MenuOption(
                iconData: Icons.account_balance_wallet_outlined,
                iconColor: const Color(0xff3B88C3),
                s: "Manage UPI",
                onTap: () {
                  sendToscreen(ManageUPI());
                },
                textStyle: const TextStyle(
                  fontFamily: "Inter",
                  fontWeight: FontWeight.w500,
                ),
              ),
              MenuOption(
                iconData: Icons.history,
                iconColor: Colors.orange,
                s: "Transaction History",
                onTap: () {
                  sendToscreen(const UnbilledTransaction());
                },
                textStyle: const TextStyle(
                  fontFamily: "Inter",
                  fontWeight: FontWeight.w500,
                ),
              ),
              MenuOption(
                iconData: Icons.description_outlined,
                iconColor: Colors.green,
                s: "Card Statements",
                onTap: () {
                  sendToscreen(const CardStatements());
                },
                textStyle: const TextStyle(
                  fontFamily: "Inter",
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
