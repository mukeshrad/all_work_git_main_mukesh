import 'package:finandy/modals/card_schema.dart';
import 'package:finandy/modals/customer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:finandy/screens/app_purpose.dart';
import 'package:finandy/screens/rootPageScreens/root_page.dart';
import 'package:finandy/constants/instances.dart';
import 'package:provider/provider.dart';

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
    Object? token = preferences.get("token");

    if(token != Null){
      Object? userId = preferences.get("userId");
      try {
        apiClient.setAccessToken(token.toString());
        final res = await userApi.v1UsersUserIdGet(userId.toString());
        final res1 = await cardsApi.v1UsersUserIdCardsPost(userId.toString());
        // print(res1.toString());
        Provider.of<Customer>(context, listen: false).setCustomer(res!.toJson(), UserState.LoggedIn);
        Provider.of<CardSchema>(context, listen: false).setCardDetails(json: res1!.toJson(), name: res.customerName);
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