import 'package:finandy/utils/appBar.dart';
import 'package:finandy/utils/textField.dart';
import 'package:finandy/utils/usedButton.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class VehicleDetails extends StatefulWidget {
  const VehicleDetails({Key? key}) : super(key: key);

  @override
  _VehicleDetailsState createState() => _VehicleDetailsState();
}

class _VehicleDetailsState extends State<VehicleDetails> {
  // TextEditingController _nameController = TextEditingController();
  // TextEditingController _adharController = TextEditingController();
  // TextEditingController _genderController = TextEditingController();
  // TextEditingController _dateofBirthController = TextEditingController();
  // TextEditingController _residentialPinCodeController = TextEditingController();
  String vehicleType = "Car";
  String bottomSheetVehicleType = '';
  final GlobalKey _menuKey = GlobalKey();
  static const List<String> choices = <String>['View', 'Replace', "Delete"];

  sendToscreen(var page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      vehicleType = "Car";
    });
  }

  void handleClick(String value) {
    switch (value) {
      case 'Logout':
        break;
      case 'Settings':
        break;
    }
  }

  void choiceAction(String choice) {
    if (choice == 'View') {
      if (kDebugMode) {
        print('View');
      }
    }
    if (choice == 'Replace') {
      if (kDebugMode) {
        print('Replace');
      }
    }
    if (choice == 'Delete') {
      if (kDebugMode) {
        print('Delete');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ListView(
                children: [
                  const NewAppBar(
                    pageName: 'Vehicle Details',
                    // prefix: buildAddButton(context),
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  IgnorePointer(
                    ignoring: false,
                    child: dropDownFieldButton(),
                  ),
                  IgnorePointer(
                    ignoring: true,
                    child: Textfield(
                      labelText: 'Vehicle *',
                      initialText: 'UP26 XY1234',
                    ),
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  buildRCImageContainer(context),
                ],
              ),
            ),
            UsedButton(
              buttonName: 'Edit',
              onpressed: () {},
            ),
          ],
        ),
      ),
    ));
  }

  IgnorePointer buildRCImageContainer(BuildContext context) {
    return IgnorePointer(
      ignoring: false,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            child: Column(
              children: [
                Image.asset('assets/images/cashback.gif'),
                ListTile(
                  title: Text("image.123"),
                  trailing: PopupMenuButton<String>(
                    icon: const Icon(Icons.more_vert),
                    onSelected: choiceAction,
                    itemBuilder: (BuildContext context) {
                      return choices.map((String choice) {
                        return PopupMenuItem<String>(
                            value: choice,
                            child: Text(
                              choice,
                            ));
                      }).toList();
                    },
                  ),
                ),
              ],
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: Colors.grey),
              color: Color(0xffF5F5F5),
            ),
            padding: EdgeInsets.only(
              top: 10.0,
            ),
          ),
          Positioned(
            left: 10.6,
            top: -10.0,
            child: Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              padding: EdgeInsets.all(4.0),
              child: Row(
                children: [
                  Text(
                    'Uploaded RC',
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.grey.shade700,
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
    );
  }

  MaterialButton buildAddButton(BuildContext context) {
    return MaterialButton(
      color: const Color(0xff818181),
      onPressed: () {
        buildShowModalBottomSheet(context);
      },
      child: Row(
        children: [
          Icon(
            Icons.add,
            color: Colors.white,
          ),
          SizedBox(
            width: 2.0,
          ),
          Text(
            'Add',
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }

  Future<dynamic> buildShowModalBottomSheet(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setModalState) {
              return Padding(
                padding: const EdgeInsets.only(
                  left: 30.0,
                  right: 30.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 53.0,
                    ),
                    Center(
                      child: Material(
                        child: const Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Icon(
                            Icons.keyboard_arrow_down_outlined,
                          ),
                        ),
                        borderRadius: BorderRadius.circular(30.0),
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(
                      height: 14.0,
                    ),
                    const Center(
                      child: Text(
                        'Add Vehicle Details',
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 18.0),
                      ),
                    ),
                    const SizedBox(
                      height: 32.0,
                    ),
                    const Text(
                      'Vehicle Type',
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    IgnorePointer(
                      ignoring: false,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          dropDownButton(setModalState),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        });
  }

  Container dropDownFieldButton() {
    return Container(
      decoration: BoxDecoration(
          color: const Color(0xffEBEBEB),
          borderRadius: BorderRadius.circular(8.0)),
      child: DropdownButtonFormField(
        validator: (value) {
          if (value == null) {
            return 'Required';
          }
          return null;
        },
        value: vehicleType,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          color: Colors.black,
          fontSize: 14.0,
        ),
        items: const [
          DropdownMenuItem(
            child: Text(
              "Car",
            ),
            value: "Car",
          ),
          DropdownMenuItem(
            child: Text("Bike/Scooter"),
            value: "Bike/Scooter",
          ),
        ],
        onChanged: (c) {
          String occuType = c.toString();
          setState(() {
            vehicleType = occuType;
          });
        },
        decoration: const InputDecoration(
          labelText: "Occupation Type*",
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
        ),
      ),
    );
  }

  Container dropDownButton(StateSetter setModalState) {
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: const Color(0xffEBEBEB),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            offset: const Offset(0.0, 5.0),
            blurRadius: 30.0,
          ),
        ],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: DropdownButton(
        underline: Container(),
        value: bottomSheetVehicleType == '' ? null : bottomSheetVehicleType,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          color: Colors.black,
          fontSize: 16.0,
        ),
        items: const [
          DropdownMenuItem(
            child: Text(
              "Car",
            ),
            value: "Car",
          ),
          DropdownMenuItem(
            child: Text("Bike/Scooter"),
            value: "Bike/Scooter",
          ),
        ],
        hint: const Text(
          "Select Vehicle Type",
          style: TextStyle(
              color: Colors.black,
              // fontSize: 16,
              fontWeight: FontWeight.w600),
        ),
        onChanged: (c) {
          String occuType = c.toString();
          setModalState(() {
            bottomSheetVehicleType = c.toString();
          });
        },
      ),
    );
  }
}
