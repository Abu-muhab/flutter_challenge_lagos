import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class KnobSelector extends StatefulWidget {
  final Color fillColor;
  final Color markingsColor;
  final Color iconContainerColor;
  final Widget? icon;

  KnobSelector(
      {this.fillColor = Colors.black,
      this.markingsColor = Colors.blueGrey,
      this.iconContainerColor = Colors.yellow,
      this.icon});

  @override
  _KnobSelectorState createState() => _KnobSelectorState();
}

class _KnobSelectorState extends State<KnobSelector> {
  Offset? touchStart;
  Offset? touchUpdate;
  Color color = Colors.yellow;
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
        child: Stack(
          children: [
            CustomPaint(
              size: Size(constraints.maxWidth, constraints.maxHeight),
              painter: LightControllerPainter(
                  onNewLocationCalculated: (location, color) {
                    setState(() {
                      knobLocation = location;
                      this.color = color;
                    });
                  },
                  knobLocation: knobLocation,
                  fillColor: widget.fillColor,
                  markingsColor: widget.markingsColor,
                  touchStart: touchStart,
                  touchUpdate: touchUpdate),
            ),
            Center(
              child: CircleAvatar(
                backgroundColor: color,
                radius: constraints.maxHeight * 0.16,
                child: widget.icon != null ? widget.icon : Container(),
              ),
            )
          ],
        ),
      );
    });
  }
}

class LightControllerPainter extends CustomPainter {
  Offset? touchStart;
  Offset? touchUpdate;
  double knobLocation;
  Color fillColor;
  Color markingsColor;
  void Function(double, Color)? onNewLocationCalculated;

  LightControllerPainter(
      {this.touchStart,
      this.touchUpdate,
      this.onNewLocationCalculated,
      this.knobLocation = 0,
      this.markingsColor = Colors.blueGrey,
      this.fillColor = Colors.black});

  @override
  void paint(Canvas canvas, Size size) {
    List<Color> radialColors = [
      Colors.deepOrange,
      Colors.yellow,
      Colors.green,
      Colors.blue,
      Colors.redAccent
    ];

    //circle radius
    Offset center = Offset(size.width / 2, size.width / 2);
    double outerCircleRadius = size.width / 2.45;
    double innerCircleRadius = outerCircleRadius * 0.8;

    var paint = Paint();

    //draw outer circle
    paint.color = Colors.red;
    paint.shader = SweepGradient(colors: radialColors).createShader(
        Rect.fromCircle(
            center: Offset(size.width / 2, size.width / 2),
            radius: outerCircleRadius));
    canvas.drawCircle(center, outerCircleRadius, paint);

    //draw inner circle
    paint.color = fillColor;
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

      paint.color = markingsColor;
      if ((x % 30) == 0) {
        paint.strokeWidth = 4;
        canvas.drawLine(lineStartPoint, lineEndpointBig, paint);
      } else {
        paint.strokeWidth = 1;
        canvas.drawLine(lineStartPoint, lineEndpointSmall, paint);
      }
    }

    //draw innermost circle
    paint.color = markingsColor;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 1;
    canvas.drawCircle(center, innerCircleRadius * 0.95, paint);

    //draw innermost markings
    for (var x = 0; x < 360; x += 12) {
      Offset lineEndpoint = Offset(
          (innerCircleRadius * 0.95) * cos(x * (pi / 180)) + center.dx,
          (innerCircleRadius * 0.95) * sin(x * (pi / 180)) + center.dy);
      Offset lineStartPoint = Offset(
          ((lineEndpoint.dx * 11) + (center.dx * 1)) / (11 + 1),
          ((lineEndpoint.dy * 11) + (center.dy * 1)) / (11 + 1));

      paint.color = markingsColor;
      paint.strokeWidth = 1;
      canvas.drawLine(lineStartPoint, lineEndpoint, paint);
    }

    //draw innermost arc
    paint.color = Colors.grey;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 5;
    canvas.drawArc(
        Rect.fromCircle(center: center, radius: innerCircleRadius * 0.95),
        knobLocation + pi - pi / 4,
        pi / 2,
        false,
        paint);

    //draw knob
    paint.style = PaintingStyle.fill;
    paint.strokeWidth = 0.0;
    paint.shader = SweepGradient(colors: radialColors).createShader(
        Rect.fromCircle(
            center: Offset(size.width / 2, size.width / 2),
            radius: outerCircleRadius));
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

          //calculate color
          int colorIndex =
              (((newLocation / pi).abs()) * radialColors.length - 1)
                  .floor()
                  .toInt()
                  .abs();
          if (colorIndex < 0) {
            colorIndex = 0;
          } else if (colorIndex > radialColors.length - 1) {
            colorIndex = radialColors.length - 1;
          }
          Color c = radialColors[colorIndex];

          WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
            onNewLocationCalculated!(newLocation, c);
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
