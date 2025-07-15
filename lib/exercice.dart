import 'package:flutter/material.dart';

class Exo extends StatelessWidget {
  const Exo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Column(children: [
            Icon(Icons.more),
            Container(
              child: Text("data"),
            )
          ]),
          Column(children: [
            Icon(Icons.more),
            Container(
              child: Text("data"),
            )
          ]),
          Column(children: [
            Icon(Icons.more),
            Container(
              child: Text("data"),
            )
          ])
        ],
      ),
    );
  }
}
