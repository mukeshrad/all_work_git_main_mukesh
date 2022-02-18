import 'package:finandy/constants/texts.dart';
import 'package:finandy/utils/widget_wrapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UnbilledTransaction extends StatefulWidget {
  const UnbilledTransaction({ Key? key }) : super(key: key);

  @override
  _UnbilledTransactionState createState() => _UnbilledTransactionState();
}

class _UnbilledTransactionState extends State<UnbilledTransaction> {

  createUnbilledTile(int index){
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
                      Text("Shri Ram Dhaba",
                       style: const TextStyle(
                         fontSize: 19,
                         fontWeight: FontWeight.w800,
                       ),
                      ),
                     Row(
                       children: [
                          Text("Trans Id: ",
                           style: const TextStyle(
                             color: Colors.black87
                           ),
                          ),
                          Text("2121255wd",
                           style: const TextStyle(
                             color: Colors.black54,
                             fontWeight: FontWeight.w700
                           ), 
                          )
                       ],
                     )
                    ],
                  ),
                  trailing: Text("+"+"4000",
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
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Colors.black
        ),
        title: const Text( unbilledTrans, style: TextStyle(
          color: Colors.black
        ),),
        automaticallyImplyLeading: true,
      ),
      body: ListView.builder(
        itemCount: 6,
        itemBuilder: (context, index) {
          return createUnbilledTile(index);
        }
        ),
    );
  }
}