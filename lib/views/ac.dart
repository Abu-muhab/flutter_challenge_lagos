import 'package:flutter/material.dart';
import 'package:flutter_lagos_challenge/widgets/custon_icon_button.dart';
import 'package:flutter_lagos_challenge/widgets/number_knob_selector.dart';

class AcView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.7,
          height: MediaQuery.of(context).size.width * 0.7,
          child: NumberKnobSelector(
            trackColor: Colors.green,
            markingsColor: Colors.blueGrey,
            fillColor: Colors.blueGrey[900]!,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          height: 50,
          width: 200,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50), color: Colors.blueGrey),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Weather-shower",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.blueGrey[900]!),
              ),
              SizedBox(
                width: 10,
              ),
              SizedBox(
                height: 20,
                width: 20,
                child: Image.asset(
                  "images/down-arrow.png",
                  color: Colors.blueGrey[900]!,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          width: 200,
          child: Wrap(
            alignment: WrapAlignment.center,
            spacing: 10,
            runSpacing: 10,
            children: [
              CustomIconButton(
                iconData: Icons.ac_unit,
                color: Colors.blueGrey[500]!,
                iconColor: Colors.blueGrey[900]!,
              ),
              CustomIconButton(
                iconData: Icons.access_time,
                color: Colors.blueGrey[500]!,
                iconColor: Colors.blueGrey[900]!,
              ),
              CustomIconButton(
                iconData: Icons.accessible_outlined,
                color: Colors.blueGrey[500]!,
                iconColor: Colors.blueGrey[900]!,
              ),
              CustomIconButton(
                iconData: Icons.account_tree_outlined,
                color: Colors.blueGrey[500]!,
                iconColor: Colors.blueGrey[900]!,
              ),
              CustomIconButton(
                iconData: Icons.ad_units_rounded,
                color: Colors.blueGrey[500]!,
                iconColor: Colors.blueGrey[900]!,
              ),
              CustomIconButton(
                iconData: Icons.add_chart_sharp,
                color: Colors.blueGrey[500]!,
                iconColor: Colors.blueGrey[900]!,
              ),
              CustomIconButton(
                iconData: Icons.adb_rounded,
                color: Colors.blueGrey[500]!,
                iconColor: Colors.blueGrey[900]!,
              ),
              CustomIconButton(
                iconData: Icons.account_balance,
                color: Colors.blueGrey[500]!,
                iconColor: Colors.blueGrey[900]!,
              ),
              CustomIconButton(
                iconData: Icons.add_alarm,
                color: Colors.blueGrey[500]!,
                iconColor: Colors.blueGrey[900]!,
              )
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        CustomIconButton(
          iconData: Icons.power_settings_new,
          color: Colors.green,
          iconColor: Colors.black,
        )
      ],
    );
  }
}
