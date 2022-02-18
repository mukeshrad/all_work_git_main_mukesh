import 'package:contacts_service/contacts_service.dart';
import 'package:finandy/screens/golden_ticket/success_shared_screen.dart';
import 'package:finandy/utils/appBar.dart';
import 'package:finandy/utils/usedButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import 'Available.dart';
import 'contactList.dart';

class ShareWithFriendsScreen extends StatefulWidget {
  const ShareWithFriendsScreen({Key? key}) : super(key: key);

  @override
  _ShareWithFriendsScreenState createState() => _ShareWithFriendsScreenState();
}

class _ShareWithFriendsScreenState extends State<ShareWithFriendsScreen> {
  bool showContactField = false;
  ContactName? contactNAME;
  bool setContact = false;
  Iterable<Contact>? _contacts;
  sendToscreen(var page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  Future<PermissionStatus> _getPermission() async {
    final PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.denied) {
      final Map<Permission, PermissionStatus> permissionStatus =
          await [Permission.contacts].request();
      return permissionStatus[Permission.contacts] ?? PermissionStatus.granted;
    } else {
      return permission;
    }
  }

  Future<void> getContacts() async {
    //Make sure we already have permissions for contacts when we get to this
    //page, so we can just retrieve it
    final PermissionStatus permissionStatus = await _getPermission();
    if (permissionStatus == PermissionStatus.granted) {
      final Iterable<Contact> contacts = await ContactsService.getContacts();
      setState(
        () {
          _contacts = contacts;
        },
      );
    }
  }

  sendToContact() async {
    final PermissionStatus permissionStatus = await _getPermission();
    if (permissionStatus == PermissionStatus.granted) {
      ContactName contactName = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ContactsPage(
            contacts: _contacts,
          ),
        ),
      );
      setState(() {
        setContact = true;
        contactNAME = contactName;
      });
      print(contactName.displayName);
    } else {
      //If permissions have been denied show standard cupertino alert dialog
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Permissions error'),
          content: const Text('Please enable contacts access '
              'permission in system settings'),
          actions: <Widget>[
            CupertinoDialogAction(
              child: const Text('OK'),
              onPressed: () => Navigator.of(context).pop(),
            )
          ],
        ),
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    getContacts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffFFFFFF),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const NewAppBar(pageName: 'Share With Friend'),
              const SizedBox(
                height: 12.0,
              ),
              Expanded(
                child: ListView(
                  children: [
                    Image.asset('assets/images/share.png'),
                    buildCard(
                      valid_Date: '06/30',
                      onTapShare: () {},
                      cardNo: '1234 5678 9012 3456',
                    ),
                    const SizedBox(
                      height: 40.0,
                    ),
                    showContactField == false
                        ? buildMobNoButton(
                            callback: () async {
                              setState(() {
                                showContactField = true;
                              });
                            },
                          )
                        : buildSelectFromContactButton(
                            context,
                            callback: () async {
                              await sendToContact();
                            },
                          ),
                    const SizedBox(
                      height: 40.0,
                    ),
                  ],
                ),
              ),
              UsedButton(
                buttonName: const Center(
                  child: Text(
                    'Share with Friend',
                    style:
                        TextStyle(fontWeight: FontWeight.w600, fontSize: 18.0),
                  ),
                ),
                onpressed: () {
                  sendToscreen(const TicketSharedSuccessFull());
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Column buildSelectFromContactButton(BuildContext context,
      {required VoidCallback callback}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: callback,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xff141414)),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: ListTile(
                  title: setContact
                      ? Padding(
                          padding: const EdgeInsets.only(left: 6.0),
                          child: Text(
                            '${contactNAME?.displayName}',
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff141414),
                            ),
                          ),
                        )
                      : const Padding(
                          padding: EdgeInsets.only(left: 6.0),
                          child: Text(
                            "Select From Contact List",
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff141414),
                            ),
                          ),
                        ),
                  trailing: const Icon(
                    Icons.contacts,
                    color: Color(0xff5C5C5C),
                  ),
                ),
              ),
              Positioned(
                left: 20.06,
                top: -10.0,
                child: Container(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    children: const [
                      Text(
                        'Mobile',
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Color(0xff141414),
                        ),
                      ),
                      Text(
                        '*',
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 4.0,
        ),
        const Text(
          'Only Aadhar registered number allowed.',
          style: TextStyle(
            fontSize: 10.0,
            color: Color(0xff5C5C5C),
          ),
        )
      ],
    );
  }

  InkWell buildMobNoButton({required VoidCallback callback}) {
    return InkWell(
      onTap: callback,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8.0),
        ),
        padding: const EdgeInsets.only(
          top: 16.0,
          bottom: 16.0,
          left: 18.0,
        ),
        child: const Text(
          'Mobile Number',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
            color: Color(0xff7B8497),
          ),
        ),
      ),
    );
  }
}
