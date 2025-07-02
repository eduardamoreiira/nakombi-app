import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
  MyTextFormField(
    this.label, {
    super.key,
    required this.controller,
    this.initialValue,
  });
  final String label;
  final TextEditingController controller;
  String? initialValue;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0, top: 5),
      child: TextFormField(
        initialValue: initialValue,
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderSide: BorderSide(width: 1.0)),
          enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 1.0)),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1.2, color: Colors.green),
          ),
        ),
      ),
    );
  }
}
