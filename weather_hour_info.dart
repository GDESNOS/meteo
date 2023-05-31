import 'package:flutter/material.dart';

class WeatherHourInfoComponent extends StatelessWidget {
  Text hour;
  Widget child;
  Text temp;
  double space;

  WeatherHourInfoComponent(
      {required this.hour,
      required this.child,
      required this.temp,
      this.space: 10});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        hour,
        SizedBox(
          height: space,
        ),
        child,
        SizedBox(
          height: space,
        ),
        temp,
      ],
    );
  }
}
