import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swagger/api.dart';

import '../../constants/instances.dart';
import '../../modals/customer.dart';
import '../../utils/shared_Card.dart';

class SharedGoldenTicket extends StatefulWidget {
  const SharedGoldenTicket({Key? key}) : super(key: key);

  @override
  _SharedGoldenTicketState createState() => _SharedGoldenTicketState();
}

class _SharedGoldenTicketState extends State<SharedGoldenTicket> {
  late Future<List<GoldenTicketResponse>?> goldenTickets;
  Future<List<GoldenTicketResponse>?> getGoldenTicket() async {
    return await goldenTicketApi.v1userGoldenTicketGet(
            '${Provider.of<Customer>(context, listen: false).userId}') ??
        List.empty();
  }

  @override
  void initState() {
    goldenTickets = getGoldenTicket();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 30.0,
        vertical: 10.0,
      ),
      child: FutureBuilder<List<GoldenTicketResponse>?>(
        future: goldenTickets,
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return const Center(
              child: Text(
                "Ohh Snap, reload the Page",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16.0,
                ),
                textAlign: TextAlign.center,
              ),
            );
          }
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return const Center(child: Text("Oh"));
            case ConnectionState.active:
            case ConnectionState.waiting:
              return const Center(child: CircularProgressIndicator());
            case ConnectionState.done:
              if (snapshot.data!.isEmpty) {
                return const Center(
                  child: Text(
                    "Looks Like you haven't shared any Golden Ticket",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                );
              }

              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    if (snapshot.data![index].assignedTo!.name != null) {
                      return SharedCard(
                        profilePhoto: 'null',
                        personName: snapshot.data![index].assignedTo!.name,
                        validDate: 'Noc 30,2030',
                        phoneNo: snapshot.data![index].assignedTo!.phoneNumber,
                        refferedOnDate: '${snapshot.data![index].assignedAt}',
                        ticketStatus: snapshot.data![index].status,
                        creditScoreStatus: '--',
                        onTapShare: () {},
                        colorOfCreditScoreStatus: const Color(0xffFF5130),
                      );
                    } else {
                      return Container();
                    }
                  });
            default:
              return Text("Oops");
          }
        },
      ),
    );
    //   ListView(
    //   padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
    //   children: [
    //     SharedCard(
    //       profilePhoto: 'null',
    //       personName: 'Aditya Kumar',
    //       validDate: 'Noc 30,2021',
    //       phoneNo: '9876543210',
    //       refferedOnDate: 'Nov 26,2021-10:00 AM',
    //       ticketStatus: 'Redeemed',
    //       creditScoreStatus: 'Failed',
    //       onTapShare: () {},
    //       colorOfCreditScoreStatus: Color(0xffFF5130),
    //     ),
    //     SharedCard(
    //       profilePhoto: 'null',
    //       personName: 'Aditya singh',
    //       validDate: 'Nov 30,2022',
    //       phoneNo: '9876543212',
    //       refferedOnDate: 'Nov 26,2021-11:00 AM',
    //       ticketStatus: 'Pending',
    //       creditScoreStatus: '-',
    //       onTapShare: () {},
    //       colorOfCreditScoreStatus: Colors.black,
    //     ),
    //     SharedCard(
    //       profilePhoto: 'null',
    //       personName: 'Aditya singh',
    //       validDate: 'Nov 30,2022',
    //       phoneNo: '9876543212',
    //       refferedOnDate: 'Nov 26,2021-11:00 AM',
    //       ticketStatus: 'Pending',
    //       creditScoreStatus: 'Success',
    //       onTapShare: () {},
    //       colorOfCreditScoreStatus: Color(0xff05C46B),
    //     ),
    //   ],
    // );
  }
}
