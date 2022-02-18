import 'package:finandy/constants/texts.dart';
import 'package:finandy/screens/rootPageScreens/root_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileBuildingSuccess extends StatefulWidget {
  const ProfileBuildingSuccess({ Key? key }) : super(key: key);

  @override
  State<ProfileBuildingSuccess> createState() => _ProfileBuildingSuccessState();
}

class _ProfileBuildingSuccessState extends State<ProfileBuildingSuccess> {
  late SvgPicture congoImg;
  late SvgPicture mainBg;
  late SvgPicture gTicket;
  late SvgPicture actbg;

  @override
  void initState() {
    super.initState();
    mainBg = SvgPicture.asset("assets/images/scardbg.svg");
    gTicket = SvgPicture.asset("assets/images/gticketbg.svg");
    actbg = SvgPicture.asset("assets/images/actcard.svg");
    congoImg = SvgPicture.asset("assets/images/congo.svg");
  }

  @override
  void didChangeDependencies() {
    precachePicture(congoImg.pictureProvider, context);
    precachePicture(gTicket.pictureProvider, context);
    precachePicture(actbg.pictureProvider, context);
    precachePicture(mainBg.pictureProvider, context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(left: 10, right: 10, top: 50, bottom: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
             children: [
               Column(
                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                 children: [
                   Container(
                     margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 7),
                     child: Column(
                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                       children: [
                         SizedBox(
                           height: 110,
                           child: congoImg
                         ),
                         const SizedBox(height: 3,),
                          const Text(congo,
                           style: TextStyle(
                             fontWeight: FontWeight.w300,
                             fontSize: 16
                           ),
                         ),
                         const SizedBox(height: 3,),
                       ],
                     ),
                   ),
                 ],
               ),
               Stack(
                 children: [
                   mainBg,
                   Positioned(
                     top: 55,
                     right: 40,
                     child: gTicket
                     ),
                   Positioned(
                     top: 35,
                     left: 25,
                     child: Column(
                       mainAxisAlignment: MainAxisAlignment.start,
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         const Text(goldenTicket,
                           style: TextStyle(
                             fontSize: 20,
                             fontWeight: FontWeight.bold,
                             color: Colors.white
                             )
                         ),
                         Container(
                           margin: const EdgeInsets.only(top: 5, bottom: 20),
                           child: const Text(helpOthers,
                             softWrap: true,
                             style: TextStyle(fontSize: 16, color: Colors.white60),
                           ),
                         ),
                 ElevatedButton(
                   onPressed: (){
                     
                   },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                    alignment: Alignment.bottomCenter,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                   ),
                   child: const  Padding(
                   padding: EdgeInsets.all(10.0),
                   child: Text(viewGolden, style: TextStyle(fontSize: 15),),
                   ) 
                )
                ],
                ),
              ),
             ], 
          ),
          const SizedBox(height: 5,),
            Stack(
              children: [
                mainBg,
                Positioned(
                  top: 25,
                  right: 0,
                  child: actbg,
                  ),
            Positioned(
                top: 35,
                left: 25,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(everdayCard,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                        )
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 5, bottom: 20),
                      child: const Text(useCard,
                        softWrap: true,
                        style: TextStyle(fontSize: 16, color: Colors.white60),
                      ),
                    ),
                 ElevatedButton(
                   onPressed: (){
                     Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const RootPage()));
                   },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                    alignment: Alignment.bottomCenter,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                   ),
                   child: const  Padding(
                   padding: EdgeInsets.all(10.0),
                   child: Text(activateNow, style: TextStyle(fontSize: 15),),
                   ) 
                )
                ],
                ),
              ),
              ],
            )
       ]),
      ),
      )
    );
  }
}