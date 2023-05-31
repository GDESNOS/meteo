import 'package:flutter/material.dart';
import 'package:meteo/widgets/weathe_info_compoent.dart';

class WeatherCityInfo extends StatelessWidget {
  Text temp;
  Text city;
  Text country;
  Widget weather_widget;
  List<WeatherInfoComponent> weatherInfoComponents;

  WeatherCityInfo(
      {required this.temp,
      required this.city,
      required this.country,
      required this.weather_widget,
      required this.weatherInfoComponents});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  temp,
                  city,
                  country,
                ],
              ),
              weather_widget
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: weatherInfoComponents,
          )
        ],
      ),
    );
  }
}
