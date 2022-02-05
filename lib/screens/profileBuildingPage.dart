import 'package:finandy/constants/texts.dart';
import 'package:finandy/screens/root_page.dart';
import 'package:flutter/material.dart';

class ProfileBuilding extends StatefulWidget {
  const ProfileBuilding({Key? key}) : super(key: key);

  @override
  _ProfileBuildingState createState() => _ProfileBuildingState();
}

class _ProfileBuildingState extends State<ProfileBuilding> {
  bool isFirst = false;

  int idx = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              children: [
                Image.asset("assets/images/meter.gif"),
                Center(
                  child: SizedBox(
                    height: 35,
                    child: Text(
                      isFirst ? "" : type[idx],
                      style: const TextStyle(
                          fontSize: 17, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ],
            ),
            Center(
                child: Text(
              status[idx],
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            )),
            Center(
                child: SizedBox(
              height: 70,
              child: Text(
                liners[idx],
                softWrap: true,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 17,
                ),
              ),
            )),
            Container(
              margin: const EdgeInsets.only(
                  right: 20, left: 20, top: 20, bottom: 10),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => const RootPage()),
                        (route) => false);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.grey,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      checking,
                      style: const TextStyle(fontSize: 20),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
