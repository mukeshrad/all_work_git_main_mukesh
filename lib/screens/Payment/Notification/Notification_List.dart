import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swagger/api.dart';

import '../../../constants/instances.dart';

class NotificationListPage extends StatefulWidget {
  const NotificationListPage({Key? key}) : super(key: key);

  @override
  _NotificationList createState() => _NotificationList();
}

class _NotificationList extends State<NotificationListPage> {

  List<Notifications> notificationList = [];
  var getUserID = "";
  var _isLoading = false;

  @override
  void initState() {
    super.initState();
    getUserDetails();
  }

  void getUserDetails() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var id = preferences.get("userId");
    print("user ID : $id");
    setState(() {
      getUserID = id.toString();
      getNotification();
    });
  }
  void getNotification() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    Object? token = preferences.get("token");
    apiClient.addDefaultHeader("Client-Secret", "");
    apiClient.setAccessToken(token.toString());
    // print(token.toString());
    setState(() {
      _isLoading = true;
    });
    try {
      var response = await notificationApi
          .v1UsersNotificationGet(getUserID);
      setState(() {
        _isLoading = false;
      });
      setState(() {
        notificationList = response.notifications;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      notificationList = [];
      print(
          "Exception when calling NotificationApi->v1Notification: $e\n");
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: myAppBar(),
        body: Column(
          children: [
            notificationListContainer(context),
          ],
        ));
  }

  AppBar myAppBar(){
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: const BackButton(color: Colors.black),
      title: const Text(
        "Notification",
        style: TextStyle(color: Colors.black),
      ),
    );
  }
  Widget notificationListContainer(BuildContext context){
    return  _isLoading == true ?  Expanded(
      child: Center(
        child: SizedBox(height: 50,width: 50,
          child: CircularProgressIndicator(),),
      )
    ) :
    notificationList.length == 0 ? const Expanded(
      child: Center( child : Text("No data found"))) :
      Expanded(
        child: ListView.builder(
          padding: const EdgeInsets.only(top: 20),
          itemCount: notificationList.length,
          itemBuilder: (context, index) {
            return notificationItem(context, index);
          },
        ));
  }
  Widget notificationItem(BuildContext context, int index) {

    var item = notificationList[index];

    var getdate = item.created.toString();
    DateTime dateTime = DateTime.parse(getdate);
    String createData = DateFormat("yyyy-MM-dd").format(dateTime);

    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        margin: const EdgeInsets.only(left: 30, right: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
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
                    createData.toString(),
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

