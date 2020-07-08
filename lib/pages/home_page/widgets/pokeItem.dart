import 'package:flutter/material.dart';
import 'package:pokedex_app/consts/consts_app.dart';

class PokeItem extends StatelessWidget {
  final String name;
  final int index;
  final Color color;
  final Widget image;
  final List<String> types;

  PokeItem({this.name, this.index, this.color, this.image, this.types});

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
          color: ConstsApp.getColorType(type: types[0]),
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Stack(
            children: <Widget>[
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
                child: Opacity(
                  opacity: 0.25,
                  child: Image.asset(
                    ConstsApp.whitePokeball,
                    height: 90,
                    width: 90,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: image,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
