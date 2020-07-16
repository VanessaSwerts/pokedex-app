import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pokedex_app/consts/consts_app.dart';

class PokeItem extends StatelessWidget {
  final String name;
  final String number;
  final int index;
  final Color color;
  final List<String> types;

  PokeItem({this.name, this.index, this.color, this.number, this.types});

  Widget setTypes() {
    List<Widget> lista = [];
    types.forEach((name) {
      lista.add(
        Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color.fromARGB(80, 255, 255, 255)),
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Text(
                  name.trim(),
                  style: TextStyle(
                      fontFamily: 'Google',
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            )
          ],
        ),
      );
    });
    return Column(
      children: lista,
      crossAxisAlignment: CrossAxisAlignment.start,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                ConstsApp.getColorType(type: types[0]).withOpacity(0.7),
                ConstsApp.getColorType(type: types[0]),
              ]),
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.bottomRight,
                child: Hero(
                  tag: name + 'rotation',
                  child: Opacity(
                    opacity: 0.25,
                    child: Image.asset(
                      ConstsApp.whitePokeball,
                      height: 80,
                      width: 80,
                    ),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                    child: Text(
                      name,
                      style: TextStyle(
                        fontFamily: "Google",
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 6.0, left: 4.0),
                    child: setTypes(),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Hero(
                  tag: name,
                  child: CachedNetworkImage(
                    alignment: Alignment.bottomRight,
                    height: 80,
                    width: 80,
                    placeholder: (context, url) => Container(
                      color: Colors.transparent,
                    ),
                    imageUrl:
                        "https://raw.githubusercontent.com/fanzeyi/pokemon.json/master/images/$number.png",
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
