import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LightControl extends StatefulWidget {
  @override
  _LightControlState createState() => _LightControlState();
}

class _LightControlState extends State<LightControl> {
  Offset? touchStart;
  Offset? touchUpdate;
  double knobLocation = pi / 2;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return GestureDetector(
        onPanUpdate: (details) {
          setState(() {
            touchUpdate = details.localPosition;
          });
        },
        onPanStart: (details) {
          setState(() {
            touchStart = details.localPosition;
          });
        },
        onPanEnd: (_) {
          setState(() {
            touchUpdate = null;
            touchStart = null;
          });
        },
        child: CustomPaint(
          size: Size(constraints.maxWidth, constraints.maxHeight),
          painter: LightControllerPainter(
              onNewLocationCalculated: (location) {
                setState(() {
                  knobLocation = location;
                });
              },
              knobLocation: knobLocation,
              touchStart: touchStart,
              touchUpdate: touchUpdate),
        ),
      );
    });
  }
}

class LightControllerPainter extends CustomPainter {
  Offset? touchStart;
  Offset? touchUpdate;
  double knobLocation;
  void Function(double)? onNewLocationCalculated;

  LightControllerPainter(
      {this.touchStart,
      this.touchUpdate,
      this.onNewLocationCalculated,
      this.knobLocation = 0});

  @override
  void paint(Canvas canvas, Size size) {
    //circle radius
    Offset center = Offset(size.width / 2, size.width / 2);
    double outerCircleRadius = size.width / 2.45;
    double innerCircleRadius = outerCircleRadius * 0.8;

    var paint = Paint();

    //draw outer circle
    paint.color = Colors.red;
    paint.shader = SweepGradient(colors: [
      Colors.deepOrange,
      Colors.yellow,
      Colors.green,
      Colors.blue,
      Colors.redAccent
    ]).createShader(Rect.fromCircle(
        center: Offset(size.width / 2, size.width / 2),
        radius: outerCircleRadius));
    canvas.drawCircle(center, outerCircleRadius, paint);

    //draw inner circle
    paint.color = Colors.white;
    paint.shader = null;
    canvas.drawCircle(center, innerCircleRadius, paint);

    //draw outer markings
    for (var x = 0; x < 360; x += 6) {
      Offset lineEndpointBig = Offset(
          (outerCircleRadius * 1.15) * cos(x * (pi / 180)) + center.dx,
          (outerCircleRadius * 1.15) * sin(x * (pi / 180)) + center.dy);
      Offset lineEndpointSmall = Offset(
          (outerCircleRadius * 1.1) * cos(x * (pi / 180)) + center.dx,
          (outerCircleRadius * 1.1) * sin(x * (pi / 180)) + center.dy);
      Offset lineStartPoint = Offset(
          ((lineEndpointBig.dx * 8) + (center.dx * 1)) / (8 + 1),
          ((lineEndpointBig.dy * 8) + (center.dy * 1)) / (8 + 1));

      paint.color = Colors.blueGrey;
      if ((x % 30) == 0) {
        paint.strokeWidth = 4;
        canvas.drawLine(lineStartPoint, lineEndpointBig, paint);
      } else {
        paint.strokeWidth = 1;
        canvas.drawLine(lineStartPoint, lineEndpointSmall, paint);
      }
    }

    //draw innermost circle

    //draw innermost markings

    //draw knob
    paint.color = Colors.black;
    paint.strokeWidth = 0.0;
    double knobRadius = (outerCircleRadius - innerCircleRadius) * 1.2;
    double knobYDistanceFromCenter =
        (innerCircleRadius + (outerCircleRadius - innerCircleRadius) / 2) *
            sin(knobLocation);
    double knobXDistanceFromCenter =
        (innerCircleRadius + (outerCircleRadius - innerCircleRadius) / 2) *
            cos(knobLocation);

    //calculate knobCenter
    Offset knobCenter = Offset(center.dx + knobXDistanceFromCenter,
        center.dy + knobYDistanceFromCenter);

    //check if knob is being dragged
    if (touchStart != null) {
      double touchRadiusFromCenter = sqrt(pow(touchUpdate!.dx - center.dx, 2) +
          pow(touchUpdate!.dy - center.dy, 2));

      //check if touchStart is actually touching the knob
      if (touchRadiusFromCenter >= innerCircleRadius) {
        if (onNewLocationCalculated != null && touchUpdate != null) {
          double newLocation = atan(
              (touchUpdate!.dy - center.dy) / (touchUpdate!.dx - center.dx));
          if (center.dx > touchUpdate!.dx) {
            newLocation += pi;
          }
          WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
            onNewLocationCalculated!(newLocation);
          });
        }
      }
    }
    canvas.drawCircle(knobCenter, knobRadius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
