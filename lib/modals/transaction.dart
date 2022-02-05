class Transaction {
  String? merchantUpiId = "";
/* Bank account of merchant */
  String? merchantBankAccount = "";
/* IFSC code of merchant bank account */
  String? merchantIfscCode = "";
/* 4 digit MCC code assigned to the merchant */
  String? merchantCategoryCode = "";

  double? amount = null;

  Object? location = null;
}
