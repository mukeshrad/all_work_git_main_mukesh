import 'package:finandy/screens/Payment/Bil_Pay.dart';
import 'package:flutter/material.dart';

import 'expense_bar.dart';

class ExpensesCard extends StatefulWidget {
  const ExpensesCard({Key? key}) : super(key: key);

  @override
  _ExpensesCardState createState() => _ExpensesCardState();
}

class _ExpensesCardState extends State<ExpensesCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [Text("Total Card Limit"), Text("Dec 10, 2019")],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "₹ 4000.00",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  GestureDetector(
                      onTap: () {

                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => BilPay()));
                      },
                      child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.redAccent,
                              border: Border.all(
                                  color: Colors.redAccent,
                                  style: BorderStyle.solid),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5))),
                          child: const Text(
                            "Pay Bill",
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          )))
                ],
              ),
            ),
            const ExpenseBar(
              label: "expense",
              spendingAmount: 1000,
              spendingPctOfTotal: 0.4,
              color: Colors.red,
              height: 30.0,
              border: true,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text("Available Weekly Limit"),
                  Text("Payment Due")
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "₹ 1000.00",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    "₹ 500.00",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
