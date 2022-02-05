import 'dart:async';

import 'package:finandy/modals/customer.dart';
import 'package:finandy/screens/signin.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:uptrack/uptrack.dart';

class RequestPermissions extends StatefulWidget {
  static String id = 'reqPerm';
  const RequestPermissions({ Key? key }) : super(key: key);

  @override
  _RequestPermissionsState createState() => _RequestPermissionsState();
}

class _RequestPermissionsState extends State<RequestPermissions> {
  bool granted = false;

    final splashDelay = 2;

  @override
  void initState() {
    super.initState();

    // _loadWidget();
  }

  showDeclinedModal(ctx){
   return showDialog(
            context: ctx,
            builder: (BuildContext context) {
              return Card(
                elevation: 10,
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 150),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                      child: const Text("We Require these permissions to provide you better services, please provide us the necessary permissions", 
                         style: TextStyle(
                           fontSize: 20
                         ),
                         ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(15),
                      child: ElevatedButton(onPressed: (){
                        context.read<Customer>().setUserState(UserState.PermissionGiven);
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const
                          DataFetcher(nextPage: SignUpScreen())
                       ));},
                         style: ElevatedButton.styleFrom(
                           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Text("Allow", style: TextStyle(fontSize: 20),),
                        ) 
                   ),
                    ),
                  ],
                ),
              );
            },
          );
  }


  generateNote(IconData icon, String s) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey,),
        borderRadius: const BorderRadius.all(Radius.circular(5))
      ),
      margin: const EdgeInsets.only(bottom: 5),
      child: ListTile(
         leading: Icon(icon),
         title: Row(children: [
          Text(s,
           style: const TextStyle(
             fontSize: 20,
             fontWeight: FontWeight.w600
           ),
          ),
           const SizedBox(width: 5,),
           GestureDetector(
             child: const Icon(Icons.help),
           ) 
         ],)
        ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text("Apps and Permissions"),  
        ),
      body: SingleChildScrollView(
        child: Container(
          // alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                children: [
                  generateNote(Icons.camera_alt_outlined, "Camera"),
                  generateNote(Icons.location_on_outlined,"Location"),
                  generateNote(Icons.perm_contact_cal_outlined, "Contacts"),
                  generateNote(Icons.sms_outlined, "SMS"),
                  generateNote(Icons.phone_iphone_outlined, "Device"),
                  generateNote(Icons.storage_sharp, "Storage"),
                  const SizedBox(height: 25,),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                      ElevatedButton(onPressed: (){
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
                     const SizedBox(height: 10,),
                     ElevatedButton(onPressed: (){showDeclinedModal(context);}, 
                     style: ElevatedButton.styleFrom(
                       padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 2),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        primary: Colors.grey
                      ),
                     child: const Padding(
                       padding: EdgeInsets.all(12.0),
                       child: 
                           Text("Decline", style: TextStyle(fontSize: 20),),
                      ) 
                     ),
                  ],
                ),
              )  
            ],
          ),
        ),
      ),
    );
  }
}

