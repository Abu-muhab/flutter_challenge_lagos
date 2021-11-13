import 'package:flutter/material.dart';

class ViewMenu extends StatelessWidget {
  final bool selected;
  final String assetName;
  final Color color;
  final VoidCallback? onTap;

  ViewMenu(
      {this.selected = false,
      this.assetName = "",
      this.onTap,
      this.color = Colors.grey});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            child: Image.asset(
              assetName,
              color: selected ? color : Colors.grey,
            ),
            width: 25,
            height: 25,
          ),
          SizedBox(
            height: 2,
          ),
          selected == true
              ? Container(
                  height: 5,
                  width: double.infinity,
                  color: Colors.grey,
                )
              : Container()
        ],
      ),
    );
  }
}
