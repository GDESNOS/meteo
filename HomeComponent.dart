import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:meteo/widgets/weathe_day_compoent.dart';
import 'package:meteo/widgets/weathe_info_compoent.dart';
import 'package:meteo/widgets/weather_city_info.dart';
import 'package:meteo/widgets/weather_hour_info.dart';
import 'package:http/http.dart' as http;
import 'package:meteo/models/Weather.dart';

class HomeComponent extends StatelessWidget {
  String? city;
  HomeComponent({this.city: "Porto-Novo"});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: FutureBuilder(
          future: fetchData(city),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return CircularProgressIndicator();

              case ConnectionState.none:
                return Center(child: Text("Rien a signaler"));

              case ConnectionState.active:
                return Center(child: Text("Tentative de Connexion"));

              case ConnectionState.done:
                if (snapshot.hasError) {
                  return Container(
                      child: Center(
                          child: Text("Verifier Votre forfaire internet ")));
                }
                if (snapshot.data != null) {
                  Weather weather = snapshot.data;
                  return Container(
                    child: ListView(
                      children: [
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      "${weather.location?.name}",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text("${weather.current?.tempC}°",
                                        style: TextStyle(
                                            fontSize: 50,
                                            fontWeight: FontWeight.w500)),
                                    ElevatedButton(
                                      onPressed: () {},
                                      child: Text(
                                          "${weather.current?.condition?.text}"),
                                      style: ElevatedButton.styleFrom(
                                        primary:
                                            Color.fromARGB(255, 205, 189, 189),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 255, 245, 245),
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(100),
                                          topLeft: Radius.circular(100),
                                          bottomRight: Radius.circular(100),
                                          topRight: Radius.circular(100))),
                                  child: Image.network(
                                    "https:${weather.current?.condition?.icon}",
                                    height: 200,
                                    width: 200,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    WeatherInfoComponent(
                                        icon: Icon(
                                          Icons.air_outlined,
                                          color: Colors.blue,
                                        ),
                                        text: Text(
                                            "${weather.current?.visKm}km/h")),
                                    SizedBox(
                                      width: 80,
                                    ),
                                    WeatherInfoComponent(
                                        icon: Icon(
                                          Icons.watch_later_outlined,
                                          color: Colors.blue,
                                        ),
                                        text: Text(
                                            "${weather.current?.pressureMb} mBar")),
                                    SizedBox(
                                      width: 80,
                                    ),
                                    WeatherInfoComponent(
                                        icon: Icon(
                                          Icons.water_drop_outlined,
                                          color: Colors.blue,
                                        ),
                                        text: Text(
                                            "${weather.current?.humidity} %")),
                                    SizedBox(
                                      width: 80,
                                    ),
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Image.network(
                                  "https:${weather.forecast?.forecastday![0]?.hour![7]?.condition?.icon}",
                                  scale: 2,
                                ),
                                Text("07:00")
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text("18:00"),
                                Image.network(
                                  "https:${weather.forecast?.forecastday![0]?.hour![18]?.condition?.icon}",
                                  scale: 2,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "Today",
                                  style: TextStyle(color: Colors.grey),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                WeatherHourInfoComponent(
                                    hour: Text(
                                      "10h",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    child: Image.network(
                                      "https:${weather.forecast?.forecastday![0]?.hour![10]?.condition?.icon}",
                                      scale: 2,
                                    ),
                                    temp: Text(
                                      "${weather.forecast?.forecastday![0]?.hour![10]?.tempC}°",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600),
                                    )),
                                WeatherHourInfoComponent(
                                    hour: Text(
                                      "11h",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    child: Image.network(
                                      "https:${weather.forecast?.forecastday![0]?.hour![11]?.condition?.icon}",
                                      scale: 2,
                                    ),
                                    temp: Text(
                                      "${weather.forecast?.forecastday![0]?.hour![11]?.tempC}°",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600),
                                    )),
                                WeatherHourInfoComponent(
                                    hour: Text(
                                      "12h",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    child: Image.network(
                                      "https:${weather.forecast?.forecastday![0]?.hour![12]?.condition?.icon}",
                                      scale: 2,
                                    ),
                                    temp: Text(
                                      "${weather.forecast?.forecastday![0]?.hour![12]?.tempC}°",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600),
                                    )),
                                WeatherHourInfoComponent(
                                    hour: Text(
                                      "13h",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    child: Image.network(
                                      "https:${weather.forecast?.forecastday![0]?.hour![13]?.condition?.icon}",
                                      scale: 2,
                                    ),
                                    temp: Text(
                                      "${weather.forecast?.forecastday![0]?.hour![13]?.tempC}°",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600),
                                    )),
                                WeatherHourInfoComponent(
                                    hour: Text(
                                      "14h",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    child: Image.network(
                                      "https:${weather.forecast?.forecastday![0]?.hour![14]?.condition?.icon}",
                                      scale: 2,
                                    ),
                                    temp: Text(
                                      "${weather.forecast?.forecastday![0]?.hour![14]?.tempC}°",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600),
                                    ))
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Column(
                              children: [
                                WeatherDayComponent(
                                    icon: Icon(
                                      Icons.sunny,
                                      color: Colors.yellow,
                                    ),
                                    text1: Text("Tuesday"),
                                    text2: Text("19°"),
                                    text3: Text("15°")),
                                WeatherDayComponent(
                                    icon: Icon(
                                      Icons.sunny,
                                      color: Colors.yellow,
                                    ),
                                    text1: Text("Wednesday"),
                                    text2: Text("19°"),
                                    text3: Text("15°")),
                                WeatherDayComponent(
                                    icon: Icon(
                                      Icons.sunny,
                                      color: Colors.yellow,
                                    ),
                                    text1: Text("Thursday"),
                                    text2: Text("19°"),
                                    text3: Text("15°"))
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  );
                }
                return Center(child: Text("FAIT"));
            }
          }),
    );
  }

  Future<Weather> fetchData(String? city) async {
    var url = Uri.parse(
        'https://api.weatherapi.com/v1/forecast.json?key=c408b820470d408984293434220304&q=$city&days=1&aqi=no&alerts=no');
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    return Weather.fromJson(jsonDecode(response.body));
  }
}
