import 'package:finandy/constants/instances.dart';
import 'package:finandy/modals/bill.dart';
import 'package:finandy/modals/card_schema.dart';
import 'package:finandy/modals/customer.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:swagger/api.dart';

Future<void> fetchAndUpdateUserDetails(BuildContext context, String userId, UserState userState) async {
  final UserDetails userDetails = await userApi.v1UsersUserDetailsGet(userId);
  if (userDetails.user == null) {
    throw Exception('User is null in user details API');
  }
  Provider.of<Customer>(context, listen: false).setCustomer(
      userDetails.user!, userState);

  // If card is assigned to user, update card provider
  if (userDetails.cards != null && userDetails.cards!.isNotEmpty) {
    Provider.of<CardSchema>(context, listen: false).setCardDetails(
        userDetails.cards![0],
        userDetails.user!.customerName);
  }

  // If bill is assigned to user, update bill provider
  if (userDetails.bill != null) {
    Provider.of<BillSchema>(context, listen: false)
        .setBill(userDetails.bill!);
  }
}