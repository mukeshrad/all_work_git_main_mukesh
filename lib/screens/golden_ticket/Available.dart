import 'package:finandy/modals/customer.dart';
import 'package:finandy/screens/golden_ticket/share_with_friends.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:swagger/api.dart';

import '../../constants/instances.dart';
import '../profile/profile.dart';

class AvailableGoldenTicket extends StatefulWidget {
  const AvailableGoldenTicket({Key? key}) : super(key: key);

  @override
  _AvailableGoldenTicketState createState() => _AvailableGoldenTicketState();
}

class _AvailableGoldenTicketState extends State<AvailableGoldenTicket> {
  late Future<List<GoldenTicketResponse>?> goldenTickets;
  Future<List<GoldenTicketResponse>?> getGoldenTicket() async {
    return await goldenTicketApi.v1userGoldenTicketGet(
            '${Provider.of<Customer>(context, listen: false).userId}') ??
        List.empty();
  }

  @override
  void initState() {
    goldenTickets = getGoldenTicket();
    // getdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 30.0,
        vertical: 10.0,
      ),
      child:
          // FutureBuilder<List<GoldenTicketResponse>?>(
          //   future: goldenTickets,
          //   builder: (context, snapshot) {
          //     if (snapshot.data == null) {
          //       return const Center(
          //         child: Text(
          //           "Ohh Snap, reload the Page",
          //           style: TextStyle(
          //             fontWeight: FontWeight.w500,
          //             fontSize: 16.0,
          //           ),
          //           textAlign: TextAlign.center,
          //         ),
          //       );
          //     }
          //     switch (snapshot.connectionState) {
          //       case ConnectionState.none:
          //         return const Center(child: Text("Oh"));
          //       case ConnectionState.active:
          //       case ConnectionState.waiting:
          //         return const Center(child: CircularProgressIndicator());
          //       case ConnectionState.done:
          //         if (snapshot.data!.isEmpty) {
          //           return const Center(
          //             child: Text(
          //               "Looks Like you don't have any Golden Ticket that you can share with your friends",
          //               textAlign: TextAlign.center,
          //               style: TextStyle(
          //                 fontWeight: FontWeight.w500,
          //                 fontSize: 16.0,
          //               ),
          //             ),
          //           );
          //         }
          //
          //         return ListView.builder(
          //             itemCount: snapshot.data!.length,
          //             itemBuilder: (context, index) {
          //               if (snapshot.data![index].assignedTo!.name == null ||
          //                   snapshot.data![index].assignedTo!.name == '') {
          //                 return Container();
          //               } else {
          //                 return buildCard(
          //                   cardNo: '${snapshot.data![index].ticketNumber}',
          //                   valid_Date: '06/30',
          //                   onTapShare: () {
          //                     sendToScreen(
          //                       page: ShareWithFriendsScreen(
          //                         goldenTicketId: snapshot.data![index].id,
          //                       ),
          //                       buildContext: context,
          //                     );
          //                   },
          //                   showShareButton: true,
          //                 );
          //               }
          //             });
          //       default:
          //         return Text("Oops");
          //     }
          //   },
          // ),
          ListView(
        children: [
          buildCard(
            cardNo: '12345689789789',
            valid_Date: '06/30',
            onTapShare: () {
              sendToScreen(
                page: const ShareWithFriendsScreen(
                  goldenTicketId: '123564545465',
                ),
                buildContext: context,
              );
            },
            showShareButton: true,
          ),
        ],
      ),
    );
  }
}

Container buildCard(
    {required String cardNo,
    required String valid_Date,
    required VoidCallback onTapShare,
    bool? showShareButton}) {
  return Container(
    padding: const EdgeInsets.symmetric(
      horizontal: 20.0,
      vertical: 24.0,
    ),
    // height: 213.0,
    decoration: BoxDecoration(
      color: const Color(0xffFAFAFA),
      borderRadius: BorderRadius.circular(20.0),
      image: const DecorationImage(
        image: AssetImage(
          'assets/images/ticket_background.png',
        ),
        fit: BoxFit.fill,
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.shade300,
          offset: const Offset(0.0, 5.0),
          blurRadius: 30.0,
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Golden Ticket',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 17.0,
              ),
            ),
            SvgPicture.asset(
              "assets/images/black_logo.svg",
            ),
          ],
        ),
        const SizedBox(
          height: 18.0,
        ),
        const Text(
          'Golden Ticket Number',
          style: TextStyle(
            color: Color(0xff5C5C5C),
            fontSize: 17.0,
          ),
        ),
        const SizedBox(
          height: 6.0,
        ),
        Text(
          cardNo,
          style: const TextStyle(
            color: Color(0xff084E6C),
            letterSpacing: 3.0,
            fontSize: 19.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(
          height: 24.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildDetailsBlock(valid_Date),
            showShareButton == true
                ? InkWell(
                    onTap: onTapShare,
                    child: Container(
                      padding: const EdgeInsets.all(9.0),
                      decoration: BoxDecoration(
                          color: Color(0xff084E6C),
                          borderRadius: BorderRadius.circular(7.0)),
                      child: const Text(
                        'Share With Friend',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ],
    ),
  );
}

_buildDetailsBlock(String value) {
  return Row(
    // crossAxisAlignment: CrossAxisAlignment.end,
    mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget>[
      Column(
        children: [
          Text(
            "Valid".toUpperCase(),
            style: const TextStyle(
              color: Color(0xff5C5C5C),
              fontSize: 12.0,
            ),
          ),
          const SizedBox(
            height: 5.0,
          ),
          Text(
            "Thru".toUpperCase(),
            style: const TextStyle(
              color: Color(0xff5C5C5C),
              fontSize: 12.0,
            ),
          ),
        ],
      ),
      const SizedBox(
        width: 9.0,
      ),
      const Text(
        "▶",
        style: TextStyle(
          color: Color(0xff5C5C5C),
          fontSize: 13,
        ),
      ),
      const SizedBox(
        width: 13.0,
      ),
      Text(
        value,
        style: const TextStyle(
          color: Color(0xff5C5C5C),
          letterSpacing: 2.0,
          fontWeight: FontWeight.w600,
          fontSize: 16.0,
        ),
      )
    ],
  );
}
