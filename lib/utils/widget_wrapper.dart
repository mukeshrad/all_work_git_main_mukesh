import 'package:flutter/material.dart';

Container elevatedContainer({required Widget child}){
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
        border: Border.all( 
            width: 1.0,
            color: Colors.transparent 
            ),
        borderRadius: const BorderRadius.all(
            Radius.circular(5.0)
            ), 
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.23),
            spreadRadius: 1.5,
            blurRadius: 5,
            offset: const Offset(0, 2), // changes position of shadow
          ),
          ] // Make rounded corner of border
      ),
      child: child,
  );
}