import 'package:finandy/constants/texts.dart';
import 'package:finandy/modals/card_schema.dart';
import 'package:finandy/screens/ManageUPI/ManageUPI.dart';
import 'package:finandy/screens/card_settings/card-Statements/card_Statements.dart';
import 'package:finandy/screens/card_settings/transaction_History.dart';
import 'package:finandy/screens/scan_pay/qr_scan.dart';
import 'package:finandy/utils/credit_card.dart';
import 'package:finandy/utils/main_app_bar.dart';
import 'package:finandy/utils/menuOption.dart';
import 'package:finandy/utils/nav_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class CSHomepage extends StatefulWidget {
  @override
  _CSHomepage createState() => _CSHomepage();
}

class _CSHomepage extends State<CSHomepage> {
  late SvgPicture quickPayicon;

  @override
  void initState() {
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(appBar: AppBar(), title: 'Card Settings'),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        // elevation: 4.0,
        child: const Icon(
          Icons.qr_code_scanner_sharp,
        ),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => CustomSizeScannerPage()));
        },
      ),
      drawer: const NavDrawer(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
          child: BottomAppBar(
          child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          GestureDetector(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.all(5),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [quickPayicon, const Text(quickPay)],
              ),
            ),
          ),
          // if (centerLocations.contains(fabLocation)) const Spacer(),
          Container(
              margin: const EdgeInsets.only(left: 20, bottom: 5),
              child: const Text(
                scanAndPay,
                textAlign: TextAlign.center,
              )),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => CSHomepage()));
            },
            child: Container(
              padding: const EdgeInsets.all(5),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  Icon(Icons.credit_card_rounded),
                  Text(cardSettings)
                ],
              ),
            ),
          ),
        ],
        )),
      ),
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
                monthlyLimit: "${context.watch<CardSchema>().limits!.monthly}"
                ),
              Container(
                // padding: EdgeInsets.only(),
                // margin: EdgeInsets.only(left: 9, right: 9, top: 0),
                decoration: BoxDecoration(
                  color: Color(0xffFFFFFF),
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
                    Expanded(
                      child: Card(
                        margin: const EdgeInsets.only(
                            left: 0, top: 0, bottom: 0, right: 1),
                        child: InkWell(
                          onTap: () {},
                          splashColor: Colors.blue.withAlpha(30),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.credit_card,
                                  color: Colors.amber,
                                ),
                                Text("Continue Card")
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
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
                              children: [
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
              SizedBox(
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
                  sendToscreen(const TransactionHistory());
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
              MenuOption(
                iconData: Icons.cancel_presentation_outlined,
                iconColor: Colors.pink,
                s: "Cancel Card",
                onTap: () {
                  sendToscreen(ManageUPI());
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
