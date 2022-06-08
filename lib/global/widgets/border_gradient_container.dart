import 'package:flutter/material.dart';

class BorderGradientContainer extends StatelessWidget {
  const BorderGradientContainer({
    Key? key,
    this.height,
    this.width,
    required this.shape,
    required this.borderGradient,
    this.borderRadius,
    this.backgroundColor,
    this.backgroundGradient,
    this.boxShadow,
    this.borderWidth = 1,
    required this.child,
  }) : super(key: key);

  final double? height;
  final double? width;
  final BoxShape shape;
  final Gradient borderGradient;
  final BorderRadius? borderRadius;
  final Color? backgroundColor;
  final Gradient? backgroundGradient;
  final List<BoxShadow>? boxShadow;
  final double borderWidth;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: shape,
        gradient: borderGradient,
        borderRadius: borderRadius,
        boxShadow: boxShadow,
      ),
      padding: EdgeInsets.all(borderWidth),
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: backgroundColor,
          gradient: backgroundGradient,
          borderRadius: borderRadius,
          shape: shape,
        ),
        child: child,
      ),
    );
  }
}
