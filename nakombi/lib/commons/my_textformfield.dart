import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
  MyTextFormField(
    this.label, {
    super.key,
    this.controller,
    this.initialValue,
    this.onTap, required TextInputType textType, required String labelText, required Null Function(dynamic value) onChanged, required String? Function(dynamic value) validator, required Null Function(dynamic value) onSaved,
  });
  final String label;
  final TextEditingController? controller;
  final String? initialValue;
  void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0, top: 5),
      child: TextFormField(
        onTap: onTap,
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
