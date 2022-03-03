import 'package:finandy/modals/bill.dart';
import 'package:finandy/modals/card_schema.dart';
import 'package:finandy/utils/widget_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'expense_bar.dart';

class ExpensesCard extends StatefulWidget {
  const ExpensesCard({
    Key? key,
  }) : super(key: key);

  @override
  _ExpensesCardState createState() => _ExpensesCardState();
}

class _ExpensesCardState extends State<ExpensesCard> {
  late double availableLimit;
  late double limit;

  @override
  void initState() {
    super.initState();
     setState(() {
     
     });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
      availableLimit = Provider.of<BillSchema>(context, listen: false) != null ? (Provider.of<CardSchema>(context, listen: false).limits!.monthly!.toDouble() - Provider.of<BillSchema>(context, listen: false).amount as double) : 0;
      limit = Provider.of<CardSchema>(context, listen: false).limits!.monthly!.toDouble();
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      child: elevatedContainer(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 3),
                        child: const Text("Monthly Limit", 
                          style: TextStyle(
                            fontSize: 16
                          ),
                          )
                        ),
                      Text(
                            "₹ $limit",
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                    ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Container(
                       margin: const EdgeInsets.only(bottom: 3),
                       child: const Text(
                         "Available Monthly Limit",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                         )
                       ),
                     Text(
                        "₹ $availableLimit",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      )
                   ],
                ),
                ],
            ),
              ),
               ExpenseBar(
                label: "expense",
                spendingAmount: limit,
                spendingPctOfTotal: (limit == 0 ? 0 : availableLimit/limit),
                color: Colors.red,
                height: 15.0,
                border: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
