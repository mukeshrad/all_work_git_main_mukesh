import 'dart:async';
import 'package:finandy/constants/texts.dart';
import 'package:finandy/modals/customer.dart';
import 'package:finandy/modals/require.dart';
import 'package:finandy/screens/request_permissions.dart';
import 'package:finandy/screens/signin.dart';
import 'package:finandy/services/permissions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppPurpose extends StatefulWidget {
   const AppPurpose({Key? key}) : super(key: key);

  @override
  State<AppPurpose> createState() => _AppPurposeState();
}

class _AppPurposeState extends State<AppPurpose> {
  late SvgPicture p1;
  late SvgPicture p2;
  late SvgPicture p3;
  late SvgPicture b1;
  late SvgPicture b2;
  late SvgPicture b3;

  List<SvgPicture> bgs = [];
  List<SvgPicture> fgs = [];

  int idx = 0;
  Timer? _everySecond;

  @override
  void initState() {
    super.initState();
    p1 = SvgPicture.asset("assets/images/purpose1.svg");
    p2 = SvgPicture.asset("assets/images/purpose2.svg");
    p3 = SvgPicture.asset("assets/images/purpose3.svg");
    fgs.addAll([p1, p2, p3]);
    b1 = SvgPicture.asset("assets/images/purpose1bg.svg");
    b2 = SvgPicture.asset("assets/images/purpose2bg.svg");
    b3 = SvgPicture.asset("assets/images/purpose3bg.svg");
    bgs.addAll([b1, b2, b3]);
    _everySecond = Timer.periodic(const Duration(seconds: 3), (Timer t) {
      setState(() {
         idx++;
         idx = idx%3;
      });
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precachePicture(p1.pictureProvider, context);
    precachePicture(p2.pictureProvider, context);
    precachePicture(p3.pictureProvider, context);
    precachePicture(b1.pictureProvider, context);
    precachePicture(b2.pictureProvider, context);
    precachePicture(b3.pictureProvider, context);
  }

   @override
  void dispose() {
    _everySecond!.cancel();
    super.dispose();
  }
  
  createImage(){
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height*0.5,
      child: Stack(
        children: [
           Align(
             alignment: Alignment.center,
             child: bgs[idx]),
          Container(
          child: Column(
            children: <Widget>[Expanded(child: fgs[idx])],
          ),
        ),
        ],
      ),
    );
  }


  getTab(){
    return Container(
      
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 10, right: 10, top: 20),
            child: Align(
              alignment: Alignment.centerRight,
              child: SizedBox(
                height: 70,
                child: TextButton(
                  onPressed: (){
                     bool accepted = checkAllPermissions();
                     print(accepted);
                     Navigator.of(context).pushNamed(accepted ? "/signin" : "/reqPerm");
                    },
                  child: Text(idx != 0 ? skip : "", 
                    style: const TextStyle(
                      fontSize: 14
                    ),
                  )),
              ),
            ),
          ) ,
          createImage(),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 30, right: 30),
                    child: Text(head[idx],
                      textAlign: TextAlign.center,
                      softWrap: true,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 10, right: 10, top: 5),
                    child: Text(des[idx], 
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
             Container(
               margin: const EdgeInsets.only(left: 10, right: 10, bottom: 20),
               child: ElevatedButton(
                 onPressed: (){
                   Requires req = Requires();
                    req.checkGranted().then((value) {
                      Navigator.of(context).pushNamed(value ? "/signin" : "/reqPerm"); 
                    }).onError((error, stackTrace) {
                       Navigator.of(context).pushNamed("/reqPerm"); 
                    });   
                    }, 
                       style: ElevatedButton.styleFrom(
                         padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 2),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                       child: const Padding(
                         padding: EdgeInsets.all(8.0),
                         child: 
                             Text(letsGetStarted, style: TextStyle(fontSize: 18),),
                        ) 
                       ),
             ),
             Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: head.asMap().entries.map((entry) {
                return Container(
                  width: 10.0,
                  height: 10.0,
                  margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: (Theme.of(context).brightness == Brightness.dark
                              ? Theme.of(context).primaryColorLight
                              : Theme.of(context).primaryColor)
                          .withOpacity(idx == entry.key ? 0.8 : 0.1)),
                );
              }).toList(),
        ),         
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _everySecond;
    return Scaffold(
      body: getTab()
    );
  }
}