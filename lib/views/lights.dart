import 'package:flutter/material.dart';
import 'package:flutter_lagos_challenge/widgets/knob_selector.dart';

class LightsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
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
    );
  }
}
