import 'package:finandy/modals/require.dart';
import 'package:finandy/utils/dialog_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show kIsWeb;

smsHandler(){

}

locationHandler(getLocation){
  Requires req = Requires();
  req.checkStatus(req.location, getLocation);
}

contactsHandler(getAllContacts){
  Requires req = Requires();

  req.checkStatus(req.contacts, getAllContacts);
//  if (await Permission.contacts.request().isGranted) {
      
//       searchController.addListener(() {
//         filterContacts();
//       });
//     }
}

phoneCallHandler(BuildContext context){
  Requires req = Requires();

  req.checkStatus(req.calls, buildPopupDialog(context));
}



cameraHandler(Function func){
  if(kIsWeb){
    func();
    return;
  }
  Requires req = Requires();

  req.checkStatus(req.calls, func);
}

bool checkAllPermissions(){
  Requires req = Requires();
 
  bool perm = false;
  req.checkGranted().then((value){
     print(value); 
    perm = value;
  }).onError((error, stackTrace) {
    perm = false;
  });
  return perm;
}
