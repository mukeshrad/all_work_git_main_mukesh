import 'package:finandy/constants/instances.dart';
import 'package:finandy/modals/customer.dart';
import 'package:finandy/screens/rootPageScreens/root_page.dart';
import 'package:finandy/utils/credit_card.dart';
import 'package:finandy/utils/main_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:swagger/api.dart';

import '../modals/card_schema.dart';

class CardActivation extends StatefulWidget {
  const CardActivation({ Key? key }) : super(key: key);

  @override
  _CardActivationState createState() => _CardActivationState();
}

class _CardActivationState extends State<CardActivation> {
  final formkey = GlobalKey<FormState>();
  bool isObscure = true;
  TextEditingController pinController = TextEditingController();
  TextEditingController confirmPinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(appBar: AppBar(), title: "Set Pin"),
      body: SingleChildScrollView(
         child: Container(
           height: MediaQuery.of(context).size.height*0.86,
           margin: const EdgeInsets.only(top: 20, bottom: 20, left: 15, right: 15),
           child: IntrinsicHeight(
             child: Column(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               mainAxisSize: MainAxisSize.max,
               children: [
                  UptrackCard(bankName: "${Provider.of<CardSchema>(context, listen: false).bankName}", cardNumber: "${Provider.of<CardSchema>(context, listen: false).cardNumber}", cardType: "${Provider.of<CardSchema>(context, listen: false).cardType}", expiry: "${Provider.of<CardSchema>(context, listen: false).expiry}",ownerName: "${Provider.of<CardSchema>(context, listen: false).ownerName}", cardNoTitle: "Card Number", monthlyLimit: "${Provider.of<CardSchema>(context, listen: false).limits!.monthly}"),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Form(
                        key: formkey,
                        child:  Column(
                          children: [
                            TextFormField(
                                    controller: pinController,
                                    keyboardType: TextInputType.number,
                                    autovalidateMode: AutovalidateMode.onUserInteraction,
                                    enabled: true,
                                    obscureText: isObscure,
                                    maxLength: 4,
                                    validator: (value) {
                                          if (value == null || value.length < 4) {
                                            return 'Required';
                                          }
                                          return null;
                                        },
                                    decoration: InputDecoration(
                                      hintText: "Enter 4 digit PIN",
                                      border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                      labelText: "Card PIN",   
                                      enabled: true,
                                      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                      suffixIcon: IconButton( onPressed: (){setState(() {
                                        isObscure = !isObscure;
                                      });}, icon: Icon( isObscure ? CupertinoIcons.eye_slash_fill : CupertinoIcons.eye,))  
                                    ),
                                  ),
                              const SizedBox(height: 10,),
                              TextFormField(
                                    controller: confirmPinController,
                                    keyboardType: TextInputType.number,
                                    autovalidateMode: AutovalidateMode.onUserInteraction,
                                    enabled: true,
                                    maxLength: 4,
                                    validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Required';
                                          }
                                          if(value != pinController.text){
                                            return 'Should be same as above';
                                          }
                                          return null;
                                        },
                                    decoration: const InputDecoration(
                                      hintText: "Confirm 4 digit PIN",
                                      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                      labelText: "Confirm Card PIN",   
                                      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),  
                                      enabled: true, 
                                    ),
                                  ),
                          ],
                        ),
                      ),
                      Container(
                          margin: const EdgeInsets.symmetric(vertical: 20),
                          child: ElevatedButton(onPressed: () async{
                            if( confirmPinController.text == "" || pinController.text == "" || confirmPinController.text != pinController.text){
                               return;
                            } else {
                              if(formkey.currentState!.validate()){
                                formkey.currentState!.save();
                                 try {
                                    String userId = Provider.of<Customer>(context, listen: false).userId  ??"";
                                    String cardId = Provider.of<CardSchema>(context, listen: false).id??"";
                                    print(userId);
                                    print(cardId);
                                    final cardIdBody = CardsIdBody.fromJson({
                                      "status": "Active",
                                      'pin': pinController.text,
                                      'preferences': context.read<CardSchema>().preference!.toJson()
                                    });
                                    // Todo: Should be merged into single call.
                                    await cardsApi.v1UsersUserIdCardsIdPut(userId, cardId, body: cardIdBody);
                                    final CardResponse res2 = await cardsApi.v1UsersUserIdCardsIdGet(userId, cardId);
                                    context.read<CardSchema>().setCardDetails(res2, "");
                                     Fluttertoast.showToast(
                                        msg: "Pin Set Successfull",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: const Color(0xff084E6C),
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const RootPage()));
                                 } catch (e) {
                                   print(e.toString());
                                 }
                               }
                              }
                            },
                             style: ElevatedButton.styleFrom(
                               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(12.0),
                              child: Text("Verify and Submit", style: TextStyle(fontSize: 20),),
                            ) 
                       ),
                    ),
                    ],
                  ),
               ],
             ),
           ),
         ) 
        ),
    );
  }
}