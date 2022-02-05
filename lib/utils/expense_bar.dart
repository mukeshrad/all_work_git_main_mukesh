import 'package:flutter/material.dart';

class ExpenseBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPctOfTotal;
  final Color color;
  final double height;
  final bool border;

  const ExpenseBar({
    Key? key,
    required this.label,
    required this.spendingAmount,
    required this.height,
    required this.spendingPctOfTotal,
    required this.color,
    required this.border,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      // width: 60,
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              border:
                  border ? Border.all(color: Colors.grey, width: 1.0) : null,
              color: const Color.fromRGBO(220, 220, 220, 1),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          FractionallySizedBox(
            widthFactor: spendingPctOfTotal,
            child: Container(
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
