import 'package:flutter/material.dart';

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Colors.white;
    paint.style = PaintingStyle.fill;

    var path = Path();

    path.moveTo(0, size.height * 0.05);
    path.quadraticBezierTo(size.width * 0.30, size.height * -0.12,
        size.width * 0.55, size.height * 0.02);
    path.quadraticBezierTo(size.width * 0.75, size.height * 0.12,
        size.width *1, size.height * 0.00);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
