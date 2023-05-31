import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:meteo/models/Weather.dart';
import 'package:meteo/widgets/weathe_info_compoent.dart';

class MenuComponent extends StatelessWidget {
  String? city;

  MenuComponent({this.city: "Cotonou"});

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.vertical,
      children: [
        FutureBuilder(
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
                    child: Column(children: [
                      Container(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.my_location),
                                Text("Your location Now")
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text("  ${weather.location?.name}",
                                style: TextStyle(fontSize: 30)),
                            Image.network(
                              "https:${weather.current?.condition?.icon}",
                              height: 150,
                              width: 150,
                            ),
                            Text("  ${weather.location?.country}"),
                            Text("  ${weather.current?.tempC}°C",
                                style: TextStyle(fontSize: 50)),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              WeatherInfoComponent(
                                  icon: Icon(
                                    Icons.air_outlined,
                                    color: Colors.blue,
                                  ),
                                  text: Text("${weather.current?.visKm}km/h")),
                              WeatherInfoComponent(
                                  icon: Icon(
                                    Icons.water_drop_outlined,
                                    color: Colors.blue,
                                  ),
                                  text: Text("${weather.current?.humidity} %")),
                              WeatherInfoComponent(
                                  icon: Icon(
                                    Icons.watch_later_outlined,
                                    color: Colors.blue,
                                  ),
                                  text: Text(
                                      "${weather.current?.pressureMb} mBar"))
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Temperature"),
                              Container(
                                child: Row(
                                  children: [
                                    Text("Celcius"),
                                    Icon(Icons.navigate_next),
                                  ],
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
                              Text("Wind Speed"),
                              Container(
                                child: Row(
                                  children: [
                                    Text("m/s"),
                                    Icon(Icons.navigate_next),
                                  ],
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
                              Text("Source"),
                              Container(
                                child: Row(
                                  children: [
                                    Text("westhergon"),
                                    Icon(Icons.navigate_next),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ]),
                  );
                }
                return Center(child: Text("FAIT"));
            }
          },
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
