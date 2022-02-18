import 'package:finandy/screens/rootPageScreens/offers.dart';
import 'package:finandy/screens/rootPageScreens/rewards.dart';
import 'package:finandy/utils/widget_wrapper.dart';
import 'package:flutter/material.dart';

class RewardsAndOffers extends StatelessWidget {
  const RewardsAndOffers({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: (){Navigator.of(context).push(MaterialPageRoute(builder: ((context) => const TotalRewards())));},
              child: elevatedContainer( 
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                           Text("Total\nRewards",
                             style: TextStyle(
                                  fontSize: 16
                                ),
                           ),
                           SizedBox(width: 5,),
                           Icon(Icons.card_giftcard_sharp,
                            color: Color(0xffF22780), 
                            size: 30,
                            ),
                        ],
                      ),
                      const SizedBox(height: 8,),
                      const Padding(
                        padding:  EdgeInsets.only(left: 5.0),
                        child: Text("2",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
            ),
           const SizedBox(width: 7,),
          Expanded(
            child: GestureDetector(
              onTap: (){Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AllOffers()));},
              child: elevatedContainer( 
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                            Text("Offers",
                              style: TextStyle(
                                fontSize: 16
                              ),
                            ),
                            SizedBox(width: 5,),
                           Icon(Icons.local_offer_outlined,
                           color: Color(0xff663BF5),
                           size: 30,
                          ),
                        ],
                      ),
                      const SizedBox(height: 15,),
                      const Padding(
                        padding: EdgeInsets.only(left: 5.0),
                        child: Text("6+",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )),
        ],
      ),
    );
  }
}