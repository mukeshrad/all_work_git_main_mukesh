import 'dart:async';

import 'package:finandy/constants/texts.dart';
import 'package:finandy/modals/customer.dart';
import 'package:finandy/screens/signin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/src/provider.dart';
import 'package:uptrack/uptrack.dart';

class RequestPermissions extends StatefulWidget {
  static String id = 'reqPerm';
  const RequestPermissions({ Key? key }) : super(key: key);

  @override
  _RequestPermissionsState createState() => _RequestPermissionsState();
}

class _RequestPermissionsState extends State<RequestPermissions> {  
  late SvgPicture logo;

  @override
  void initState() {
    super.initState();
    logo = SvgPicture.asset("assets/images/logo.svg",);
  }

    @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precachePicture(logo.pictureProvider, context);
  }

  generateNote(IconData icon, String s, String des) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xffd3d3d3), width: 0.5)),
        // borderRadius: BorderRadius.all(Radius.circular(5))
      ),
      margin: const EdgeInsets.only(bottom: 5),
      child: ExpansionTile(
         children: [
           Container(
             margin: const EdgeInsets.only(left: 25, top: 5, bottom: 5, right: 5),
             child: Text(des))
           ],
         leading: Icon(icon),
         title: Text(s,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600
          ),
         ),
        ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          // alignment: Alignment.center,
          margin: const EdgeInsets.only(top: 25, bottom: 10, left: 10, right: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  padding: const EdgeInsets.only(top: 10, bottom: 8),
                    child: const Text("Apps and Permissions",
                      style: TextStyle(
                        fontSize: 18
                      ),
                     )
                    )
                  ),
              Center(
                child: SizedBox(
                  height: 35,
                  width: 135,
                  child: logo
                  ),
                ),
               Center(
                child: Container(
                  padding: const EdgeInsets.only(top: 2, bottom: 8),
                    child: const Text("needs access to",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w300
                      ),
                     )
                    )
                  ), 
              Column(
                children: [
                  generateNote(Icons.camera_alt_outlined, "Camera", perDes[0]),
                  generateNote(Icons.location_on_outlined,"Location", perDes[1]),
                  generateNote(Icons.perm_contact_cal_outlined, "Contacts", perDes[2]),
                  generateNote(Icons.sms_outlined, "SMS", perDes[3]),
                  generateNote(Icons.phone_iphone_outlined, "Device", perDes[4]),
                  generateNote(Icons.storage_sharp, "Storage", perDes[5]),
                  const SizedBox(height: 25,),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 25),
                child: ElevatedButton(onPressed: (){
                  context.read<Customer>().setUserState(UserState.PermissionGiven);
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const 
                   DataFetcher(
                     nextPage: 
                     SignUpScreen()
                      ,)
                     ));}, 
                  style: ElevatedButton.styleFrom(     
                      padding: const EdgeInsets.symmetric(horizontal: 44, vertical: 2), 
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  child: const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text("Allow", style: TextStyle(fontSize: 20),),
                  ) 
                     ),
              )  
            ],
          ),
        ),
      ),
    );
  }
}

