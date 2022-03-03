import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:swagger/api.dart';

class BillSchema with ChangeNotifier {
  String? userId;
  DateTime? startDate;
  DateTime? endDate;
  double amount;
  String? currency;
  DateTime? dueDate;
  String? status;
  List<String>? transactionIds;
  String? pdfPath;
  bool? isMailSent;
  BillSchema({
    this.userId,
    this.startDate,
    this.endDate,
    required this.amount,
    this.currency,
    this.dueDate,
    this.status,
    this.transactionIds,
    this.pdfPath,
    this.isMailSent,
  });

  setBill(BillResponse bill) {
    print('Setting bill with $bill');
    userId = bill.userId;
    startDate = bill.startDate;
    endDate = bill.endDate;
    amount = bill.amount ?? 0;
    currency = bill.currency;
    dueDate = bill.dueDate;
    status = bill.status;
    transactionIds = bill.transactionIds;
    pdfPath = bill.pdfPath;
    isMailSent = bill.isMailSent;

    notifyListeners();
  }

  getDueDateFormatted(){
    final DateFormat formatter = DateFormat('MMM-dd');
    return dueDate == null ? "--" : formatter.format(dueDate!);
  }

  @override
  String toString() {
    return 'BillSchema(userId: $userId, startDate: $startDate, endDate: $endDate, amount: $amount, currency: $currency, dueDate: $dueDate, status: $status, transactionIds: $transactionIds, pdfPath: $pdfPath, isMailSent: $isMailSent)';
  }
}
