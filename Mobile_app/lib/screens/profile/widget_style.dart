import 'package:flutter/material.dart';
import 'dart:ui';

class WidgetStyle extends StatelessWidget {
  
  const WidgetStyle({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }

  Widget buildBottomBorder({
    required double horizontalValue,
    required Color colorValue,
    required double widthValue,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalValue),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: colorValue, width: widthValue),
          ),
        ),
      ),
    );
  }

  Widget buildCircleIcon({
    required double paddingValue,
    required Color backgroundColor,
    required IconData iconData,
    required Color iconColor,
    required double iconSize,

  }) {
    return Container(
      padding: EdgeInsets.all(paddingValue),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Color(0xFFE9E5E5)),
        color: backgroundColor,
      ),
          child: Icon(iconData, color: iconColor, size: iconSize),
    );
  }

}