import 'package:finandy/utils/appBar.dart';
import 'package:flutter/material.dart';

import '../transaction_History.dart';

class MonthTransactionHistory extends StatefulWidget {
  const MonthTransactionHistory({Key? key}) : super(key: key);

  @override
  _MonthTransactionHistoryState createState() =>
      _MonthTransactionHistoryState();
}

class _MonthTransactionHistoryState extends State<MonthTransactionHistory> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              NewAppBar(
                pageName: 'January,2021',
                sufix: buildDownloadButton(),
              ),
              SizedBox(
                height: 22.0,
              ),
              TransactionHistoryTile(
                amount: '-4000',
                transactionId: '2321889w',
                callback: () {
                  buildShowModalBottomSheet(
                    context: context,
                    personName: 'Shri Ram Dhaba',
                    transactionId: '2321889w',
                    amount: 'Rs. 4000',
                    date: '01/12/2022',
                    time: '11:30 AM',
                    location: 'Gurugram',
                  );
                },
                personName: 'Shri Ram Dhaba',
              ),
            ],
          ),
        ),
      ),
    );
  }

  OutlinedButton buildDownloadButton() {
    return OutlinedButton(
      onPressed: () {},
      child: Row(
        children: const [
          Text(
            'Download PDF',
            style: TextStyle(
              fontSize: 12.0,
              color: Color(0xffFF5130),
            ),
          ),
          SizedBox(
            width: 5.0,
          ),
          Icon(
            Icons.download_sharp,
            size: 15,
            color: Color(0xffFF5130),
          ),
        ],
      ),
      style: ButtonStyle(
        side: MaterialStateProperty.all(
          BorderSide.lerp(
            const BorderSide(
              style: BorderStyle.solid,
              color: Color(0xffFF5130),
              width: 1.0,
            ),
            const BorderSide(
              style: BorderStyle.solid,
              color: Color(0xffFF5130),
              width: 1.0,
            ),
            1,
          ),
        ),
      ),
    );
  }
}
