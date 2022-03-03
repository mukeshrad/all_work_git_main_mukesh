import 'package:permission_handler/permission_handler.dart';

class Requires {
  Permission sms = Permission.sms;
  Permission calls = Permission.phone;
  Permission camera = Permission.camera;
  Permission location = Permission.location;
  Permission contacts = Permission.contacts;
  Permission sensors = Permission.sensors;
  Permission storage = Permission.storage;
   
  checkStatus(Permission target, func) async{
    PermissionStatus _permissionStatus = await target.status;
     switch (_permissionStatus) {
      case PermissionStatus.denied:
        await target.request();
        break;
      case PermissionStatus.granted:
        func();
        break;
      case PermissionStatus.limited:
        await target.request();
        break;
      default:
        await target.request();
    }
  }

  Future<bool> checkGranted() async{
    Map<Permission, PermissionStatus> statuses = await [
        Permission.location,
        Permission.storage,
        Permission.camera,
        Permission.contacts,
        Permission.sms,
      ].request();

      for(var v in statuses.keys){
        print("${PermissionStatus.granted} ${statuses[v]} $v");
        if(statuses[v] != PermissionStatus.granted) return false; 
      }
      return true;
  }
  
}