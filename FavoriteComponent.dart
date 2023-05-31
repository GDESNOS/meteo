import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:meteo/models/Weather.dart';
import 'package:meteo/widgets/weathe_info_compoent.dart';
import 'package:meteo/widgets/weather_city_info.dart';

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
    return Column(
      children: [
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Icon(Icons.search), Text("search")],
                ),
              ),
              Icon(Icons.edit),
            ],
          ),
        ),
        Container(
          height: 410,
          decoration: BoxDecoration(
            color: Color.fromARGB(234, 175, 167, 167),
          ),
          child: GridView.count(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            crossAxisCount: 2,
            padding: EdgeInsets.all(10),
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
            children: ville.map((MyMaping) {
              return FutureBuilder(
                  future: fetchData(MyMaping),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
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
                                  child: Text(
                                      "Verifier Votre forfaire internet ")));
                        }

                        if (snapshot.data != null) {
                          Weather weather = snapshot.data;
                          return WeatherCityInfo(
                            city: Text(
                              MyMaping,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            temp: Text(
                              "${weather.current?.tempC}°",
                              style: TextStyle(
                                  fontSize: 40, fontWeight: FontWeight.bold),
                            ),
                            country: Text("${weather.location?.country}"),
                            weather_widget: Image.network(
                                "https:${weather.current?.condition?.icon}"),
                            weatherInfoComponents: [
                              WeatherInfoComponent(
                                  icon: Icon(
                                    Icons.water_drop_outlined,
                                    color: Colors.blue,
                                  ),
                                  text: Text("${weather.current?.humidity}%")),
                              WeatherInfoComponent(
                                  icon: Icon(
                                    Icons.air_outlined,
                                    color: Colors.blue,
                                  ),
                                  text: Text("${weather.current?.visKm}km/h"))
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
