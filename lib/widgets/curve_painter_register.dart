import 'package:flutter/material.dart';

class CurvePainterRegister extends CustomPainter {
 @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Colors.white;
    paint.style = PaintingStyle.fill;

    var path = Path();

    path.moveTo(0, size.height * -0.00);
    path.quadraticBezierTo(size.width * 0.25, size.height * -0.06,
        size.width * 0.45, size.height * 0.02);
    path.quadraticBezierTo(size.width * 0.75, size.height * 0.12,
        size.width * 1, size.height * 0.05);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
