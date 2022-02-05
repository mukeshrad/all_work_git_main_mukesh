import 'dart:io';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:finandy/services/permissions.dart';


class LocationDetails extends StatefulWidget {
  static String id = "location" ;
  const LocationDetails({ Key? key }) : super(key: key);

  @override
  _LocationDetailsState createState() => _LocationDetailsState();
}
class _LocationDetailsState extends State<LocationDetails> {
  Position? position;
  @override
  void initState() {
    super.initState();
    locationHandler(_getUserPosition);
  }


  void _getUserPosition() async {
    Position userLocation = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      position = userLocation;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Location"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              position.toString()
            ),
          ],
        ),
      ),
    );
  }
}

