import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key,
    this.controller,
    this.hintText,
    this.helpText,
    this.prefixIcon,
    this.suffixIcon,
    this.isPassword,
    this.enabled,
    this.readOnly,
    this.borderColor,
    this.labelText,
    this.onSaved,
    this.validator,
  });
  final TextEditingController? controller;
  final String? hintText;
  final String? helpText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final bool? isPassword;
  final bool? enabled;
  final bool? readOnly;
  final Color? borderColor;
  final Widget? labelText;
  final Function(String?)? onSaved;
  final String? Function(String?)? validator;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      readOnly: widget.readOnly == null ? false : true,
      obscureText: widget.isPassword == null ? false : true,
      onSaved: widget.onSaved,
      validator: widget.validator,
      decoration: InputDecoration(
        label: widget.labelText,
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: widget.borderColor ?? Colors.black,
            width: 1.3,
          ),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: widget.borderColor ?? Colors.teal,
            width: 1.3,
          ),
        ),
        hintText: widget.hintText ?? '',
        // helperText: helpText ?? '',
        prefixIcon: widget.prefixIcon == null ? null : Icon(widget.prefixIcon),
        suffix: widget.suffixIcon == null ? null : Icon(widget.suffixIcon),
        enabled: widget.enabled ?? false,
      ),
    );
  }
}
