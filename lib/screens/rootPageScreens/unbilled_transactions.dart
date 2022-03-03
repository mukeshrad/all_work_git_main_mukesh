import 'package:finandy/constants/instances.dart';
import 'package:finandy/constants/texts.dart';
import 'package:finandy/modals/card_schema.dart';
import 'package:finandy/utils/widget_wrapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swagger/api.dart';

class UnbilledTransaction extends StatefulWidget {
  const UnbilledTransaction({ Key? key }) : super(key: key);

  @override
  _UnbilledTransactionState createState() => _UnbilledTransactionState();
}

class _UnbilledTransactionState extends State<UnbilledTransaction> {
   late Future<UserTransactionList> transactions;
   @override
   void initState(){
     super.initState();
     transactions = getTransaction();
   }

   Future<UserTransactionList> getTransaction() async{
       final cardId = Provider.of<CardSchema>(context, listen: false).id;
       return transactionApi.v1CardsCardIdTransactionsGet(cardId!);
   }

  createUnbilledTile(UserTransaction transaction){
     return Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      child: elevatedContainer(
        child: ListTile(
                  leading: CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.grey[200],
                    child: const Icon(CupertinoIcons.gift, color: Colors.red),
                  ),
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(transaction.description ?? transaction.upiId,
                       style: const TextStyle(
                         fontSize: 19,
                         fontWeight: FontWeight.w800,
                       ),
                      ),
                     Row(
                       children: [
                          const Text("Id: ",
                           style: TextStyle(
                             color: Colors.black87
                           ),
                          ),
                          Text("${transaction.id}".substring(6),
                           style: const TextStyle(
                             color: Colors.black54,
                             fontWeight: FontWeight.w700
                           ), 
                          )
                       ],
                     )
                    ],
                  ),
                  trailing: Text((transaction.isCredit == true ? "+" : "-")+"${transaction.amount}",
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 19
                    ),
                  ),
                ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(
          color: Colors.black
        ),
        title: const Text( transactionHistoryScreenTitle, style: TextStyle(
          color: Colors.black
        ),),
        automaticallyImplyLeading: true,
      ),
      body: FutureBuilder<UserTransactionList>(
        future: transactions,
        builder: (context, snapshot) {
          switch (snapshot.connectionState){
            case ConnectionState.none:
              return const Center(child: Text("Oh"));
            case ConnectionState.active:
            case ConnectionState.waiting:
              return  const Center(child: CircularProgressIndicator());   
            case ConnectionState.done:
              if(snapshot.data == null || snapshot.data!.transactions.isEmpty){
                return const Center(child: Text("Oh Snap! No transactions yet"),);
              }
              return ListView.builder(
                itemCount: snapshot.data!.transactions.length,
                itemBuilder: (context, index) {
                  return createUnbilledTile(snapshot.data!.transactions[index]);
                } 
              );
            default:
              return Text("Oops");    
          } 
      },)
    );
  }
}