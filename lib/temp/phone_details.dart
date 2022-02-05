import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';

class DeviceDetails extends StatefulWidget {
  static String id = "details" ;
  const DeviceDetails({ Key? key }) : super(key: key);

  @override
  _DeviceDetailsState createState() => _DeviceDetailsState();
}

class _DeviceDetailsState extends State<DeviceDetails> {
     static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
     Map<String, dynamic> _deviceData = <String, dynamic>{};

     @override
      void initState() {
        super.initState();
        getDetails();
      }
     
    getDetails()async{
      var deviceData = <String, dynamic>{};
       if (Platform.isAndroid) {
          deviceData =
              _readAndroidBuildData(await deviceInfoPlugin.androidInfo);
        } 
        // else if (kIsWeb) {
        //     // The web doesnt have a device UID, so use a combination fingerprint as an example
        //     WebBrowserInfo webInfo = await deviceInfoPlugin.webBrowserInfo;
        //     // deviceIdentifier = webInfo.vendor + webInfo.userAgent + webInfo.hardwareConcurrency.toString();
        //   }
        //  else if (Platform.isIOS) {
        //   deviceData = _readIosDeviceInfo(await deviceInfoPlugin.iosInfo);
        // }
        setState(() {
            _deviceData = deviceData;
        });
    } 

    Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
    return <String, dynamic>{
      'version.securityPatch': build.version.securityPatch,
      'version.sdkInt': build.version.sdkInt,
      'version.release': build.version.release,
      'version.previewSdkInt': build.version.previewSdkInt,
      'version.incremental': build.version.incremental,
      'version.codename': build.version.codename,
      'version.baseOS': build.version.baseOS,
      'board': build.board,
      'bootloader': build.bootloader,
      'brand': build.brand,
      'device': build.device,
      'display': build.display,
      'fingerprint': build.fingerprint,
      'hardware': build.hardware,
      'host': build.host,
      'id': build.id,
      'manufacturer': build.manufacturer,
      'model': build.model,
      'product': build.product,
      'supported32BitAbis': build.supported32BitAbis,
      'supported64BitAbis': build.supported64BitAbis,
      'supportedAbis': build.supportedAbis,
      'tags': build.tags,
      'type': build.type,
      'isPhysicalDevice': build.isPhysicalDevice,
      'androidId': build.androidId,
      'systemFeatures': build.systemFeatures,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Device Details"),),
      body: Container(
         padding: const EdgeInsets.all(10),
         child: ListView.builder(
        itemCount: _deviceData.length,
        itemBuilder: (BuildContext context,int index){
           String key = _deviceData.keys.elementAt(index);
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: ListTile(
              leading: Text(key),
              title:Text("${_deviceData[key]}")
              ),
          );
         }
        ),
      ),
    );
  }
}