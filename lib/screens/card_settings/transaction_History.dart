import 'package:finandy/constants/instances.dart';
import 'package:finandy/modals/card_schema.dart';
import 'package:finandy/utils/appBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swagger/api.dart';

class TransactionHistory extends StatefulWidget {
  const TransactionHistory({Key? key}) : super(key: key);

  @override
  _TransactionHistoryState createState() => _TransactionHistoryState();
}

class _TransactionHistoryState extends State<TransactionHistory> {
  List<TransactionHistoryTile> _list = [];

  Future getData() async {
    print('Transaction history Screen');
    try {
      String cardId = Provider.of<CardSchema>(context, listen: false).id!;
      print('Card ID: $cardId');
      UserTransactionList transactionList = await transactionApi.v1CardsCardIdTransactionsGet(cardId);
      print('result is $transactionList');
      for (int i = 0; i < transactionList.transactions.length; i++) {
        UserTransaction transaction = transactionList.transactions[i];
        _list.add(
          TransactionHistoryTile(
            amount: transaction.amount.toString(),
            transactionId: transaction.id,
            callback: () {
              // getData();
              buildShowModalBottomSheet(
                context: context,
                personName: transaction.merchantCategoryCode.toString(),
                transactionId: transaction.id,
                amount: transaction.amount.toString(),
                date: transaction.paymentCompletionTime.toString(),
                time: transaction.paymentCompletionTime.toString(),
                location: 'Gurugram',
              );
            },
            personName: 'Shri Ram Dhaba',
          ),
        );
      }
      //     .setCustomer(r?.toJson(), UserState.LoggedIn);
      // print(
      //     'we have ${Provider.of<Customer>(context, listen: false).customerName}');

      // final data = result;*/
    } catch (e) {
      print("Exception when calling CardApi->v1CardsCardIdTransactionsGet: $e\n");
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              NewAppBar(pageName: 'Transaction History'),
              SizedBox(
                height: 29.0,
              ),
              Expanded(child: ListView(children: _list)),
            ],
          ),
        ),
      ),
    );
  }
}

class TransactionHistoryTile extends StatelessWidget {
  final VoidCallback callback;
  final String personName;
  final String transactionId;
  final String amount;
  const TransactionHistoryTile({
    Key? key,
    required this.callback,
    required this.personName,
    required this.transactionId,
    required this.amount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: ListTile(
        onTap: callback,
        leading: CircleAvatar(
          backgroundColor: Colors.blueGrey,
        ),
        title: Text(
          personName,
          style: TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Text.rich(
          TextSpan(
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w500,
              ),
              text: 'Trans Id : ',
              children: [
                TextSpan(text: transactionId),
              ]),
        ),
        trailing: Text(
          amount,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
            color: Color(0xffFF5130),
          ),
        ),
        tileColor: Colors.white,
      ),
    );
  }
}

buildShowModalBottomSheet({
  required BuildContext context,
  required String personName,
  required String transactionId,
  required String amount,
  required String date,
  required String time,
  required String location,
}) {
  return showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return Wrap(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25.0),
                  topRight: Radius.circular(25.0),
                ),
              ),
              child: StatefulBuilder(
                builder: (BuildContext context, StateSetter setModalState) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30.0,
                      vertical: 21.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.0),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade300,
                                  offset: const Offset(0.0, 5.0),
                                  blurRadius: 30.0,
                                ),
                              ],
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(5.0),
                              child: Icon(
                                Icons.keyboard_arrow_down_outlined,
                              ),
                            ),
                          ),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                        const SizedBox(
                          height: 14.0,
                        ),
                        Text(
                          personName,
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 18.0,
                            color: Color(0xff323232),
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        const Text(
                          'Transaction Details',
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff323232),
                          ),
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        const Divider(
                          color: Color(0xffF2F2F2),
                          thickness: 1,
                          // indent: 50.0,
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        buildRow(
                            title: 'Transaction ID', detail: transactionId),
                        const SizedBox(
                          height: 16.0,
                        ),
                        buildRow(title: 'Amount', detail: amount),
                        const SizedBox(
                          height: 16.0,
                        ),
                        buildRow(title: 'Date', detail: date),
                        const SizedBox(
                          height: 16.0,
                        ),
                        buildRow(title: 'Time', detail: time),
                        const SizedBox(
                          height: 16.0,
                        ),
                        buildRow(title: 'Location', detail: location),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        );
      });
}

Row buildRow({required String title, required String detail}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        title,
        style: TextStyle(color: Color(0xff5C5C5C), fontSize: 14.0),
      ),
      Text(
        detail,
        style: TextStyle(
          color: Color(0xff323232),
          fontSize: 14.0,
          fontWeight: FontWeight.w500,
        ),
      ),
    ],
  );
}
