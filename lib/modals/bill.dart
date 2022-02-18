import 'package:flutter/material.dart';

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

  setBill(json){
     userId = json['user_id'];
      startDate =  json['start_date'] == null
          ? null
          : DateTime.parse(json['start_date'] as String);
      endDate = json['end_date'] == null
          ? null
          : DateTime.parse(json['end_date'] as String);
      amount = json['amount'] == null ? 0 : (json['amount'] as double);
      currency = json['currency'] as String?;
      dueDate = json['due_date'] == null
          ? null
          : DateTime.parse(json['due_date'] as String);
      status = json['status'] as String?;
      transactionIds = json['transaction_ids'] == null ? List.empty() : (json['transaction_ids'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList();
      pdfPath = json['pdf_path'] as String?;
      isMailSent = json['is_mail_sent'] as bool?;

      notifyListeners();
  }

  @override
  String toString() {
    return 'BillSchema(userId: $userId, startDate: $startDate, endDate: $endDate, amount: $amount, currency: $currency, dueDate: $dueDate, status: $status, transactionIds: $transactionIds, pdfPath: $pdfPath, isMailSent: $isMailSent)';
  }
}
