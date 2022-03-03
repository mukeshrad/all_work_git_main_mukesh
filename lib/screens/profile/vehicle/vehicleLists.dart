import 'package:finandy/screens/profile/vehicle/vehicleInfo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../utils/appBar.dart';
import '../../../utils/detailsCard.dart';

class VehicleList extends StatefulWidget {
  const VehicleList({Key? key}) : super(key: key);

  @override
  _VehicleListState createState() => _VehicleListState();
}

class _VehicleListState extends State<VehicleList> {
  // late Future<List<GoldenTicketResponse>?> goldenTickets;
  // Future<List<DocumentResponse>?> getGoldenTicket() async {
  //   return await goldenTicketApi.v1userGoldenTicketGet(
  //       '${Provider.of<Customer>(context, listen: false).clientCustomerId}') ??
  //       List.empty();
  // }
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
            sendToscreen(const VehicleDetails());
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
                pageName: 'Vehicle Details',
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
                      showeye: true,
                      title1: 'Vehicle Type',
                      value1: 'DL223232000',
                      title2: 'RC',
                      value2: 'DL3SEH6162',
                      title3: 'Vehicle Number',
                      value3: 'Bike',
                    ),
                    DetailsCard(
                      onTapEdit: () {},
                      showeye: true,
                      title1: 'Vehicle Type',
                      value1: 'DL223232000',
                      title2: 'RC',
                      value2: 'DL3SEH6162',
                      title3: 'Vehicle Number',
                      value3: 'Car',
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
