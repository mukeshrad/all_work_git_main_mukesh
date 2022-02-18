import 'package:finandy/constants/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileBuildingFailure extends StatefulWidget {
  const ProfileBuildingFailure({ Key? key }) : super(key: key);

  @override
  _ProfileBuildingFailureState createState() => _ProfileBuildingFailureState();
}

class _ProfileBuildingFailureState extends State<ProfileBuildingFailure> {
  late SvgPicture bg;
  final _formKey = GlobalKey<FormState>();
  bool checkValue = false;
  var _ticketNo;
  @override
  void initState() {
    super.initState();
    bg = SvgPicture.asset("assets/images/scardbg.svg");
  }
  
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precachePicture(bg.pictureProvider, context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
                const Text(
                      sorryTxt,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xff141414),
                        fontSize: 32,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w700,
                      )), 
                const SizedBox(height: 7,),      
                const Text(
                        sorryDes,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),  
                const SizedBox(height: 10,),
                bg,
                const SizedBox(height: 7,),
                const Text(
                        askOthers,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.black87
                        ),
                      ),  
                const SizedBox(height: 7,),
                const Text(
                        enterTicketNo,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.black87
                        ),
                      ),  
               const SizedBox(height: 45,),
                  ElevatedButton(
                   onPressed: () async{
                     if(_formKey.currentState!.validate() && checkValue == true){
                       _formKey.currentState!.save();
                          
                          // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const OTPverify(fromPage: "signin",)));
                     }else {
                       return;
                     }
                   },
                  style: ElevatedButton.styleFrom(
                    primary: checkValue ? Theme.of(context).primaryColor : Theme.of(context).primaryColor.withOpacity(0.65),
                    alignment: Alignment.bottomCenter,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                   ),
                   child: const  Padding(
                   padding: EdgeInsets.all(10.0),
                   child: Text(submit, style: TextStyle(fontSize: 18),),
                   ) 
                     )
            ],
            ),
        ),
      ),
    );
  }
}