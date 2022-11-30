import 'package:flutter/rendering.dart';

class TicketClipper extends CustomClipper<Path> {
  final double radius;

  TicketClipper({this.radius = 10});

  @override
  Path getClip(Size size) {
    Path path = Path();
    final h = size.height;
    final w = size.width;
    final top = h / 2 - radius / 2;
    final bottom = top + radius;

    path.moveTo(0, 0);
    path.lineTo(0, top);
    path.arcToPoint(
      Offset(0, bottom),
      clockwise: true,
      radius: const Radius.circular(1),
    );
    path.lineTo(0, h);
    path.lineTo(w, h);
    path.lineTo(w, bottom);
    path.arcToPoint(
      Offset(w, top),
      clockwise: true,
      radius: const Radius.circular(1),
    );
    path.lineTo(w, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
