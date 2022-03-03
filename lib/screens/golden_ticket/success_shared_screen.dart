import 'package:finandy/screens/rootPageScreens/root_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/usedButton.dart';

class TicketSharedSuccessFull extends StatefulWidget {
  final String name;
  final String phoneNo;
  const TicketSharedSuccessFull(
      {Key? key, required this.name, required this.phoneNo})
      : super(key: key);

  @override
  _TicketSharedSuccessFullState createState() =>
      _TicketSharedSuccessFullState();
}

class _TicketSharedSuccessFullState extends State<TicketSharedSuccessFull> {
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
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 30.0,
            vertical: 15.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  child: ListView(
                children: [
                  const SizedBox(
                    height: 75.0,
                  ),
                  buildImage(),
                  const SizedBox(
                    height: 30.0,
                  ),
                  buildSuccessfulText(),
                  const SizedBox(
                    height: 16.0,
                  ),
                  buildDiscription(),
                  const SizedBox(
                    height: 49.0,
                  ),
                  buildDetailsContainer(),
                ],
              )),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  buildShareButton(),
                  SizedBox(
                    height: 20.0,
                  ),
                  homeButton(),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  UsedButton buildShareButton() {
    return UsedButton(
      buttonName: const Center(
        child: Text(
          'Share Now',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18.0),
        ),
      ),
      onpressed: () {},
      prefix: const Padding(
        padding: EdgeInsets.only(right: 19.0),
        child: Icon(
          Icons.share,
          size: 18.0,
        ),
      ),
    );
  }

  OutlinedButton homeButton() {
    return OutlinedButton(
        style: ButtonStyle(
          side: MaterialStateProperty.all(
            BorderSide.lerp(
              const BorderSide(
                style: BorderStyle.solid,
                color: Color(0xff084E6C),
                width: 1.0,
              ),
              const BorderSide(
                style: BorderStyle.solid,
                color: Color(0xff084E6C),
                width: 1.0,
              ),
              1,
            ),
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          padding: MaterialStateProperty.all(const EdgeInsets.symmetric(
            vertical: 14.0,
          )),
        ),
        onPressed: () {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const RootPage()),
              (route) => false);
        },
        child: const Text(
          'Home',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w600,
          ),
        ));
  }

  Container buildDetailsContainer() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 30.0,
        vertical: 20.0,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(7.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            offset: const Offset(0.0, 5.0),
            blurRadius: 30.0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Details',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16.0,
            ),
          ),
          SizedBox(
            height: 16.0,
          ),
          Divider(),
          SizedBox(
            height: 20.0,
          ),
          buildDetailRow(
            title: 'Name',
            title_value: widget.name,
          ),
          SizedBox(
            height: 16.0,
          ),
          buildDetailRow(
            title: 'Phone No.',
            title_value: widget.phoneNo,
          ),
        ],
      ),
    );
  }

  Image buildImage() {
    return Image.asset(
      'assets/images/Check animation.gif',
      height: 100.0,
    );
  }

  Center buildDiscription() {
    return Center(
      child: Text(
        'Thank you for helping ${widget.name}\n on her Credit Journey',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w500,
          color: Color(0xff5C5C5C),
        ),
      ),
    );
  }

  Center buildSuccessfulText() {
    return Center(
      child: Text(
        'Successful!',
        style: TextStyle(
          fontSize: 29.0,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Row buildDetailRow({required String title, required String title_value}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Color(0xff5C5C5C),
            fontSize: 16.0,
          ),
        ),
        Text(
          ': $title_value',
          style: const TextStyle(
            color: Color(0xff323232),
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
