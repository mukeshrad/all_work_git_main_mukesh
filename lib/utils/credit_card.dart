import 'dart:math';

import 'package:finandy/modals/bill.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class UptrackCard extends StatefulWidget {
  final String ownerName;
  final String cardType;
  final String bankName;
  final String cardNumber;
  final String expiry;
  final String cardNoTitle;
  final String monthlyLimit;
  const UptrackCard({
    Key? key,
    required this.monthlyLimit,
    required this.ownerName,
    required this.cardType,
    required this.bankName,
    required this.cardNumber,
    required this.expiry,
    required this.cardNoTitle,
  }) : super(key: key);

  @override
  _UptrackCardState createState() => _UptrackCardState();
}

class _UptrackCardState extends State<UptrackCard> {
  late SvgPicture logo;
  late double outstandingAmount;
  // late Image image2;

  @override
  void initState() {
    super.initState();
    logo = SvgPicture.asset(
      "assets/images/cardlogo.svg",
    );
    
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precachePicture(logo.pictureProvider, context);
    //  outstandingAmount = Provider.of<BillSchema>(context).amount == Null ? 0 : (double.parse(widget.monthlyLimit)- Provider.of<BillSchema>(context).amount!.toDouble());
  }

  buildTitleSection({title, subTitle}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0, top: 16.0),
          child: Text(
            '$title',
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0, bottom: 16.0),
          child: Text(
            '$subTitle',
            style: const TextStyle(fontSize: 21, color: Colors.black45),
          ),
        )
      ],
    );
  }

  // Build the credit card widget
  Card _buildCreditCard() {
    return Card(
      elevation: 5.0,
      // margin: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(20),
          color: Colors.black87,
        ),
        child: Stack(children: [
          Positioned(
            right: 100,
            top: -3,
            child: Transform.rotate(
              angle: pi / 4,
              child: Container(
                height: 210,
                width: 130,
                decoration: BoxDecoration(
                  color: Colors.black,
                  border: Border.all(color: Colors.black, width: 0.0),
                  borderRadius:
                      const BorderRadius.all(Radius.elliptical(200, 310)),
                ),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _buildLogosBlock(),
              Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.cardNoTitle,
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 18, 
                            right: 18,
                            top: 5
                           ),
                         child: Text(widget.cardNumber.substring(0, 4)+" "+widget.cardNumber.substring(4, 8)+" "+ widget.cardNumber.substring(8, 12)+" "+widget.cardNumber.substring(12),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 24,
                              wordSpacing: 10),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: _buildDetailsBlock(widget.expiry),
          )
        ]),
      ),
    );
  }

  // Build the top row containing logos
  _buildLogosBlock() {
    return Container(
      margin: const EdgeInsets.only(top: 18, left: 18, right: 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            widget.cardType,
            style: const TextStyle(
                letterSpacing: 2,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 18,
            width: 95,
            child: logo,
          )
        ],
      ),
    );
  }

  _buildDetailsBlock(String value) {
    return Container(
      height: 60,
      padding: const EdgeInsets.only(bottom: 15.0, left: 22, right: 22),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children:  [
             const Padding(
                padding: EdgeInsets.only(bottom: 2.0),
                child: Text(
                  "Total card limit",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                  ),
                ),
              ),
              Text(
                "₹ ${widget.monthlyLimit}",
                style:const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const VerticalDivider(
            thickness: 1,
            color: Colors.grey,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             const Padding(
                padding: EdgeInsets.only(bottom: 2.0),
                child: Text(
                  "Total Outstanding",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                  ),
                ),
              ),
              Text(
                "₹ $outstandingAmount",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    outstandingAmount = Provider.of<BillSchema>(context).amount == Null ? 0 : (double.parse(widget.monthlyLimit)- Provider.of<BillSchema>(context).amount);
    return Container(
      child: _buildCreditCard(),
    );
  }
}
