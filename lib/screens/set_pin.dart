import 'package:finandy/constants/texts.dart';
import 'package:finandy/utils/credit_card.dart';
import 'package:flutter/material.dart';

class SetPin extends StatefulWidget {
  const SetPin({ Key? key }) : super(key: key);

  @override
  _SetPinState createState() => _SetPinState();
}

class _SetPinState extends State<SetPin> {

   bool _showPassword = false;

  TextEditingController _passwordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();
  void _togglevisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(setPin),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
                const UptrackCard(bankName: "Bank Name", cardNumber: "1212 1212 1212 1212", cardType: "Card Type", expiry: "02/26",ownerName: "Shivam",),
               Column(
                 children: [
                   TextFormField(
                  controller: _passwordController,
                  obscureText: !_showPassword,
                  decoration: InputDecoration(
                    labelText: "$pin*",
                    hintText: pin,
                    // border: InputBorder.none,
                    suffixIcon: GestureDetector(
                      onTap: () {
                        _togglevisibility();
                      },
                      child: Icon(
                        _showPassword ? Icons.visibility : Icons
                            .visibility_off, color: Colors.grey,),
                    ),
                  ),
                ),
                const SizedBox(height: 5,),
                TextFormField(
                  controller: confirmpasswordController,
                  decoration: InputDecoration(
                    labelText: "$confirmPin*",
                    hintText: confirmPin,
                    // border: InputBorder.none,
                  ),
                ),
                Container(
                    margin: const EdgeInsets.only(top: 15),
                    child: ElevatedButton(onPressed: (){},
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:  [
                            Text(check, style: const TextStyle(fontSize: 20),),
                           const SizedBox(width: 10,),
                            const Icon(Icons.arrow_forward_sharp)
                          ],
                        ),
                      ) 
                    ),
                  ),
                 ],
               )
             ],
          ),
        ),
      ),
    );
  }
}