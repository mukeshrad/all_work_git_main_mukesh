import 'package:finandy/constants/texts.dart';
import 'package:finandy/screens/card_settings/Screen85.dart';
import 'package:finandy/screens/scan_pay/qr_scan.dart';
import 'package:finandy/utils/bill_and_credit.dart';
import 'package:finandy/utils/credit_card.dart';
import 'package:finandy/utils/expenses_card.dart';
import 'package:finandy/utils/main_app_bar.dart';
import 'package:finandy/utils/nav_drawer.dart';
import 'package:finandy/utils/rewards_and_offers.dart';
import 'package:flutter/material.dart';
import 'Payment/Bil_Pay.dart';
import 'Quiz Flow/HomePageQuizFlow.dart';

class RootPage extends StatefulWidget {
  static String id = "root";
  const RootPage({Key? key}) : super(key: key);

  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  bottomModalSheet() {
    return showModalBottomSheet<void>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      isDismissible: false,
      elevation: 5,
      builder: (BuildContext context) {
        return Container(
          height: 250,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            // mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              GestureDetector(
                child: const Icon(Icons.keyboard_arrow_down_rounded),
                onTap: () => Navigator.pop(context),
              ),
              playModal()
            ],
          ),
        );
      },
    );
  }

  playModal() {
    return Column(
      children: [
        Text("Answer and win ₹ 1 instant cashback"),
        SizedBox(
          height: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          //  mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("Do you have a Vehicle?"),
            ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Text(
                    "Car",
                    style: TextStyle(fontSize: 12),
                  ),
                )),
            ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Text(
                    "Bike/Scooter",
                    style: TextStyle(fontSize: 15),
                  ),
                )),
            ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Text(
                    "Planning",
                    style: TextStyle(fontSize: 15),
                  ),
                )),
            const Text("*Terms & Conditions")
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mainAppBar(context),
      floatingActionButton: FloatingActionButton(
        // elevation: 4.0,
        child: const Icon(Icons.qr_code_scanner_sharp),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => CustomSizeScannerPage()));
        },
      ),
      drawer: const NavDrawer(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              GestureDetector(
                onTap: () {

                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PayInformation(isScreen: "quickPay",)));

                },
                child: Container(
                  padding: const EdgeInsets.all(5),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [const Icon(Icons.money), Text(quickPay)],
                  ),
                ),
              ),
              // if (centerLocations.contains(fabLocation)) const Spacer(),
              Container(
                  margin: const EdgeInsets.only(left: 20, bottom: 5),
                  child: Text(
                    scanAndPay,
                    textAlign: TextAlign.center,
                  )),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Screen85()));
                },
                child: Container(
                  padding: const EdgeInsets.all(5),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Icon(Icons.credit_card_rounded),
                      Text(cardSettings)
                    ],
                  ),
                ),
              ),
            ],
          )),
      body: ListView(
        children: [
          const UptrackCard(
            bankName: "Bank Name",
            cardNumber: "1212 1212 1212 1212",
            cardType: "Card Type",
            expiry: "02/26",
            ownerName: "Shivam",
          ),
          const ExpensesCard(),
          const BillAndCreditSection(),
          const RewardsAndOffers(),
          Card(
            margin: const EdgeInsets.only(left: 10, right: 10, bottom: 20),
            child: Container(
              padding: const EdgeInsets.only(
                  top: 10, left: 10, right: 10, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      instantCashback,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          child: Container(
                            //  padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  cashback,
                                  maxLines: 3,
                                  style: const TextStyle(fontSize: 14),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                ElevatedButton(
                                  onPressed: bottomModalSheet,
                                  child: Text(play),
                                )
                              ],
                            ),
                          )),
                      Expanded(
                          child: Image.asset(
                            "assets/images/cashback.gif",
                          ))
                    ],
                  )
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 20,right: 20,top: 0),
            child: ElevatedButton(
              onPressed: (){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => QuizHome()));
              },
              child: Text("Quiz Home"),
            ),
          ),

          SizedBox(
            height: 30,
          )
        ],
      ),
    );
  }
}
