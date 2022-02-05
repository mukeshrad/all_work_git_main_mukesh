import 'dart:io';
import 'package:workmanager/workmanager.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:finandy/services/permissions.dart';

const fetchBackgroundLocation = "fetchBackgroundLocation";

void callbackDispatcher() {

  Workmanager().executeTask((task, inputData) async {
    switch (task) {
      case fetchBackgroundLocation:
        Position userLocation = await
            Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
        break;
    }
    return Future.value(true);
  });
}