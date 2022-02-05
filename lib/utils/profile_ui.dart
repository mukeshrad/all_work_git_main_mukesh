import 'package:flutter/material.dart';

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
    return Container(
      height: height * 0.28,
      child: LayoutBuilder(
        builder: (context, constraints) {
          double innerHeight = constraints.maxHeight;
          double innerWidth = constraints.maxWidth;
          return Stack(
            fit: StackFit.expand,
            children: [
              Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: innerHeight * 0.72,
                    width: innerWidth,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        // color: Colors.gre,
                        border: Border.all(color: Colors.grey)),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 75,
                        ),
                        Text(
                          name,
                          style: const TextStyle(
                            color: Colors.black87,
                            // fontFamily: 'Nunito',
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Container(
                          child: Text(id),
                        )
                      ],
                    ),
                  )),
              Align(
                alignment: Alignment.topCenter,
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 15),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(profileImg),
                        // radius: ,
                        maxRadius: 55,
                      ),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        alignment: Alignment.topLeft,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey, width: 0.5),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.camera_enhance,
                          color: Colors.black87,
                          size: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
