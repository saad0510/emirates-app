import 'package:flutter/material.dart';

class PlaneClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    final h = size.height;
    final w = size.width;
    final head = h / 2;

    path.moveTo(0, h);
    path.lineTo(0, head);
    path.conicTo(w / 10, 0, w / 2, 0, 1);
    path.conicTo(w - w / 10, 0, w, head, 1);
    path.lineTo(w, h);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
