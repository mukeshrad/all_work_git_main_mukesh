import 'package:contacts_service/contacts_service.dart';
import 'package:finandy/modals/contact_schema.dart';
import 'package:finandy/services/permissions.dart';
import 'package:finandy/services/server_handler.dart';
import 'package:finandy/utils/contacts_list.dart';
import 'package:flutter/material.dart';

class ContactsView extends StatefulWidget {
  static String id = "contacts" ;
  const ContactsView({ Key? key }) : super(key: key);

  @override
  _ContactsViewState createState() => _ContactsViewState();
}

class _ContactsViewState extends State<ContactsView> {
  List<AppContact> contacts = [];
  List<AppContact> contactsFiltered = [];
  Map<String, Color> contactsColorMap = {};
  TextEditingController searchController = TextEditingController();
  bool contactsLoaded = false;
  List<List> serverData = [];

  @override
  void initState() {
    super.initState();
    contactsHandler(getAllContacts);
  }

  // // TODO
  // getPermissions() async {
   
  // }

  String flattenPhoneNumber(String phoneStr) {
    return phoneStr.replaceAllMapped(RegExp(r'^(\+)|\D'), (Match m) {
      return m[0] == "+" ? "+" : "";
    });
  }
  

  getAllContacts() async {
    List colors = [
      Colors.green,
      Colors.indigo,
      Colors.yellow,
      Colors.orange
    ];
    int colorIndex = 0;
    List<AppContact> _contacts = (await ContactsService.getContacts()).map((contact) {
      Color baseColor = colors[colorIndex];
      colorIndex++;
      if (colorIndex == colors.length) {
        colorIndex = 0;
      }
      AppContact contc = AppContact(info: contact, color: baseColor);
      Map _mp = contc.getInfo();
      if(_mp.isNotEmpty){
        List temp = [];

        _mp.forEach((k, v) => temp.add(v)); 
        serverData.add(temp);
      }
      return contc;
    }).where((ct) => ct.info.phones!.isNotEmpty || ct.info.emails!.isNotEmpty).toList();
    // _contacts = contacts. 
    setState(() {
      contacts = _contacts;
      contactsLoaded = true;
    });
  }

  // filterContacts() {
  //   List<AppContact> _contacts = [];
  //   _contacts.addAll(contacts);
  //   if (searchController.text.isNotEmpty) {
  //     _contacts.retainWhere((contact) {
  //       String searchTerm = searchController.text.toLowerCase();
  //       String searchTermFlatten = flattenPhoneNumber(searchTerm);
  //       String contactName = contact.info.displayName!.toLowerCase();
  //       bool nameMatches = contactName.contains(searchTerm);
  //       if (nameMatches == true) {
  //         return true;
  //       }

  //       if (searchTermFlatten.isEmpty) {
  //         return false;
  //       }

  //       var phone = contact.info.phones!.firstWhere((phn) {
  //         String phnFlattened = flattenPhoneNumber('${phn.value}');
  //         return phnFlattened.contains(searchTermFlatten);
  //       }
  //       // , orElse: () => nullptr
  //       );

  //       // ignore: unnecessary_null_comparison
  //       return phone != null;
  //     });
  //   }
  //   setState(() {
  //     contactsFiltered = _contacts;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    contactsSender(serverData);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contacts"),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            contactsLoaded == true ?  // if the contacts have not been loaded yet
              ContactsList(
                reloadContacts: getAllContacts,
                contacts: contacts,
              ) :
            Container(  // still loading contacts
              padding: const EdgeInsets.only(top: 40),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            )
          ],
        ),
      ),
    );
  }
}