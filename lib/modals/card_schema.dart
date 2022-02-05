import 'package:flutter/material.dart';

class CreditCardLimits {
  int? daily;
  int? yearly;
  int? weekly;
  CreditCardLimits(this.daily, this.weekly, this.yearly);

  static CreditCardLimits? fromJson(Map<String, dynamic> json) {
   return CreditCardLimits(
      json['Daily'] as int?,
      json['Weekly'] as int?,
      json['Yearly'] as int?,
    );
  }
}

class CreditCardPreference {
  bool? offlineEnabled;
  bool? onlineEnabled;

  CreditCardPreference(this.offlineEnabled, this.onlineEnabled);

  static CreditCardPreference? fromJson(Map<String, dynamic> json) {
    return CreditCardPreference(
      json['offline_enabled'] as bool,
      json['online_enabled'] as bool,
    );
  }


}

class CardSchema with ChangeNotifier {
  String? id;
  String? ownerName;
  String? cardType;
  String? bankName;
  String? cardNumber;
  String? expiry;
  DateTime? expiryDate;

  String? currency;

  CreditCardLimits? limits;

  CreditCardPreference? preference;

  CardSchema({
    this.ownerName,
    this.cardType,
    this.bankName,
    this.cardNumber,
    this.expiry,
  });

  getDateFormated(DateTime? t){
    int monthNo = t!.month; 
    String month = monthNo < 10 ? "0$monthNo" : "$monthNo";   
    String y = t.year.toString();
    String year = y.substring(y.length-2);

    String fex = "$month/$year";
    return fex;
  }

  setCardDetails({json, String? name}){
    // print(json.toString());
    id = json["_id"];
    ownerName = name;
    expiryDate = DateTime?.parse(json['expiry_date'] as String);
    limits = CreditCardLimits.fromJson(json['limits'] as Map<String, dynamic>);
    cardType = "Uptrack Card";
    bankName = "Bank Name";
    expiry = getDateFormated(expiryDate!);
    cardNumber = json["card_number"];
    currency = json["currency"];
    preference = CreditCardPreference.fromJson(json['prefrence'] as Map<String, dynamic>);

    notifyListeners();
  }
}
