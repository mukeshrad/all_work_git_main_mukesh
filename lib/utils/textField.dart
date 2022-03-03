import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Textfield extends StatelessWidget {
  final String labelText;
  final TextInputType? textInputType;
  final TextEditingController controller;
  final Widget? prefix;
  final void Function(String value)? onChanged;
  final int? noOfAlphabets;

  const Textfield({
    Key? key,
    required this.labelText,
    this.textInputType,
    required this.controller,
    this.prefix,
    this.onChanged,
    this.noOfAlphabets,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: const Color(0xffEBEBEB),
          borderRadius: BorderRadius.circular(8.0)),
      child: TextFormField(
        inputFormatters: noOfAlphabets == null
            ? null
            : [
                LengthLimitingTextInputFormatter(noOfAlphabets),
              ],
        keyboardType: textInputType,
        controller: controller,
        onChanged: onChanged,
        // initialValue: initialText,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          prefix: prefix,
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          labelText: labelText,
        ),
      ),
    );
  }
}
