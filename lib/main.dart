import 'package:finandy/constants/instances.dart';
import 'package:finandy/modals/card_schema.dart';
import 'package:finandy/modals/customer.dart';
import 'package:finandy/screens/app_purpose.dart';
import 'package:finandy/screens/root_page.dart';
import 'package:finandy/screens/signin.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'screens/request_permissions.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Customer()),
        ChangeNotifierProvider(create: (_) => CardSchema())
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLoggedIn = false;

  @override
  void initState() {
    // WidgetsFlutterBinding.ensureInitialized();
    checkLoggedIn();
    super.initState();
  }

  checkLoggedIn() async {
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
         setState(() {
          isLoggedIn = true;
         });
      } catch (e) {
        preferences.remove("token");
        preferences.remove("userId");
        print(e.toString());
      }

    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EcoHop',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: isLoggedIn ? const RootPage() : const AppPurpose(),
      // initialRoute: MyHomePage.id,
      routes: {
        //   '/apps': (context) => const AppsListScreen(),
        //   // '/qrscan': (context) => const FullScreenScannerPage(),
        //   '/': (context) => const MyHomePage(),
        //   '/location': (context) => const LocationDetails(),
        //   '/contacts': (context) => const ContactsView(),
        //   '/sms': (context) => SmsInbox(),
        //   '/device' : (context) => const DeviceDetails(),
        //   '/personalInfo': (context) => const PersonalInfo(),
        //   '/pay': (context) => const PayScreen(),
        //   '/otp': (context) => const OTPverify(),
        '/reqPerm': (context) => const RequestPermissions(),
        '/signin': (context) => const SignUpScreen(),
      //   '/proinfo': (context) => const ProfessionalDetails(),
      //   '/root': (context) => const RootPage()

      },
    );
  }
}
