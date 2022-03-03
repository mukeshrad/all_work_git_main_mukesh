import 'package:flutter/material.dart';
import 'package:swagger/api.dart';

class CardSchema with ChangeNotifier {
  String? id;
  String? ownerName;
  String? cardType;
  String? bankName;
  String? cardNumber;
  String? expiry;
  DateTime? expiryDate;
  String? userId;

  String? accountId;

  String? currency;

  double? billAmount;

  DateTime? dueDate;

  String? status;

  String? type;

  double? unbilledAmount;

  bool? isPinSet;

  CardLimits? limits;

  CardPreference? preference;
  CardSchema({
    this.id,
    this.ownerName,
    this.cardType,
    this.bankName,
    this.cardNumber,
    this.expiry,
    this.expiryDate,
    this.userId,
    this.accountId,
    this.currency,
    this.billAmount,
    this.dueDate,
    this.status,
    this.type,
    this.unbilledAmount,
    this.isPinSet,
    this.limits,
    this.preference,
  });

  getDateFormated(DateTime? t){
    int monthNo = t!.month; 
    String month = monthNo < 10 ? "0$monthNo" : "$monthNo";   
    String y = t.year.toString();
    String year = y.substring(y.length-2);

    String fex = "$month/$year";
    return fex;
  }

  setCardDetails(CardResponse card, [String? name]){
    print('Setting Cards provider with ${card.toJson()}');
    id = card.id;
    accountId = card.accountId;
    isPinSet = card.isPinSet;
    ownerName = ownerName??name;
    expiryDate = card.expiryDate;
    limits = card.limits;
    cardType = card.type;
    // unbilledAmount = card.unbilledAmount;
    // dueDate = card.d;
    bankName = "Bank Name";
    expiry = getDateFormated(expiryDate!);
    cardNumber = card.cardNumber;
    currency = card.currency;
    preference = card.prefrence;

    notifyListeners();
  }

  @override
  String toString() {
    return 'CardSchema(id: $id, ownerName: $ownerName, cardType: $cardType, bankName: $bankName, cardNumber: $cardNumber, expiry: $expiry, expiryDate: $expiryDate, userId: $userId, accountId: $accountId, currency: $currency, billAmount: $billAmount, dueDate: $dueDate, status: $status, type: $type, unbilledAmount: $unbilledAmount, isPinSet: $isPinSet, limits: $limits, preference: $preference)';
  }
}
