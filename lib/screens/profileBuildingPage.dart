import 'dart:async';

import 'package:finandy/constants/texts.dart';
import 'package:finandy/screens/profile_building_success.dart';
import 'package:finandy/screens/rootPageScreens/root_page.dart';
import 'package:flutter/material.dart';

class ProfileBuilding extends StatefulWidget {
  const ProfileBuilding({ Key? key }) : super(key: key);

  @override
  _ProfileBuildingState createState() => _ProfileBuildingState();
}

class _ProfileBuildingState extends State<ProfileBuilding> {
  late Timer timer;
  late Image checkingGif;
  bool isFirst = false;
  
  int idx = 0;

  @override
  void initState(){
   super.initState();
   checkingGif = Image.asset("assets/images/meter.gif");
   timer = Timer.periodic(const Duration(seconds: 4), (Timer t) {
      if(idx == 0){
        setState(() {
          idx++;
        });
      }else if(idx == 1){
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const ProfileBuildingSuccess()));
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(checkingGif.image, context);
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
               Column(
                 children: [
                  SizedBox(
                    child: checkingGif,
                  ),
                  Center(
                    child: SizedBox(
                      height: 35,
                      child: Text(isFirst ? "" : type[idx],
                         style: const TextStyle(
                           fontSize: 17,
                           fontWeight: FontWeight.w500
                         ),
                      ),
                    ),
                  ),
                 ],
               ),
               Center(
                  child: Text(status[idx],
                     style: const TextStyle(
                       fontSize: 20,
                       fontWeight: FontWeight.w600
                     ),
                  )
                 ),
               Center(
                 child: SizedBox(
                   height: 70,
                   child: Text(liners[idx],
                     softWrap: true,
                     textAlign: TextAlign.center,
                     style: const TextStyle(
                       fontSize: 17,
                     ),
                   ),
                 )
                 ),
               Container(
                margin: const EdgeInsets.only(right: 20, left: 20, top: 20, bottom: 10),
                child: ElevatedButton(onPressed: (){Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const ProfileBuildingSuccess()));}, 
                   style: ElevatedButton.styleFrom(
                      primary: Colors.grey,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                   child: const Padding(
                     padding:EdgeInsets.all(12.0),
                     child: Text(checking, style: TextStyle(fontSize: 20),),
                   ) 
                   ),
              ),
            ],
        ),
      ),
    );
  }
}