import 'package:flutter/material.dart';

class WeatherInfoComponent extends StatelessWidget {
  Icon icon;
  Text text;

  WeatherInfoComponent({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [icon, text],
    );
  }
}
