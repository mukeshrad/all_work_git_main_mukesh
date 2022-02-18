import 'package:finandy/constants/texts.dart';
import 'package:finandy/modals/bill.dart';
import 'package:finandy/modals/card_schema.dart';
import 'package:finandy/screens/card_settings/CardSettingsHomeScreen.dart';
import 'package:finandy/screens/scan_pay/qr_scan.dart';
import 'package:finandy/utils/bill_and_credit.dart';
import 'package:finandy/utils/credit_card.dart';
import 'package:finandy/utils/expenses_card.dart';
import 'package:finandy/utils/main_app_bar.dart';
import 'package:finandy/utils/nav_drawer.dart';
import 'package:finandy/utils/rewards_and_offers.dart';
import 'package:finandy/utils/widget_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../Payment/Bil_Pay.dart';
import '../Quiz Flow/HomePageQuizFlow.dart';
class RootPage extends StatefulWidget {
  static String id = "root";
  const RootPage({Key? key}) : super(key: key);

  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  late SvgPicture bulbIcon;
  late SvgPicture quickPayicon;

  @override
  void initState() {
    super.initState();
    bulbIcon = SvgPicture.asset("assets/images/bulb.svg");
    quickPayicon = SvgPicture.asset(
      "assets/images/quickpay.svg",
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precachePicture(bulbIcon.pictureProvider, context);
    precachePicture(quickPayicon.pictureProvider, context);
  }

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
      appBar: MainAppBar(
        appBar: AppBar(),
        title: "rootPage",
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
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
                    children: [quickPayicon, const  Text(quickPay)],
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
                    children: const[
                       Icon(Icons.credit_card_rounded),
                      Text(cardSettings)
                    ],
                  ),
                ),
              ),
            ],
          )),
      body: ListView(

        children: [
          Container(
            margin: const EdgeInsets.only(left: 12, right: 12, bottom: 5),
            child:
            UptrackCard(bankName: "${Provider.of<CardSchema>(context, listen: false).bankName}", cardNumber: "${Provider.of<CardSchema>(context, listen: false).cardNumber}", cardType: "${Provider.of<CardSchema>(context, listen: false).cardType}", expiry: "${Provider.of<CardSchema>(context, listen: false).expiry}",ownerName: "${Provider.of<CardSchema>(context, listen: false).ownerName}", cardNoTitle: "Card Number", monthlyLimit: "${Provider.of<CardSchema>(context, listen: false).limits!.monthly}")),
        const ExpensesCard(),
         Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            child: elevatedContainer(
             child: Container(
               margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 5),
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                 children: [
                  SizedBox(
                    child: bulbIcon,
                    width: 30,
                    ),
                  const Text(completeProfile,
                    softWrap: true,
                    style: TextStyle(
                      fontSize: 14
                    ),
                  ),
                   GestureDetector(
                     onTap: () {
                     },
                     child: Container(
                       padding: const EdgeInsets.all(8),
                       decoration: BoxDecoration(
                         color: Theme.of(context).primaryColor,
                         borderRadius: const BorderRadius.all(Radius.circular(5)),
                       ),
                       child: const Text(knowMore, style: TextStyle(fontSize: 13, color: Colors.white),))
                       )
               ],),
             ),
            ),
          ),
          const BillAndCreditSection(),
          const RewardsAndOffers(),
          Container(
              padding: const EdgeInsets.only(top: 10, left: 15, right: 15, bottom: 10),
              child:elevatedContainer(
            child: Padding(
              padding: const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: (){},
                      child: const Text( instantCashback,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20
                        ),
                      ),
                    ),const SizedBox(height: 5),
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
                                const Text(
                                  cashback,
                                  maxLines: 3,
                                  style: TextStyle(
                                     fontSize: 14
                                ),
                                ),const SizedBox(
                                  height: 10,
                                ),
                                ElevatedButton(
                                  onPressed: bottomModalSheet,
                                  child: const Text(play),
                                )
                              ],
                            ),
                          )
                         ),
                         Expanded(child: Image.asset(
                            "assets/images/cashback.gif",))
                          ],
                    )
                  ],
                ),
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
