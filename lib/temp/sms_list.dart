import 'package:flutter/material.dart';
import 'package:sms_advanced/sms_advanced.dart';

class SmsInbox extends StatefulWidget {
  static String id = "sms" ;
  @override
  _SmsInboxState createState() => _SmsInboxState();
}

class _SmsInboxState extends State<SmsInbox> {
  SmsQuery query = new SmsQuery();
  List<SmsMessage> messages= <SmsMessage>[];
  @override
  initState()  {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text("SMS Inbox"),
          backgroundColor: Colors.pink,
        ),
        body: FutureBuilder(
          future: fetchSMS() ,
          builder: (context, snapshot)  {

            return ListView.separated(
                separatorBuilder: (context, index) => Divider(
                  color: Colors.black,
                ),
                itemCount: messages.length,
                itemBuilder: (context,index){
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      leading: Icon(Icons.markunread,color: Colors.pink,),
                      subtitle: Text(messages[index].body!,maxLines:2,style: TextStyle(),),
                      title: Text(messages[index].address!),
                    ),
                  );
                });
          },)
    );
  }

  fetchSMS()
  async {
    messages = await query.getAllSms;
  }
}