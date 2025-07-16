import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:meteo/weathe_info_compoent.dart';
import 'package:meteo/weather_city_info.dart';

import 'Weather.dart';

class FavoriteComponent extends StatefulWidget {
  const FavoriteComponent({Key? key}) : super(key: key);

  @override
  State<FavoriteComponent> createState() => _FavoriteComponentState();
}

class _FavoriteComponentState extends State<FavoriteComponent> {
  bool isClicked = false;
  Color? bg;
  var ville = [
    "Parakou",
    "Cotonou",
    "Porto-Novo",
    "Khodjent",
    "Bielefeld",
    "Pereira",
    "Lagos",
    "Canada",
    "Lome",
    "Moscou",
    "Dacca",
    "Bangkok",
    "Tokyo",
    "Karachi",
    "Londres",
    "Shantou",
    "Istanbul",
    "Paris",
    "Bagdad",
    "Lima",
    "Nagoya",
    "Lahora",
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12.0, top: 8, bottom: 8, right: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Icon(Icons.favorite, color: Colors.blue,),SizedBox(width: 10,), Text("Mes villes favoris",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16), )],
                  ),
                  Icon(Icons.edit),
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height*0.82,
              decoration: BoxDecoration(
                color: Color.fromARGB(234, 175, 167, 167),
              ),
              child: GridView.count(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                crossAxisCount: 2,
                padding: EdgeInsets.only(top: 20, right: 6, left: 6, bottom: 20),
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                children: ville.map((MyMaping) {
                  return FutureBuilder(
                      future: fetchData(MyMaping),
                      builder:
                          (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                            return Center(child: CircularProgressIndicator());

                          case ConnectionState.none:
                            return Center(child: Text("Rien a signaler"));

                          case ConnectionState.active:
                            return Center(child: Text("Tentative de Connexion"));

                          case ConnectionState.done:
                            if (snapshot.hasError) {
                              return Container(
                                  child: Center(
                                      child: Text(
                                          "Verifier votre connexion internet ")));
                            }

                            if (snapshot.data != null) {
                              Weather weather = snapshot.data;
                              return Column(
                                children: [
                                  WeatherCityInfo(
                                    city: Text(
                                      MyMaping,
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    temp: Text(
                                      "${weather.current?.tempC}°",
                                      style: TextStyle(
                                          fontSize: 30, fontWeight: FontWeight.bold),
                                    ),
                                    country: Text("${weather.location?.country}"),
                                    weather_widget: Image.network(
                                      "https:${weather.current?.condition?.icon}",width: 50,height: 50,),
                                    weatherInfoComponents: [
                                      WeatherInfoComponent(
                                          icon: Icon(
                                            Icons.water_drop_outlined,
                                            color: Colors.blue,
                                          ),
                                          text: Text("${weather.current?.humidity} %")),
                                      WeatherInfoComponent(
                                          icon: Icon(
                                            Icons.air_outlined,
                                            color: Colors.blue,
                                          ),
                                          text: Text("${weather.current?.visKm} km/h"))
                                    ],
                                  ),
                                ],
                              );
                            }
                            return Center(child: Text("FAIT"));
                        }
                      });
                }).toList(),
              ),
            ),
          ],
        ),
      ),
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
