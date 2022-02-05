import 'package:flutter/material.dart';

class UptrackCard extends StatefulWidget {
  final String ownerName;
  final String cardType;
  final String bankName;
  final String cardNumber;
  final String expiry;
  const UptrackCard({
    Key? key,
    required this.ownerName,
    required this.cardType,
    required this.bankName,
    required this.cardNumber,
    required this.expiry,
  }) : super(key: key);

  @override
  _UptrackCardState createState() => _UptrackCardState();
}

class _UptrackCardState extends State<UptrackCard> {
    
    // late Image image1;
    // late Image image2;

    // @override
    // void didChangeDependencies() {
    //   precacheImage(image1.image, context);
    //   precacheImage(image2.image, context);
    //   super.didChangeDependencies();
    // }
  
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
      // color: color,
      margin: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        height: 200,
        decoration: BoxDecoration(
                  image:const DecorationImage(
                    image: AssetImage("assets/images/map.png"),
                    fit: BoxFit.cover,
                    //  colorFilter: ColorFilter.mode(Colors.white, BlendMode.dstATop),
                    opacity: 0.3
                  ),
                        borderRadius: BorderRadius.circular(20)
                      ),
        // padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 22.0, top: 10),
        child: Container(
          decoration:  BoxDecoration(
              gradient: const LinearGradient(
                        colors: [
                          Colors.black38, 
                          Colors.black87,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        stops: [0.5, 0.51],
                        tileMode: TileMode.clamp
                        ),
              borderRadius: BorderRadius.circular(20)          
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _buildLogosBlock(),
              Padding(
                padding: const EdgeInsets.only(top: 5.0, left: 7),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text("◀", 
                       style: TextStyle(
                         color: Colors.white,
                       ),
                    ),
                    Image.asset("assets/images/chip.png")
                  ],
                )
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 18, 
                    right: 18,
                    top: 20
                   ),
                 child: Text(widget.cardNumber,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 25,
                      wordSpacing: 10
                    ),
                 ),
                ),
              _buildDetailsBlock(widget.expiry),
              Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: Text(widget.ownerName.toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      letterSpacing: 1.5
                    ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // Build the top row containing logos
  _buildLogosBlock() {
    return Container(
      padding: const EdgeInsets.only(top: 18, left: 18, right: 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
         Text(widget.cardType.toUpperCase(), style: const TextStyle(
           letterSpacing: 2,
           color: Colors.white,
           fontWeight: FontWeight.bold
           ),
         ),
         Row(
           children: [
             Text(widget.bankName.toUpperCase(), 
              style: const TextStyle(
                letterSpacing: 2,
                color: Colors.white,
                fontWeight: FontWeight.bold
               ),
             ),
             const SizedBox(width: 5,),
             Image.asset(
               "assets/images/wifi.png",
                width: 10,
                height: 10,
                color: Colors.white,
              ),
           ],
         )
        ],
      ),
    );
  }

 _buildDetailsBlock(String value) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, right: 35),
      child: Row(
        // crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Column(
            children: [
              Text("Valid".toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 8,
                ),
              ),
              Text("Thru".toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 8,
                ),
              ),
            ],
          ),
         const Text("▶", 
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
             ), 
            ),
          Text(value,
           style: const TextStyle(
              color: Colors.white,
              fontSize: 10,
             ),
          )    
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _buildCreditCard(),
    );
  }
}