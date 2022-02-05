import 'package:flutter/material.dart';

const InputDecoration kfeedbackFieldDecoration = InputDecoration(
  hintText: 'Feedback goes here',
  hintStyle: TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 16.0,
  ),
  contentPadding: EdgeInsets.all(8),
  border: InputBorder.none,
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide.none,
  ),
);
