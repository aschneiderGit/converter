import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text("Start to convert here !"),
      ),
      body: Stack(
        children: [
          Container(color: Colors.red, height: 100, width: 100),
          Positioned(top: 25, left: 25, child: Icon(Icons.bike_scooter)),
        ],
      ),
    );
  }
}
