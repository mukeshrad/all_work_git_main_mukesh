import 'package:flutter/material.dart';

import 'package:finandy/screens/signin.dart';

class OTPError extends StatelessWidget {
  final Widget toPage;
  const OTPError({
    Key? key,
    required this.toPage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Center(
         child: Card(
           elevation: 2,
           margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 100),
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.stretch,
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               Container(
                 alignment: Alignment.center,
                 child: Icon(Icons.error, size: 75, color: Colors.red[800],),
               ),
               Container(
                 alignment: Alignment.center,
                 margin: const EdgeInsets.symmetric(vertical: 10),
                 child: const Text("Error", 
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25
                    ),
                    ),
               ),
               Container(
                 alignment: Alignment.center,
                 margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                 child: const Text("Your OTP verification failed", 
                    style: TextStyle(
                      fontSize: 20
                    ),
                 ),
               ),
               const SizedBox(height: 30,),
               Container(
                 margin: const EdgeInsets.symmetric(horizontal: 15),
                 child: ElevatedButton(onPressed: (){Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const SignUpScreen()));},
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                   ),
                   child: const Padding(
                     padding: EdgeInsets.all(15.0),
                     child: Text("Home", style: TextStyle(fontSize: 20),),
                   ) 
              ),
               ),
             ],
           ),
         ),
       ),
    );
  }
}
