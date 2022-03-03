import 'package:flutter/material.dart';

import '../../../utils/appBar.dart';
import '../../../utils/detailsCard.dart';
import 'addressInfo.dart';

class AddressList extends StatefulWidget {
  const AddressList({Key? key}) : super(key: key);

  @override
  _AddressListState createState() => _AddressListState();
}

class _AddressListState extends State<AddressList> {
  sendToscreen(var page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0xffDD2E44),
          onPressed: () {
            sendToscreen(const AddressInfo());
          },
          child: const Icon(
            Icons.add,
            size: 25.0,
          ),
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const NewAppBar(
                pageName: 'Address Details',
                // prefix: buildAddButton(context),
              ),
              Expanded(
                child: ListView(
                  children: [
                    const SizedBox(
                      height: 25.0,
                    ),
                    DetailsCard(
                      onTapEdit: () {},
                      showeye: false,
                      title1: 'Address Type',
                      value1: 'Rented',
                      title2: 'Flat/House No.',
                      value2: 'L-1 First',
                      title3: 'Address',
                      value3:
                          "Sushant Lok 1, Near ABC, Gurugram, Haryana, 122018",
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
