import 'package:finandy/modals/bill.dart';
import 'package:finandy/modals/card_schema.dart';
import 'package:finandy/modals/customer.dart';
import 'package:finandy/screens/profile_building_success.dart';
import 'package:finandy/screens/rootPageScreens/root_page.dart';
import 'package:finandy/screens/signin.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:finandy/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'screens/request_permissions.dart';

void main() {
  firebaseSetup();
    SystemChrome.setSystemUIOverlayStyle(
     const SystemUiOverlayStyle(
       statusBarIconBrightness: Brightness.light,
       systemNavigationBarIconBrightness: Brightness.light,
       systemNavigationBarContrastEnforced: false,
    systemNavigationBarColor: Color(0xff084E6C), // navigation bar color
    statusBarColor: Color(0xff084E6C), // status bar color
  ));
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Customer()),
        ChangeNotifierProvider(create: (_) => CardSchema()),
        ChangeNotifierProvider(create: (_) => BillSchema(amount: 0))
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'EcoHop',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
           primarySwatch: const MaterialColor(
             0xff0d406a,
             <int, Color>{
            50:  Color(0xffe2e8ed),//10%
            100: Color(0xffb6c6d2),//20%
            200: Color(0xff86a0b5),//30%
            300: Color(0xff567997),//40%
            400: Color(0xff315d80),//50%
            500: Color(0xff0d406a),//60%
            600: Color(0xff0b3a62),//70%
            700: Color(0xff093257),//80%
            800: Color(0xff072a4d),//90%
            900: Color(0xff031c3c),//100%
             })
        ),
      // home: RootPage(),
      // home: isLoggedIn ? const RootPage() : const AppPurpose(),
      home: const SplashScreen(),
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

Future firebaseSetup() async {

  WidgetsFlutterBinding.ensureInitialized();

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    // if (notification != null) {
    //   print('Title ${notification.title}');
    //   print('Body ${notification.body}');
    //   print('onMessage: ${notification.body.toString()}');
    // }
  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
    var data = message.toString();
  });

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

}
