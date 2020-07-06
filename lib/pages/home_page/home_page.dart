import 'package:flutter/material.dart';
import 'package:pokedex_app/consts/consts_app.dart';
import 'package:pokedex_app/pages/home_page/widgets/appbar_home.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;    
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          Positioned(
            top: -47,
            left: screenWidth - 140,
            child: Opacity(
              opacity: 0.1,
              child: Image.asset(
                ConstsApp.blackPokeball,
                width: 220,
                height: 220,
              ),
            ),
          ),
          SafeArea(
            child: Container(
              child: Column(
                children: <Widget>[                 
                  AppBarHome(),
                  Expanded(
                    child: Container(
                      child: ListView(
                        children: <Widget>[
                          ListTile(
                            title: Text("POKEMON"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
