import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lagos_challenge/views/ac.dart';
import 'package:flutter_lagos_challenge/views/lights.dart';
import 'package:flutter_lagos_challenge/widgets/view_menu.dart';

class ViewHolder extends StatefulWidget {
  @override
  _ViewHolderState createState() => _ViewHolderState();
}

class _ViewHolderState extends State<ViewHolder> {
  late View selectedView;

  @override
  void initState() {
    selectedView = View.LIGHTS;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blueGrey[800]!,
        child: Column(
          children: [
            Container(
              color: Colors.blueGrey[900]!,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Living-room",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w600,
                            color: Colors.blueGrey),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        height: 20,
                        width: 20,
                        child: Image.asset(
                          "images/down-arrow.png",
                          color: Colors.blueGrey,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Work Lamp",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Colors.blueGrey),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            child: ViewMenu(
                          assetName: "images/lamp.png",
                          color: Colors.yellow,
                          selected: selectedView == View.LIGHTS,
                          onTap: () {
                            if (selectedView != View.LIGHTS) {
                              setState(() {
                                selectedView = View.LIGHTS;
                              });
                            }
                          },
                        )),
                        Expanded(
                            child: ViewMenu(
                          color: Colors.green,
                          assetName: "images/air-conditioner.png",
                          selected: selectedView == View.AC,
                          onTap: () {
                            if (selectedView != View.AC) {
                              setState(() {
                                selectedView = View.AC;
                              });
                            }
                          },
                        )),
                        Expanded(
                            child: ViewMenu(
                          assetName: "images/monitor.png",
                          selected: selectedView == View.TV,
                          onTap: () {
                            if (selectedView != View.TV) {
                              setState(() {
                                selectedView = View.TV;
                              });
                            }
                          },
                        )),
                        Expanded(
                            child: ViewMenu(
                          assetName: "images/lampp.png",
                          selected: selectedView == View.READING_LAMP,
                          onTap: () {
                            if (selectedView != View.READING_LAMP) {
                              setState(() {
                                selectedView = View.READING_LAMP;
                              });
                            }
                          },
                        )),
                        Expanded(
                            child: ViewMenu(
                          assetName: "images/musical-note.png",
                          selected: selectedView == View.MUSIC,
                          onTap: () {
                            if (selectedView != View.MUSIC) {
                              setState(() {
                                selectedView = View.MUSIC;
                              });
                            }
                          },
                        ))
                      ],
                    ),
                  )
                ],
              ),
            ),
            Expanded(
                child: selectedView == View.LIGHTS
                    ? LightsView()
                    : selectedView == View.AC
                        ? AcView()
                        : Container(
                            color: Colors.blueGrey[800]!,
                            child: Center(
                              child: Text(
                                "",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                          ))
          ],
        ),
      ),
    );
  }
}

enum View { LIGHTS, AC, TV, MUSIC, READING_LAMP }
