import 'dart:math';
import 'package:flutter/material.dart';

class NumberKnobSelector extends StatefulWidget {
  final Color fillColor;
  final Color markingsColor;
  final Color trackColor;

  NumberKnobSelector(
      {this.fillColor = Colors.black,
      this.markingsColor = Colors.blueGrey,
      this.trackColor = Colors.green});

  @override
  _NumberKnobSelectorState createState() => _NumberKnobSelectorState();
}

class _NumberKnobSelectorState extends State<NumberKnobSelector> {
  Offset? touchStart;
  Offset? touchUpdate;
  double knobLocation = pi - pi / 4;
  int value = 30;

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
                  onNewLocationCalculated: (location, value) {
                    setState(() {
                      knobLocation = location;
                      this.value = value;
                    });
                  },
                  trackColor: widget.trackColor,
                  knobLocation: knobLocation,
                  fillColor: widget.fillColor,
                  markingsColor: widget.markingsColor,
                  touchStart: touchStart,
                  touchUpdate: touchUpdate),
            ),
            Center(
              child: Container(
                width: constraints.maxWidth / 2,
                height: constraints.maxWidth / 2.5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Temperature",
                      style: TextStyle(
                          fontSize: constraints.maxWidth * 0.06,
                          color: widget.trackColor),
                    ),
                    RichText(
                      text: TextSpan(
                          text: "${value.toString()}°",
                          style: TextStyle(
                              fontSize: constraints.maxWidth * 0.23,
                              color: widget.trackColor),
                          children: [
                            TextSpan(
                                text: "C",
                                style: TextStyle(
                                    fontSize: constraints.maxWidth * 0.08,
                                    color: widget.trackColor))
                          ]),
                    ),
                    Expanded(
                        child: FittedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Icon(
                            Icons.ac_unit,
                            color: Colors.blueGrey,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.access_time,
                            color: Colors.blueGrey,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.add_to_queue,
                            color: Colors.blueGrey,
                          )
                        ],
                      ),
                    ))
                  ],
                ),
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
  Color trackColor;
  void Function(double, int)? onNewLocationCalculated;

  LightControllerPainter(
      {this.touchStart,
      this.touchUpdate,
      this.onNewLocationCalculated,
      this.knobLocation = 0,
      this.markingsColor = Colors.blueGrey,
      this.fillColor = Colors.black,
      this.trackColor = Colors.green});

  @override
  void paint(Canvas canvas, Size size) {
    //circle radius
    Offset center = Offset(size.width / 2, size.width / 2);
    double outerCircleRadius = size.width / 2.45;
    double innerCircleRadius = outerCircleRadius * 0.8;

    var paint = Paint();

    //draw outer circle
    paint.color = Colors.blueGrey;

    canvas.drawCircle(center, outerCircleRadius, paint);
    paint.color = trackColor;
    canvas.drawArc(Rect.fromCircle(center: center, radius: outerCircleRadius),
        pi, (knobLocation + pi), true, paint);
    print("Norm: $knobLocation  arc: ${knobLocation + pi}");

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

      paint.color = trackColor;
      if ((x % 30) == 0) {
        paint.strokeWidth = 4;
        canvas.drawLine(lineStartPoint, lineEndpointBig, paint);
      } else {
        paint.strokeWidth = 1;
        canvas.drawLine(lineStartPoint, lineEndpointSmall, paint);
      }
    }

    //draw knob
    paint.style = PaintingStyle.fill;
    paint.color = fillColor;
    paint.strokeWidth = 0.0;
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
          double newLocation =
              atan2(touchUpdate!.dy - center.dy, touchUpdate!.dx - center.dx);
          WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
            onNewLocationCalculated!(
                newLocation, (((knobLocation * 180 / pi) / 360) * 80).floor());
          });
        }
      }
    }
    canvas.drawCircle(knobCenter, knobRadius, paint);
    paint.strokeWidth = 3;
    paint.color = trackColor;
    paint.style = PaintingStyle.stroke;
    canvas.drawCircle(knobCenter, knobRadius, paint);

    paint.strokeWidth = 0.0;
    paint.style = PaintingStyle.fill;
    TextPainter textPainter = TextPainter(
        text: TextSpan(
            text: (((knobLocation * 180 / pi) / 360) * 80).floor().toString(),
            style: TextStyle(color: trackColor, fontSize: size.width * 0.07)),
        textAlign: TextAlign.center,
        maxLines: 1,
        textDirection: TextDirection.ltr);
    textPainter.layout();

    textPainter.paint(
        canvas,
        Offset(knobCenter.dx - textPainter.width / 2,
            knobCenter.dy - textPainter.height / 2));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
