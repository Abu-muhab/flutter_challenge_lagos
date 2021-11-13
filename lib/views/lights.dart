import 'package:flutter/material.dart';
import 'package:flutter_lagos_challenge/widgets/custon_icon_button.dart';
import 'package:flutter_lagos_challenge/widgets/knob_selector.dart';

class LightsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.width * 0.8,
            child: KnobSelector(
              icon: Image.asset(
                "images/lamp.png",
                fit: BoxFit.fill,
              ),
              iconContainerColor: Colors.yellow,
              markingsColor: Colors.blueGrey,
              fillColor: Colors.blueGrey[900]!,
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Container(
            height: 50,
            width: 200,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.blueGrey[500]!),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(
                  Icons.admin_panel_settings_outlined,
                  color: Colors.blueGrey[900]!,
                ),
                Icon(
                  Icons.ac_unit,
                  color: Colors.blueGrey[900]!,
                ),
                Icon(
                  Icons.attribution_rounded,
                  color: Colors.blueGrey[900]!,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 50,
          ),
          CustomIconButton(
            iconData: Icons.ac_unit,
            color: Colors.blueGrey[500]!,
            iconColor: Colors.blueGrey[900]!,
          ),
          SizedBox(
            height: 20,
          ),
          CustomIconButton(
            iconData: Icons.power_settings_new,
            color: Colors.yellow,
            iconColor: Colors.black,
          )
        ],
      ),
    );
  }
}
