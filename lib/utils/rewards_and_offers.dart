import 'package:flutter/material.dart';

class RewardsAndOffers extends StatelessWidget {
  const RewardsAndOffers({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          Expanded(
            child: Card( 
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black12),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Icon(Icons.emoji_events_outlined),
                        ),
                        const SizedBox(width: 5,),
                        GestureDetector(
                          onTap: (){},
                          child: const Text("Rewards"),
                        )
                      ],
                    ),
                    const SizedBox(height: 8,),
                    Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: const Text("2",
                        style: TextStyle(
                          fontWeight: FontWeight.w700
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
            ),
          Expanded(child: Card( 
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black12),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Icon(Icons.local_offer_outlined),
                        ),
                        const SizedBox(width: 5,),
                        GestureDetector(
                          onTap: (){},
                          child: const Text("Offers"),
                        )
                      ],
                    ),
                    const SizedBox(height: 8,),
                    Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: const Text("6+",
                        style: TextStyle(
                          fontWeight: FontWeight.w700
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )),
        ],
      ),
    );
  }
}