import 'package:flutter/material.dart';

class Choose extends StatelessWidget {
  const Choose({ Key? key, required this.func, required this.text }) : super(key: key);
  
  final Function func;
  final String text; 

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
              onPressed: () => func(),
              style: ElevatedButton.styleFrom(
                primary: Colors.black54,
                shape:  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                    text,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white
                    ),
                ),
              )
          ),
    );
  }
}