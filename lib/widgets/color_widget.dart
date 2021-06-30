import 'package:flutter/material.dart';

class ColorWidget extends StatelessWidget {
  final int color;

  ColorWidget(this.color);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: Color(color),
        height: 50.0,
        width: 50.0,
      ),
    );
  }
}
