import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_number/mobile_number.dart';
import 'package:permission_handler/permission_handler.dart';

class SelectContacts extends StatefulWidget {
  const SelectContacts({Key? key}) : super(key: key);

  @override
  _SelectContactsState createState() => _SelectContactsState();
}

class _SelectContactsState extends State<SelectContacts> {
  TextEditingController _serachcontroller = new TextEditingController();

  List<Contact> listAppContacts = [];
  List<Contact> saveListLocal = [];

  bool _load = false;

  Future<void> getAllContactApp() async {
    var status = await Permission.contacts.status;

    if (await Permission.contacts.request().isGranted) if (status.isGranted) {
      print("isGranted");
      _load = true;
      setState(() {});
      listAppContacts = await ContactsService.getContacts();
      setState(() {});
      saveListLocal = listAppContacts;

      _load = false;

      setState(() {
        print(listAppContacts.length);
      });
    } else if (status.isDenied) {
      print("isDenied");
      getAllContactApp();
    }

    print(status);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllContactApp();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initMobileNumberState() async {
    if (!await MobileNumber.hasPhonePermission) {
      await MobileNumber.requestPhonePermission;
      return;
    }
    String mobileNumber = '';
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      mobileNumber = (await MobileNumber.mobileNumber)!;
      // _simCard = (await MobileNumber.getSimCards)!;
    } on PlatformException catch (e) {
      debugPrint("Failed to get mobile number because of '${e.message}'");
    }
    if (!mounted) return;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: BackButton(color: Colors.black),
          title: const Text(
            "Select Contacts",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: _load == true
            ? Center(
                child: Container(
                  color: Colors.white,
                  // width: 70.0,
                  height: 200.0,
                  child: new Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: new Center(
                          child: Column(
                        children: [
                          new CircularProgressIndicator(),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            child: Text("Please wait..."),
                          )
                        ],
                      ))),
                ),
              )
            : Column(
                children: [
                  Container(
                    color: Theme.of(context).primaryColor,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: ListTile(
                          leading: new Icon(Icons.search),
                          title: TextField(
                            controller: _serachcontroller,
                            decoration: const InputDecoration(
                                hintText: 'Search', border: InputBorder.none),
                            onChanged: onSearchTextChanged,
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.cancel),
                            onPressed: () {
                              _serachcontroller.clear();
                              onSearchTextChanged('');
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                      child: ListView.builder(
                    padding: EdgeInsets.only(top: 20),
                    itemCount: listAppContacts.length,
                    itemBuilder: (context, index) {
                      return ContactsView(context, index);
                    },
                  ))
                ],
              ));
  }

  Widget ContactsView(BuildContext context, int index) {
    var item = listAppContacts[index];
    var mobile;

    if (listAppContacts[index].phones != null) {
      if (listAppContacts[index].phones?.length != 0) {
        mobile = listAppContacts[index].phones?.first.value;
      } else {
        mobile = "";
      }
    } else {
      mobile = "";
    }

    var name = item.displayName?.split(' ');
    var fWord = name?[0];
    var sWord = name?[0];
    var fullName = "";
    if (fWord != null) {
      fullName = fWord[0];
    }
    if (sWord != null) {
      fullName = fullName + " " + sWord[0];
    }
    print(mobile);
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        margin: EdgeInsets.only(left: 20, right: 20),
        height: 80,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(),

            Row(
              children: [
                Container(
                  decoration: new BoxDecoration(
                    color: Colors.grey.withOpacity(0.5),
                    shape: BoxShape.circle,
                  ),
                  height: 50,
                  width: 50,
                  child: Center(
                    child: Text(
                      fullName,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width - 150,
                        child: Text(item.displayName.toString(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            softWrap: false,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(mobile != null ? mobile.toString() : "",
                          style: TextStyle(color: Colors.black, fontSize: 17))
                    ],
                  ),
                )
              ],
            ),
            Container(
              height: 1,
              color: Colors.grey.withOpacity(0.5),
            )
          ],
        ),
      ),
    );
  }

  onSearchTextChanged(String text) async {
    listAppContacts = [];
    if (text.isEmpty) {
      setState(() {
        listAppContacts = saveListLocal;
      });
      return;
    }

    saveListLocal.forEach((userDetail) {
      var stringGet = userDetail.displayName.toString();
      if (stringGet.contains(text)) {
        listAppContacts.add(userDetail);
      }
    });
    setState(() {});
  }
}
