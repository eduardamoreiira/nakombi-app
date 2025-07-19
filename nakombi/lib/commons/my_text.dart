import 'package:flutter/material.dart';

class MyText extends StatelessWidget {
  const MyText({
    super.key,
    this.text,
    this.color,
    this.size,
    this.weight,
    this.maxLines,
    this.overflow,
    this.softWrap,
  });
  final String? text;
  final Color? color;
  final double? size;
  final FontWeight? weight;
  final int? maxLines;
  final TextOverflow? overflow;
  final bool? softWrap;
  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      style: TextStyle(color: color, fontSize: size, fontWeight: weight),
      overflow: overflow,
      maxLines: maxLines,
      softWrap: softWrap,
    );
  }
}
