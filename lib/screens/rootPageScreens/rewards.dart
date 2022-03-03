import 'package:finandy/constants/texts.dart';
import 'package:finandy/utils/widget_wrapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TotalRewards extends StatefulWidget {
  const TotalRewards({ Key? key }) : super(key: key);

  @override
  _TotalRewardsState createState() => _TotalRewardsState();
}

class _TotalRewardsState extends State<TotalRewards> {
  
  rewardTile(int index){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      child: elevatedContainer(child: ListTile(
        leading: CircleAvatar(
                 radius: 20,
                 backgroundColor: Colors.grey[200],
                 child: const Icon(CupertinoIcons.gift, color: Color(0xffF5AB35)),
               ),
               title: Column(
                 mainAxisAlignment: MainAxisAlignment.start,
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Text(wonCashback + "5",
                    style: const TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w800,
                    ),
                   ),
                  Row(
                    children: [
                       Text("01/12/2021 ;",
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 15
                        ),
                       ),
                       Text(" 11:30 AM",
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 15
                        ), 
                       )
                    ],
                  )
                 ],
               ),
         )
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(
          color: Colors.black
        ),
        title: const Text( myrewards, style: TextStyle(
          color: Colors.black
        ),),
        automaticallyImplyLeading: true,
      ),
      body: ListView.builder(
        itemCount: 8,
        itemBuilder: (context, index) {
        return rewardTile(index);
      },),
    );
  }
}