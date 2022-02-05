import 'dart:async';
import 'package:finandy/modals/customer.dart';
import 'package:finandy/screens/request_permissions.dart';
import 'package:finandy/screens/signin.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppPurpose extends StatefulWidget {
   const AppPurpose({Key? key}) : super(key: key);

  @override
  State<AppPurpose> createState() => _AppPurposeState();
}

class _AppPurposeState extends State<AppPurpose> {
  List<String> head = ["Build\nYour Credit History",
                        "Check Loan\n Amount Eligibility",
                        "Get  eligible\n for Golden Ticket"];
  List<String> des = ["We keep a track of your Credit History and\nbuild you a Profile",
                      "Easily check your loan eligibility and have all\ntime access to money on your phone",
                      "By Just maintaining a Good Profile, You get\nEligible for the Golden Ticket"];                      
 
  int idx = 0;
  Timer? _everySecond;

  @override
  void initState() {
    super.initState();
    getPrint();
    _everySecond = Timer.periodic(const Duration(seconds: 3), (Timer t) {
      setState(() {
         idx++;
         idx = idx%3;
      });
    });
  }

  getPrint() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final txt = sharedPreferences.get("name");

    print(txt);
  }

   void dispose() {
    _everySecond!.cancel();
    super.dispose();
  }
  
  getTab(){
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: SizedBox(
              height: 70,
              child: TextButton(
                onPressed: (){
                     bool accept = context.read<Customer>().isPermissionGiven();
                     print(accept);
                   Navigator.of(context).pushNamed(accept ? "/signin" : "/reqPerm");
                  },
                child: Text(idx != 0 ? "Skip" : "", 
                  style: const TextStyle(
                    fontSize: 14
                  ),
                )),
            ),
          ) ,
          Container(
            margin: const EdgeInsets.only(top: 30, bottom: 30, left: 20, right: 20),
            child: const Placeholder(fallbackHeight: 250, fallbackWidth: 75,)
            ),
            Column(
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
             ElevatedButton(
               onPressed: (){
                bool accept = context.read<Customer>().isPermissionGiven();
                     print(accept);
                   Navigator.of(context).pushNamed(accept ? "/signin" : "/reqPerm"); 
                  }, 
                     style: ElevatedButton.styleFrom(
                       padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 2),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                     child: const Padding(
                       padding: EdgeInsets.all(8.0),
                       child: 
                           Text("Get Started", style: TextStyle(fontSize: 18),),
                      ) 
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
                              ? Colors.white
                              : Colors.black)
                          .withOpacity(idx == entry.key ? 0.8 : 0.3)),
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