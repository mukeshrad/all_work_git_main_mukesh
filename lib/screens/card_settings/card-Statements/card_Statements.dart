import 'package:finandy/screens/card_settings/card-Statements/month_Transaction_HIstory.dart';
import 'package:finandy/utils/appBar.dart';
import 'package:finandy/utils/dropDown.dart';
import 'package:flutter/material.dart';

class CardStatements extends StatefulWidget {
  const CardStatements({Key? key}) : super(key: key);

  @override
  _CardStatementsState createState() => _CardStatementsState();
}

class _CardStatementsState extends State<CardStatements> {
  String initial_year = "2021";
  final List<String> _occupation = ['2021', '2022', 'Rented'];
  bool isEdit = false;

  void onChanged(String value) {
    setState(() => isEdit = true);
  }

  // Future getData() async {
  //   try {
  //     SharedPreferences preferences = await SharedPreferences.getInstance();
  //     Object? token = preferences.get("token");
  //     apiClient.setAccessToken(token as String);
  //     print(
  //         '${Provider.of<Customer>(context, listen: false).clientCustomerId}');
  //     var r = await cardsApi.v1UsersUserIdCardsGet(
  //         Provider.of<Customer>(context, listen: false).clientCustomerId!);
  //     var cardId = r?.id;
  //     print('is it $cardId');
  //     var ru = await transactionInstance.v1CardsCardIdTransactionsGet(cardId!);
  //     for (int i = 0; i < ru!.length; i++) {
  //       var detail = ru[i];
  //       _list.add(
  //         TransactionHistoryTile(
  //           amount: detail.amount.toString(),
  //           transactionId: detail.transactionId.toString(),
  //           callback: () {
  //             // getData();
  //             buildShowModalBottomSheet(
  //               context: context,
  //               personName: detail.merchantCategoryCode.toString(),
  //               transactionId: detail.transactionId.toString(),
  //               amount: detail.amount.toString(),
  //               date: detail.paymentCompletionTime.toString(),
  //               time: detail.paymentCompletionTime.toString(),
  //               location: 'Gurugram',
  //             );
  //           },
  //           personName: 'Shri Ram Dhaba',
  //         ),
  //       );
  //     }
  //
  //     //     .setCustomer(r?.toJson(), UserState.LoggedIn);
  //     // print(
  //     //     'we have ${Provider.of<Customer>(context, listen: false).customerName}');
  //
  //     // final data = result;*/
  //   } catch (e) {
  //     print("Exception when calling CardApi->v1UsersUserIdCardsGet: $e\n");
  //   }
  // }

  void onYearDropDownChanged(String? value) {
    setState(() {
      initial_year = value!;
      isEdit = true;
      print(value);
      print(initial_year);
    });
  }

  sendToscreen(var page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              NewAppBar(
                pageName: 'Card Statement',
                sufix: CustomDropDown(
                    value: initial_year,
                    list: _occupation,
                    onChanged: onYearDropDownChanged),
              ),
              SizedBox(
                height: 22.0,
              ),
              Expanded(
                child: ListView(
                  children: [
                    buildPdfCard(
                        monthName: 'January, 2021',
                        callback: () {
                          sendToscreen(MonthTransactionHistory());
                        }),
                    buildPdfCard(monthName: 'January, 2021', callback: () {}),
                    buildPdfCard(monthName: 'January, 2021', callback: () {}),
                    buildPdfCard(monthName: 'January, 2021', callback: () {}),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container buildPdfCard({
    required String monthName,
    required VoidCallback callback,
  }) {
    return Container(
      margin: EdgeInsets.only(
        top: 8.0,
        bottom: 8.0,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(7.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            offset: const Offset(0.0, 5.0),
            blurRadius: 30.0,
          ),
        ],
      ),
      child: ListTile(
        onTap: callback,
        leading: Image.network(
          'https://upload.wikimedia.org/wikipedia/commons/thumb/4/42/Adobe_Acrobat_DC_logo_2020.svg/2123px-Adobe_Acrobat_DC_logo_2020.svg.png',
          height: 30.0,
        ),
        title: Text(
          monthName,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios_outlined,
          color: Color(0xff323232),
          size: 18.0,
        ),
      ),
    );
  }
}
