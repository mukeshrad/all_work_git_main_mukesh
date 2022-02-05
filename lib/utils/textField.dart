import 'package:flutter/material.dart';

class Textfield extends StatelessWidget {
  final String labelText;
  final String initialText;
  const Textfield(
      {Key? key, required this.labelText, required this.initialText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25.0),
      child: Container(
        decoration: BoxDecoration(
            color: const Color(0xffEBEBEB),
            borderRadius: BorderRadius.circular(8.0)),
        child: TextFormField(
          // controller: _nameController,
          initialValue: initialText,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
          ),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            labelText: labelText,
          ),
        ),
      ),
    );
  }
}
