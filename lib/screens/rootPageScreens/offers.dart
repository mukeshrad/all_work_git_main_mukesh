import 'package:finandy/constants/texts.dart';
import 'package:finandy/utils/widget_wrapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AllOffers extends StatefulWidget {
  const AllOffers({ Key? key }) : super(key: key);

  @override
  _AllOffersState createState() => _AllOffersState();
}

class _AllOffersState extends State<AllOffers> {

  offerTile(int index){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 3),
      child: elevatedContainer(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CircleAvatar(
                   radius: 18,
                   backgroundColor: Colors.grey[100],
                   child: const Icon(CupertinoIcons.f_cursive_circle, color: Color(0xffF5AB35)),
                 ),
                 Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                      Text("Dominos", 
                      style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 17
                          ),
                      ),
                      const SizedBox(height: 5,),
                      Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("₹ 10 cashback", 
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(width: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.calendar_today_outlined, size: 13,),
                            SizedBox(width: 3,),
                            Text("Ends Dec 31st", 
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w800,
                          ),
                            ),
                          ],
                        )
                      ],
                    ),
                   ],
                 ),
                 IconButton(onPressed: (){},
                icon: Icon(Icons.arrow_forward_ios_rounded),
                ),
              ],
            ),
          ),
        )
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Colors.black
        ),
        title: const Text( myoffers, style: TextStyle(
          color: Colors.black
        ),),
        automaticallyImplyLeading: true,
      ),
      body: ListView.builder(
        itemCount: 8,
        itemBuilder:(context, index) {
           return offerTile(index);
        }
      ),
    );
  }
}