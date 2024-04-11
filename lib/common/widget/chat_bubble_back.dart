import 'package:flutter/material.dart';

class MyPainter extends CustomPainter {
  final bool isLeft;
  final double? borderRadius;
  final Color color;
  final double? arrowHeight;
  final double? arrowY;
  late final Paint _paint = Paint()
    ..color = color
    ..style = PaintingStyle.fill;

  MyPainter({
    required this.isLeft,
    required this.color,
    this.borderRadius,
    this.arrowHeight,
    this.arrowY,
  });

  @override
  void paint(Canvas canvas, Size size) {
    double arrowHeight = this.arrowHeight ?? 5;
    double arrowY = this.arrowY ?? 15;
    final borderRadius = this.borderRadius ?? 0;
    if(isLeft) {
      var rect = Rect.fromLTRB(arrowHeight, 0, size.width, size.height);
      var rRect = RRect.fromRectAndRadius(rect, Radius.circular(borderRadius));
      canvas.drawRRect(rRect, _paint);
      Path path = Path();
      path.moveTo(arrowHeight, arrowY);
      path.lineTo(0, arrowY + arrowHeight);
      path.lineTo(arrowHeight, arrowY + arrowHeight * 2);
      path.close();
      canvas.drawPath(path, _paint);
    } else {
      var rect = Rect.fromLTRB(0, 0, size.width - arrowHeight, size.height);
      var rRect = RRect.fromRectAndRadius(rect, Radius.circular(borderRadius));
      canvas.drawRRect(rRect, _paint);
      Path path = Path();
      path.moveTo(size.width - arrowHeight, arrowY);
      path.lineTo(size.width, arrowY + arrowHeight);
      path.lineTo(size.width - arrowHeight, arrowY + arrowHeight * 2);
      path.close();
      canvas.drawPath(path, _paint);
    }


  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
