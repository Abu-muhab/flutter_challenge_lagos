import 'package:flutter/material.dart';
import 'package:flutter_lagos_challenge/widgets/number_knob_selector.dart';

class AcView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.width * 0.8,
        child: NumberKnobSelector(
          trackColor: Colors.green,
          markingsColor: Colors.blueGrey,
          fillColor: Colors.blueGrey[900]!,
        ),
      ),
    );
  }
}
