import 'package:finandy/modals/customer.dart';
import 'package:finandy/screens/golden_ticket/golden_ticket.dart';
import 'package:finandy/screens/profile/profile.dart';
import 'package:finandy/screens/Payment/Notification/Notification_List.dart';
import 'package:flutter/material.dart';

import 'package:finandy/constants/texts.dart';
import 'package:provider/src/provider.dart';

class MainAppBar extends StatefulWidget implements PreferredSizeWidget {
  const MainAppBar({
    Key? key,
    required this.appBar,
    required this.title,
  }) : super(key: key);
  final AppBar appBar;
  final String title;

  @override
  _MainAppBarState createState() => _MainAppBarState();

  @override
  Size get preferredSize {
    return Size.fromHeight(appBar.preferredSize.height);
  }
}

class _MainAppBarState extends State<MainAppBar> {
  @override
  Widget build(BuildContext context) {
    return  AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        title: Text("${context.watch<Customer>().customerName}", style: const TextStyle(
           fontSize: 18,
           color: Colors.black,
           overflow: TextOverflow.fade
          ),
          overflow: TextOverflow.fade,
        ),
          actions: [
            if(widget.title == "rootPage")
            CircleAvatar(
              radius: 15,
                backgroundColor: Colors.black12,
              child: GestureDetector(
                onTap: (){Navigator.of(context).push(MaterialPageRoute(builder: (context) => const GoldenTicket()));},
                child: const Icon(Icons.confirmation_num_outlined, color: Colors.black, size: 18)
                ),
            ),
            const SizedBox(width: 8,),
            CircleAvatar(
              radius: 15,
              backgroundColor: Colors.black12,
              child: GestureDetector(
                onTap: (){},
                child: const Icon(Icons.notifications_none_sharp, color: Colors.black, size: 20,)
                ),
            ),
            const SizedBox(width: 8,),
              GestureDetector(
                onTap: (){Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ProfilePage()));},
                child: Container(
                  margin: const EdgeInsets.only(right: 12.0, left: 2),
                  child: CircleAvatar(
                    radius: 15,
                    child: ClipOval(
                     child: Image.network(
                       userImg,
                       fit: BoxFit.cover
                       ),
                     ),
                  ),
                ),
              ),
            IconButton(
              onPressed: (){

                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => NotificationListPage()));


              },
              icon: const Icon(Icons.notifications_none_sharp)
              )  
          ],
      );
  }
}
