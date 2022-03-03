import 'package:finandy/modals/bill.dart';
import 'package:finandy/modals/card_schema.dart';
import 'package:finandy/modals/customer.dart';
import 'package:finandy/services/fetch_user_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:finandy/screens/app_purpose.dart';
import 'package:finandy/screens/rootPageScreens/root_page.dart';
import 'package:finandy/constants/instances.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({ Key? key }) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late SvgPicture logo;
  late SvgPicture background;

  @override
  void initState() {
    super.initState();
    logo = SvgPicture.asset("assets/images/logo.svg",);
    background = SvgPicture.asset("assets/images/splash.svg");
    checkLoggedIn();
  }

  checkLoggedIn() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString("token");
    String? userId = preferences.getString("userId");
    if(token != null && userId != null){
      try {
        apiClient.setAccessToken(token);
        await fetchAndUpdateUserDetails(context, userId, UserState.LoggedIn);
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const RootPage()), (route) => false);
      } catch (e) {
        preferences.remove("token");
        preferences.remove("userId");
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const AppPurpose()));
        print(e.toString());
      }
    }else{
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const AppPurpose()));
    }
  } 

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precachePicture(logo.pictureProvider, context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: logo,
          ),
          Positioned(
                child: background,
                bottom: 0,
                ),
          const Align(
            alignment: Alignment.bottomCenter,
            child: Text("Version 1.0")
            )
        ]
      ),
    );
  }
}