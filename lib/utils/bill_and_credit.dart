import 'package:finandy/modals/bill.dart';
import 'package:finandy/screens/rootPageScreens/unbilled_transactions.dart';
import 'package:finandy/utils/widget_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class BillAndCreditSection extends StatefulWidget {
  const BillAndCreditSection({ Key? key }) : super(key: key);

  @override
  State<BillAndCreditSection> createState() => _BillAndCreditSectionState();
}

class _BillAndCreditSectionState extends State<BillAndCreditSection> {
  late SvgPicture calenderLogo; 
  late int billAmount;
  late int unbilledAmount;

  @override
  void initState() {
    super.initState();
    calenderLogo = SvgPicture.asset("assets/images/calender.svg");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precachePicture(calenderLogo.pictureProvider, context);
  }

  @override
  Widget build(BuildContext context) {
    unbilledAmount = Provider.of<BillSchema>(context, listen: false).amount.toInt();
    billAmount = Provider.of<BillSchema>(context, listen: false).amount.toInt();
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: (){Navigator.of(context).push(MaterialPageRoute(builder: (context) => const UnbilledTransaction()));},
              child: elevatedContainer(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text("Unbilled",
                                style: TextStyle(
                                  fontSize: 16
                                ),
                              ),
                              Text("Transaction",
                                style: TextStyle(
                                  fontSize: 16
                                )
                              )
                            ],
                          ),
                          const SizedBox(width: 5,),
                          const Icon(Icons.receipt,
                              color: Color(0xff55CDD8),
                              size: 30,
                              ),
                        ],
                      ),
                      const SizedBox(height:13,),
                      Text("₹ $billAmount",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 7,),
          Expanded(
            child: GestureDetector(
              onTap: (){},
              child: elevatedContainer(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                         const Text("Pay Bill", 
                            style: TextStyle(
                              fontSize: 16
                            ),),
                          Text("₹ $unbilledAmount",
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700
                        ),
                      ),
                        ],
                      ),
                      const SizedBox(width: 5,),
                      const Icon(Icons.receipt,
                            color: Color(0xff05C46B),
                            size: 32,
                            ),
                       ],
                      ),
                      const SizedBox(height: 5,),
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               calenderLogo,
                               const SizedBox(width: 5,),
                               const Text("Feb 10", 
                                  style: TextStyle(
                                    fontSize: 16
                                  ),),
                             ],
                            ),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal:  15, vertical: 5),
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: const BorderRadius.all(Radius.circular(5)),
                              ),
                              child: const Text("Pay", style: TextStyle(fontSize: 16, color: Colors.white),)) 
                              )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}