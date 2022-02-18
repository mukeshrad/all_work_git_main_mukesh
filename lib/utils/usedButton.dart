import 'package:flutter/material.dart';

class UsedButton extends StatelessWidget {
  final Widget buttonName;
  final VoidCallback onpressed;
  final Widget? prefix;
  const UsedButton({
    Key? key,
    required this.buttonName,
    required this.onpressed,
    this.prefix,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onpressed,
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        backgroundColor: MaterialStateProperty.all(Color(0xff084E6C)),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            prefix ?? Container(),
            buttonName,
          ],
        ),
      ),
    );
  }
}
