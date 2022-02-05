import 'package:flutter/material.dart';

class UsedButton extends StatelessWidget {
  final String buttonName;
  final VoidCallback onpressed;
  const UsedButton({
    Key? key,
    required this.buttonName,
    required this.onpressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onpressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Color(0xff818181)),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
        child: Center(
          child: Text(
            buttonName,
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18.0),
          ),
        ),
      ),
    );
  }
}
