import 'package:finandy/screens/golden_ticket/share_with_friends.dart';
import 'package:flutter/material.dart';

class AvailableGoldenTicket extends StatefulWidget {
  const AvailableGoldenTicket({Key? key}) : super(key: key);

  @override
  _AvailableGoldenTicketState createState() => _AvailableGoldenTicketState();
}

class _AvailableGoldenTicketState extends State<AvailableGoldenTicket> {
  sendToscreen(var page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        buildCard(
            cardNo: '1234 5678 9012 3456',
            valid_Date: '06/30',
            onTapShare: () {
              sendToscreen(const ShareWithFriendsScreen());
            },
            showShareButton: true),
        buildCard(
          cardNo: '1234 5678 9012 3456',
          valid_Date: '06/30',
          onTapShare: () {
            sendToscreen(const ShareWithFriendsScreen());
          },
          showShareButton: true,
        ),
      ],
    );
  }
}

Container buildCard(
    {required String cardNo,
    required String valid_Date,
    required VoidCallback onTapShare,
    bool? showShareButton}) {
  return Container(
    margin: const EdgeInsets.all(30.0),
    padding: const EdgeInsets.symmetric(
      horizontal: 28.0,
      vertical: 22.0,
    ),
    height: 213.0,
    decoration: BoxDecoration(
        color: const Color(0xff393939),
        borderRadius: BorderRadius.circular(20.0),
        image:
            const DecorationImage(image: AssetImage('assets/images/map.png'))),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: const Text(
                'Golden Ticket',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
            ),
            showShareButton == true
                ? Flexible(
                    child: IconButton(
                      onPressed: onTapShare,
                      icon: const Icon(
                        Icons.share,
                        color: Colors.white,
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
        SizedBox(
          height: showShareButton == true ? 10.0 : 45.0,
        ),
        Text(
          cardNo,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(
          height: showShareButton == true ? 10.0 : 45.0,
        ),
        _buildDetailsBlock(valid_Date),
        Flexible(
          child: const SizedBox(
            height: 15.0,
          ),
        ),
        showShareButton == true
            ? InkWell(
                onTap: onTapShare,
                child: Container(
                  padding: const EdgeInsets.all(9.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(7.0)),
                  child: const Text(
                    'Share With Friend',
                    style: TextStyle(
                      color: Color(0xff141414),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              )
            : Container(),
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
              color: Colors.white,
              fontSize: 12.0,
            ),
          ),
          Text(
            "Thru".toUpperCase(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12.0,
            ),
          ),
        ],
      ),
      const Text(
        "▶",
        style: TextStyle(
          color: Colors.white,
          fontSize: 13,
        ),
      ),
      Text(
        value,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12.0,
        ),
      )
    ],
  );
}
