import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';

class AppContact {
  final Color color;
  Contact info;

  AppContact({Key? key, required this.color, required this.info});

  getInfo(){
    Map<String, dynamic> _map = {};
    
    if(info.emails!.isNotEmpty || info.phones!.isNotEmpty) {
      _map = {
        "displayName": info.displayName,
        "emails": info.emails,
        "phones": info.phones,
        "postalAddress": info.postalAddresses
      };
    }

    return _map;
  }
}

class ContactAvatar extends StatelessWidget {
  const ContactAvatar({
    Key? key,
    required this.contact,
    required this.size,
  } ) : super(key: key);
  final AppContact? contact;
  final double size;
  @override
  Widget build(BuildContext context) {
    return Container(
        width: size,
        height: size,
        decoration: const BoxDecoration(
            shape: BoxShape.circle),
        child:  CircleAvatar(
                child: Text(contact!.info.initials(),
                    style: const TextStyle(color: Colors.white)),
                backgroundColor: Colors.transparent));
  }
}
