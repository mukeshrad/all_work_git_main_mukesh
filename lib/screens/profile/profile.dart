import 'package:finandy/screens/profile/addressInfo.dart';
import 'package:finandy/screens/profile/employmentDetails.dart';
import 'package:finandy/screens/profile/personalDetails.dart';
import 'package:finandy/screens/profile/vehicleInfo.dart';
import 'package:finandy/utils/appBar.dart';
import 'package:finandy/utils/expense_bar.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  menuOption(String s, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 5),
      child: ListTile(
        tileColor: Colors.grey[200],
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            side: BorderSide(width: 0.5, color: Colors.white)),
        leading: Text(
          s,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
        onTap: onTap,
        trailing: Image.asset("assets/images/check.png"),
      ),
    );
  }

  profileProgress() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          children: [
            Row(
              children: const [
                Text(
                  'Profile Progress',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  width: 30.0,
                ),
                Expanded(
                  child: Divider(
                    thickness: 1.0,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 18.0,
            ),
            Row(
              children: [
                const CircleAvatar(
                  radius: 24.5,
                  backgroundColor: Colors.black,
                  child: CircleAvatar(
                    radius: 22.5,
                    backgroundColor: Colors.grey,
                    backgroundImage: null,
                  ),
                ),
                const SizedBox(
                  width: 22.0,
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12.0,
                      vertical: 17.0,
                    ),
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(7.0)),
                    child: Row(
                      children: const [
                        Expanded(
                          child: ExpenseBar(
                            label: "Profile Completed",
                            spendingAmount: 1000,
                            spendingPctOfTotal: 0.4,
                            height: 10.0,
                            color: Colors.black,
                            border: false,
                          ),
                        ),
                        SizedBox(
                          width: 9.0,
                        ),
                        Text(
                          '45% Complete',
                          style: TextStyle(
                            fontSize: 12.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 24.0,
            ),
            const Divider(
              thickness: 1.0,
            ),
            const SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'Complete your profile',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  //
  sendToscreen(var page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   automaticallyImplyLeading: true,
        //   // backgroundColor: Colors.transparent,
        //   title: const Text("Profile"),
        // ),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          child: Column(
            children: [
              const NewAppBar(
                pageName: 'Profile',
              ),
              profileProgress(),
              const SizedBox(
                height: 15.0,
              ),
              menuOption("Personal Details", () {
                sendToscreen(const PersonalDetails());
              }),
              menuOption("Employment Details", () {
                sendToscreen(const EmploymentDetails());
              }),
              menuOption("Address information", () {
                sendToscreen(const AdressInfo());
              }),
              menuOption("Vehicle Details", () {
                sendToscreen(const VehicleDetails());
              }),
            ],
          ),
        ),
      ),
    );
  }
}

appBar(String pageName, BuildContext context) {
  return Row(
    children: [
      IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back)),
      const SizedBox(
        width: 30.0,
      ),
      Text(
        pageName,
        style: const TextStyle(
          fontSize: 19,
          fontWeight: FontWeight.w500,
        ),
      ),
    ],
  );
}
