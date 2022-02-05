import 'package:flutter/material.dart';

class BillAndCreditSection extends StatelessWidget {
  const BillAndCreditSection({ Key? key }) : super(key: key);

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
                          child: const Icon(Icons.receipt_long_sharp),
                        ),
                        const SizedBox(width: 5,),
                        GestureDetector(
                          onTap: (){},
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text("Unbilled"),
                              Text("Transaction")
                            ],
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 8,),
                    const Text("₹ 500",
                      style: TextStyle(
                        fontWeight: FontWeight.w700
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Card(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black12),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Icon(Icons.speed_sharp),
                        ),
                        const SizedBox(width: 5,),
                        GestureDetector(
                          onTap: (){},
                          child: Column(
                            children: const [
                              Text("Credit"),
                              Text("Score")
                            ],
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 8,),
                    Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: Row(
                        children: const [
                          Text("740",
                            style: TextStyle(
                              fontWeight: FontWeight.w700
                            ),
                          ),
                          Icon(Icons.arrow_drop_up_rounded),
                          Text("+2%")
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}