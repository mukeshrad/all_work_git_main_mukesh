import 'package:finandy/utils/shared_Card.dart';
import 'package:flutter/material.dart';

class SharedGoldenTicket extends StatefulWidget {
  const SharedGoldenTicket({Key? key}) : super(key: key);

  @override
  _SharedGoldenTicketState createState() => _SharedGoldenTicketState();
}

class _SharedGoldenTicketState extends State<SharedGoldenTicket> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
      children: [
        SharedCard(
          profilePhoto: 'null',
          personName: 'Aditya Kumar',
          validDate: 'Noc 30,2021',
          phoneNo: '9876543210',
          refferedOnDate: 'Nov 26,2021-10:00 AM',
          ticketStatus: 'Redeemed',
          creditScoreStatus: 'Failed',
          onTapShare: () {},
          colorOfCreditScoreStatus: Color(0xffFF5130),
        ),
        SharedCard(
          profilePhoto: 'null',
          personName: 'Aditya singh',
          validDate: 'Nov 30,2022',
          phoneNo: '9876543212',
          refferedOnDate: 'Nov 26,2021-11:00 AM',
          ticketStatus: 'Pending',
          creditScoreStatus: '-',
          onTapShare: () {},
          colorOfCreditScoreStatus: Colors.black,
        ),
        SharedCard(
          profilePhoto: 'null',
          personName: 'Aditya singh',
          validDate: 'Nov 30,2022',
          phoneNo: '9876543212',
          refferedOnDate: 'Nov 26,2021-11:00 AM',
          ticketStatus: 'Pending',
          creditScoreStatus: 'Success',
          onTapShare: () {},
          colorOfCreditScoreStatus: Color(0xff05C46B),
        ),
      ],
    );
  }
}
