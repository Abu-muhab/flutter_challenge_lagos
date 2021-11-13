import 'package:flutter/material.dart';
import 'package:flutter_lagos_challenge/widgets/knob_selector.dart';
import 'package:flutter_lagos_challenge/widgets/number_knob_selector.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Flutter Lagos Challenge",
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blueGrey[900]!,
        height: double.infinity,
        width: double.infinity,
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
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.width * 0.8,
              child: NumberKnobSelector(
                trackColor: Colors.green,
                markingsColor: Colors.blueGrey,
                fillColor: Colors.blueGrey[900]!,
              ),
            )
          ],
        ),
      ),
    );
  }
}
