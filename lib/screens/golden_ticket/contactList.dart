import 'dart:math' as math;

import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ContactsPage extends StatefulWidget {
  final Iterable<Contact>? contacts;
  const ContactsPage({Key? key, this.contacts}) : super(key: key);

  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  Iterable<Contact>? _contacts;
  Future<void> getContacts() async {
    //Make sure we already have permissions for contacts when we get to this
    //page, so we can just retrieve it
    if (widget.contacts == null) {
      final Iterable<Contact> contacts = await ContactsService.getContacts();
      setState(() {
        _contacts = contacts;
      });
    } else {
      setState(() {
        _contacts = widget.contacts;
      });
    }
  }

  TextEditingController controller = TextEditingController();
  bool showTextField = false;
  Iterable<Contact>? _foundUsers = [];

  // This function is called whenever the text field changes
  void _runFilter(String enteredKeyword) {
    print(enteredKeyword);
    Iterable<Contact>? results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = _contacts;
    } else {
      results = _contacts?.where((user) {
        bool b = user.displayName!.toLowerCase().contains(
              enteredKeyword.toLowerCase(),
            );
        if (b) {
          if (kDebugMode) {
            print(user.displayName);
          }
        }
        return b;
      }).toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      _foundUsers = results;
    });
  }

  @override
  void initState() {
    getContacts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: _contacts != null
          ? controller.text.isNotEmpty
              ? _foundUsers!.isNotEmpty
                  ? buildSearchList()
                  : const Center(
                      child: Text(
                        'No results found',
                        style: TextStyle(fontSize: 24),
                      ),
                    )
              : buildList()
          : const Center(child: CircularProgressIndicator()),
    );
  }

  Padding buildList() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 30.0,
      ),
      child: ListView.builder(
        itemCount: _contacts?.length,
        itemBuilder: (BuildContext context, int index) {
          Contact? contact = _contacts?.elementAt(index);
          return buildListTile(contact);
        },
      ),
    );
  }

  Padding buildSearchList() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 30.0,
      ),
      child: ListView.builder(
        itemCount: _foundUsers!.length,
        itemBuilder: (BuildContext context, int index) {
          Contact? contact = _foundUsers?.elementAt(index);
          return buildListTile(contact);
        },
      ),
    );
  }

  Container buildListTile(Contact? contact) {
    return Container(
      decoration: const BoxDecoration(
          border: Border(
        top: BorderSide(
          color: Color(0xffEBEBEB),
          width: 0.5,
        ),
        bottom: BorderSide(
          color: Color(0xffEBEBEB),
          width: 0.5,
        ),
      )),
      child: ListTile(
        onTap: () {
          if (contact!.phones!.isNotEmpty) {
            ContactName contactName = ContactName(
              displayName: contact.displayName,
              phoneNo: contact.phones?.first.value,
            );
            print('${contact.phones?.length}');
            Navigator.pop(context, contactName);
          }
        },
        contentPadding: const EdgeInsets.symmetric(vertical: 2, horizontal: 18),
        leading: (contact!.avatar != null && contact.avatar!.isNotEmpty)
            ? CircleAvatar(
                radius: 25.0,
                backgroundImage: MemoryImage(contact.avatar!),
              )
            : CircleAvatar(
                radius: 25.0,
                child: Text(contact.initials()),
                backgroundColor:
                    Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                        .withOpacity(1.0)),
        title: Text(
          contact.displayName ?? '',
          style: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: contact.phones!.isNotEmpty
            ? Text(
                '${contact.phones?.first.value}',
                style: const TextStyle(
                  fontSize: 14.0,
                  color: Color(0xff5C5C5C),
                ),
              )
            : const Text(''),
        //This can be further expanded to showing contacts detail
        // onPressed().
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      elevation: 0.0,
      iconTheme: const IconThemeData(
        color: Color(0xff323232),
      ),
      title: showTextField
          ? TextField(
              autofocus: true,
              showCursor: true,
              controller: controller,
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
              onChanged: (v) {
                _runFilter(v);
              },
            )
          : const Text(
              'Select Contacts',
              style: TextStyle(
                color: Color(0xff323232),
                fontWeight: FontWeight.w500,
                fontSize: 19.0,
              ),
            ),
      actionsIconTheme: const IconThemeData(
        color: Color(0xff323232),
      ),
      actions: [
        IconButton(
          onPressed: () {
            setState(() {
              showTextField = true;
            });
          },
          icon: Icon(
            Icons.search,
          ),
        ),
        SizedBox(
          width: 10.0,
        ),
      ],
      backgroundColor: Colors.white,
    );
  }
}

class ContactName {
  String? displayName;
  String? phoneNo;
  ContactName({this.displayName, this.phoneNo});
}
