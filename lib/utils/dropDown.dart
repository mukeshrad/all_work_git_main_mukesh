import 'package:flutter/material.dart';

class CustomDropDown extends StatelessWidget {
  final String value;
  final List<String> list;
  final void Function(String? value)? onChanged;
  const CustomDropDown(
      {Key? key, required this.value, required this.list, this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      decoration: BoxDecoration(
          color: Colors.transparent, borderRadius: BorderRadius.circular(8.0)),
      child: DropdownButton<String>(
        // validator: (value) {
        //   if (value == null) {
        //     return 'Required';
        //   }
        //   return null;
        // },
        underline: Container(),
        value: value,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          color: Colors.black,
          fontSize: 16.0,
        ),
        items: list.map((String s) {
          return DropdownMenuItem<String>(
            value: s,
            child: Text(s),
          );
        }).toList(),
        onChanged: onChanged,
        // decoration: const InputDecoration(
        //   labelText: "State*",
        //   enabledBorder: OutlineInputBorder(
        //       borderRadius: BorderRadius.all(Radius.circular(10))),
        // ),
      ),
    );
  }
}
