import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final IconData iconData;
  final Color color;
  final Color iconColor;

  CustomIconButton(
      {this.color = Colors.blueGrey,
      this.iconColor = Colors.grey,
      this.iconData = Icons.ac_unit});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 60,
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(60)),
      child: Center(
        child: Icon(
          iconData,
          color: iconColor,
        ),
      ),
    );
  }
}
