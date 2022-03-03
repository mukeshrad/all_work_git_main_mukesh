import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../modals/customer.dart';

class ProfileUi extends StatelessWidget {
  const ProfileUi(
      {Key? key,
      required this.id,
      required this.name,
      required this.profileImg})
      : super(key: key);
  final String name;
  final String profileImg;
  final String id;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    String? profileImage =
        Provider.of<Customer>(context, listen: false).profileImage;
    String initials() {
      return ((name.isNotEmpty == true ? name[0] : "")).toUpperCase();
    }

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      // fit: StackFit.loose,
      children: [
        Container(
          padding: const EdgeInsets.only(
            bottom: 18.0,
          ),
          height: 134.0,
          width: 304.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: const Color(0xff084E6C),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                offset: const Offset(0.0, 5.0),
                blurRadius: 30.0,
              ),
            ],
            // border: Border.all(color: Colors.grey),
          ),
          alignment: Alignment.bottomCenter,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Column(
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      color: Colors.white,
                      // fontFamily: 'Nunito',
                      fontWeight: FontWeight.w700,
                      fontSize: 20.0,
                    ),
                  ),
                  // THis below text is for upi id.
                  // const SizedBox(
                  //   height: 2,
                  // ),
                  // Container(
                  //   child: Text(
                  //     id,
                  //     style: TextStyle(
                  //       color: Colors.white,
                  //     ),
                  //   ),
                  // )
                ],
              )
            ],
          ),
        ),
        Positioned(
          top: -52,
          child: Align(
            alignment: Alignment.center,
            child: Stack(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.blueGrey,
                  backgroundImage: profileImage != null
                      ? NetworkImage(profileImage)
                      : null, // radius: ,
                  radius: 55,
                  child: profileImage == null ? Text(initials()) : null,
                ),
                // Positioned(
                //   right: 0,
                //   bottom: 0,
                //   child: Container(
                //     padding: const EdgeInsets.all(5),
                //     alignment: Alignment.topLeft,
                //     decoration: BoxDecoration(
                //       color: Colors.white,
                //       border: Border.all(color: Colors.grey, width: 0.5),
                //       shape: BoxShape.circle,
                //     ),
                //     child: const Icon(
                //       Icons.camera_enhance,
                //       color: Colors.black87,
                //       size: 18,
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
