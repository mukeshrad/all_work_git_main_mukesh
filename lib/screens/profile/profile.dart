import 'package:finandy/modals/customer.dart';
import 'package:finandy/screens/profile/employmentDetails.dart';
import 'package:finandy/screens/profile/personalDetails.dart';
import 'package:finandy/screens/profile/vehicle/vehicleLists.dart';
import 'package:finandy/utils/appBar.dart';
import 'package:finandy/utils/expense_bar.dart';
import 'package:finandy/utils/menuOption.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'address/addressInfo.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late double profileProgressint;

  //

  fetchData() async {
    var name = '${Provider.of<Customer>(context, listen: false).customerName}';
    var adhar = '${Provider.of<Customer>(context, listen: false).aadharNo}';
    var gender = '${Provider.of<Customer>(context, listen: false).gender}';
    var dob = '${Provider.of<Customer>(context, listen: false).dateOfBirth}';
    var pin =
        '${Provider.of<Customer>(context, listen: false).currentAddress?.pincode}';
    var companyName =
        '${Provider.of<Customer>(context, listen: false).professionalInfo?.occupation}';
    var occupationType =
        '${Provider.of<Customer>(context, listen: false).professionalInfo?.occupationType}';
    var monthlyEarning =
        '${Provider.of<Customer>(context, listen: false).professionalInfo?.monthlyEarning}';
    // var OccupationType =
    //    '${Provider.of<Customer>(context, listen: false).professionalInfo?.occupation}';
    var line1 =
        '${Provider.of<Customer>(context, listen: false).currentAddress?.line_1}';
    var line2 =
        '${Provider.of<Customer>(context, listen: false).currentAddress?.line_2}';
    var landmark =
        '${Provider.of<Customer>(context, listen: false).currentAddress?.landmark}';
    var city =
        '${Provider.of<Customer>(context, listen: false).currentAddress?.city}';
    var pinCode =
        '${Provider.of<Customer>(context, listen: false).currentAddress?.pincode}';
    var state =
        '${Provider.of<Customer>(context, listen: false).currentAddress?.state}';
    List list = [
      name,
      adhar,
      gender,
      dob,
      pin,
      companyName,
      occupationType,
      monthlyEarning,
      line1,
      line2,
      landmark,
      city,
      pinCode,
      state
    ];
    int c = 15;
    list.forEach((element) {
      print(element);
      if (element == null ||
          element == '' ||
          element == 'Select' ||
          element == 'null') {
        c--;
      } else {}
    });
    print('this is $c');
    double p = 1 / 15 * c;
    setState(() {
      profileProgressint = p;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          child: ListView(
            children: [
              const NewAppBar(
                pageName: 'Profile',
              ),
              const SizedBox(
                height: 18.0,
              ),
              profileProgress(
                context: context,
                showProfileTile: true,
                progress: profileProgressint,
                name:
                    '${Provider.of<Customer>(context, listen: false).customerName}',
                upiId: 'harsh@icici',
                profileImg: '',
              ),
              const SizedBox(
                height: 15.0,
              ),
              MenuOption(
                s: "Personal Details",
                onTap: () {
                  sendToScreen(
                    page: PersonalDetails(
                      profileProgressint: profileProgressint,
                    ),
                    buildContext: context,
                  );
                },
                iconData: Icons.account_circle_outlined,
                iconColor: const Color(0xffDD2E44),
                showTrailIcon: true,
              ),
              // MenuOption(
              //   s: "Education Details",
              //   onTap: () {
              //     sendToscreen(const PersonalDetails());
              //   },
              //   iconData: Icons.school,
              //   iconColor: const Color(0xff4BB2FF),
              //   showTrailIcon: true,
              // ),
              MenuOption(
                iconData: Icons.wallet_travel_outlined,
                iconColor: const Color(0xff3B88C3),
                s: "Employment Details",
                onTap: () {
                  sendToScreen(
                      page: const EmploymentDetails(), buildContext: context);
                },
                showTrailIcon: true,
              ),
              MenuOption(
                s: "Address information",
                onTap: () {
                  sendToScreen(
                      page: const AddressInfo(), buildContext: context);
                },
                iconData: Icons.location_on,
                iconColor: const Color(0xffF4900C),
                showTrailIcon: true,
              ),
              MenuOption(
                s: "Vehicle Details",
                iconData: Icons.car_rental,
                iconColor: const Color(0xff7333C7),
                onTap: () {
                  sendToScreen(
                      page: const VehicleList(), buildContext: context);
                },
                showTrailIcon: true,
              ),
              // MenuOption(
              //   s: "Financial Details",
              //   iconData: Icons.account_balance_outlined,
              //   iconColor: const Color(0xff084E6C),
              //   onTap: () {
              //     sendToscreen(const VehicleDetails());
              //   },
              //   showTrailIcon: false,
              // ),
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

profileProgress({
  required double progress,
  required String name,
  required String upiId,
  required String profileImg,
  bool? showProfileTile,
  required BuildContext context,
}) {
  var p = progress * 100;
  String? profileImage =
      Provider.of<Customer>(context, listen: false).profileImage;
  String initials() {
    return ((name.isNotEmpty == true ? name[0] : "")).toUpperCase();
  }

  return Card(
    elevation: 2.0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    color: const Color(0xffFFFFFF),
    child: Padding(
      padding: const EdgeInsets.all(22),
      child: Column(
        children: [
          showProfileTile == true
              ? ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.blueGrey,
                    radius: 25.5,
                    backgroundImage: profileImage != null
                        ? NetworkImage(profileImage)
                        : null,
                    child: profileImage == null ? Text(initials()) : null,
                  ),
                  title: Text(
                    name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16.0,
                    ),
                  ),
                  // subtitle: Text(upiId),
                  trailing: InkWell(
                    onTap: () {
                      sendToScreen(
                        page: PersonalDetails(
                          profileProgressint: progress,
                        ),
                        buildContext: context,
                      );
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.edit,
                        color: Color(0xff084E6C),
                      ),
                    ),
                  ),
                )
              : Container(),
          Padding(
            padding: EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              top: showProfileTile == true ? 16.0 : 0.0,
              bottom: 16.0,
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 17.0,
              ),
              decoration: BoxDecoration(
                  color: Color(0xffFAFAFA),
                  borderRadius: BorderRadius.circular(7.0)),
              child: Row(
                children: [
                  Expanded(
                    child: ExpenseBar(
                      label: "Profile Completed",
                      barColor: Colors.green,
                      spendingAmount: 1000,
                      spendingPctOfTotal: progress,
                      height: 10.0,
                      color: const Color(0xff55ACEE),
                      border: false,
                    ),
                  ),
                  const SizedBox(
                    width: 9.0,
                  ),
                  Text(
                    '${p.toInt()}% Complete',
                    style: const TextStyle(
                      fontSize: 12.0,
                      // color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  sendToScreen(
                    page: PersonalDetails(
                      profileProgressint: progress,
                    ),
                    buildContext: context,
                  );
                },
                child: const Text(
                  'Complete your profile',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14.0,
                    color: Color(0xff084E6C),
                    decoration: TextDecoration.underline,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    ),
  );
}

sendToScreen({var page, required BuildContext buildContext}) {
  Navigator.push(
    buildContext,
    MaterialPageRoute(builder: (buildContext) => page),
  );
}
