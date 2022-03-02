import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swagger/api.dart';

import '../../../constants/instances.dart';

class NotificationListPage extends StatefulWidget {
  const NotificationListPage({Key? key}) : super(key: key);

  @override
  _NotificationList createState() => _NotificationList();
}

class _NotificationList extends State<NotificationListPage> {

  List<NotificationModel> notificationList = [];

  @override
  void initState() {
    super.initState();

    // //:- Add TODO for actual API integration.
    // var item1 = NotificatioListModal();
    // item1.date = "10:30 AM";
    // item1.title = "Your Password have been successfully changed.";
    // item1.isNew = true;
    // notificationList.add(item1);
    //
    // //:- Add TODO for actual API integration.
    // for (var i = 0; i < 6; i++) {
    //   var item1 = NotificatioListModal();
    //   item1.date = "10:30 AM";
    //   item1.title = "You received Rs 1 in your Everyday Card";
    //   item1.isNew = false;
    //   notificationList.add(item1);
    // }
    // setState(() {});

    getUserDetails();

  }

  var userId = "";
  getUserDetails() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var id = preferences.get("userId");
    print("user ID : $id");
    setState(() {
      userId = id.toString();
    });
    getNotification();
  }
  getNotification() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    Object? token = preferences.get("token");
    apiClient.addDefaultHeader("Client-Secret", "");
    apiClient.setAccessToken(token.toString());
    print(token.toString());
    try {
      var response = await userApi
          .v1UsersNotificationGet(userId);
      print("result:${response.notifications![0].userId}");
      setState(() {
        notificationList =  response.notifications!;
      });

      print("resultNotification:${response.notifications}");

    } catch (e) {
      print(
          "Exception when calling TransactionsApi->v1CardsCardIdTransactionsPost: $e\n");
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: const BackButton(color: Colors.black),
          title: const Text(
            "Notification",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Column(
          children: [
            Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.only(top: 20),
                  itemCount: notificationList.length,
                  itemBuilder: (context, index) {
                    return ContactsView(context, index);
                  },
                )),
            Container(
              height: 60,
              child: Column(
                children: [
                  Container(
                    height: 1,
                    color: Colors.grey.withOpacity(0.5),
                  ),
                  Expanded(
                      child: Center(
                        child: TextButton(
                          onPressed: () {
                          },
                          child: const Text("View All Notifications",
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                decoration: TextDecoration.underline,
                              )),
                        ),
                      ))
                ],
              ),
            )
          ],
        ));
  }

  Widget ContactsView(BuildContext context, int index) {
    var item = notificationList[index];
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        margin: const EdgeInsets.only(left: 30, right: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.spaceAround,

          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 5),

                  decoration: BoxDecoration(
                    color: item.seen != null
                        ? Colors.red.withOpacity(1)
                        : Colors.grey.withOpacity(1),
                    shape: BoxShape.circle,
                  ),
                  height: 10,
                  width: 10,
                  // child: const Center(child: const Text("A",style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.normal),),),
                ),
                const SizedBox(
                  width: 20,
                ),
                Container(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width - 180,
                    child: Text(item.title.toString(),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        )),
                  ),
                ),
                Container(
                  child: Text(
                   '2022-02-16',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                )
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 20, bottom: 20),
              height: 1,
              color: Colors.grey.withOpacity(0.5),
            )
          ],
        ),
      ),
    );
  }
}

