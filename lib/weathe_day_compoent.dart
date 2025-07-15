import 'package:flutter/material.dart';

class WeatherDayComponent extends StatelessWidget {
  Icon icon;
  Text text1;
  Text text2;
  Text text3;

  WeatherDayComponent(
      {required this.icon,
      required this.text1,
      required this.text2,
      required this.text3});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [text1],
        ),
        Column(
          children: [icon],
        ),
        Column(
          children: [
            Container(
              child: Row(
                children: [text2, Text("   "), text3],
              ),
            )
          ],
        ),
      ],
    );
  }
}
