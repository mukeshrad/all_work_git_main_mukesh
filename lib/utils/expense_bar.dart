import 'dart:math';

import 'package:flutter/material.dart';

class ExpenseBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double? spendingPctOfTotal;
  final Color color;
  final Color? barColor;
  final double height;
  final Color? backGroundColor;
  final bool border;

  const ExpenseBar({
    Key? key,
    required this.label,
    required this.spendingAmount,
    required this.height,
    required this.spendingPctOfTotal,
    required this.color,
    required this.border,
    this.backGroundColor,
    this.barColor,
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
              color: backGroundColor ?? const Color.fromRGBO(220, 220, 220, 1),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          FractionallySizedBox(
            widthFactor: spendingPctOfTotal ?? 0.4,
            child: barColor != null
                ? Container(
                    decoration: BoxDecoration(
                      color: barColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  )
                : Container(
                    decoration: BoxDecoration(
                      // color: color,
                      gradient: const LinearGradient(
                        colors: [Colors.red, Colors.pinkAccent],
                        tileMode: TileMode.clamp,
                        transform: GradientRotation(pi / 4),
                        begin: Alignment(-1.0, -2.0),
                        end: Alignment(1.0, 2.0),
                        stops: [
                          0.2,
                          0.5,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
