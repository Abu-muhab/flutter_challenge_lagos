import 'package:flutter/material.dart';
import 'package:flutter_lagos_challenge/widgets/view_holder.dart';

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
        child: SafeArea(
          child: ViewHolder(),
        ),
      ),
    );
  }
}
