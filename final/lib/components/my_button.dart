import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Text text;
  final void Function()? onTap;
  final Color color;
  final double w;
  final double h;

  const MyButton({
    super.key,
    required this.text,
    required this.color,
    this.onTap,
    required this.w,
    required this.h,
  });

  @override
  Widget build(Object context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: h,
        width: w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: color,
        ),
        padding: const EdgeInsets.all(25),
        margin: const EdgeInsets.symmetric(horizontal: 25),
        child: Center(
          child: text,
        ),
      ),
    );
  }
}
