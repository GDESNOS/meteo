import 'package:flutter/material.dart';
import 'package:meteo/screen/composant/FavoriteComponent.dart';
import 'package:meteo/screen/composant/HomeComponent.dart';
import 'package:meteo/screen/composant/MenuComponent.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  var composants = [
    HomeComponent(
      city: "Cotonou",
    ),
    FavoriteComponent(),
    MenuComponent(
      city: "Cotonou",
    )
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: composants[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (int index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.menu_outlined), label: ""),
        ],
      ),
    );
  }
}
