import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:pokedex_app/models/pokeapiv2.dart';
import 'package:pokedex_app/stores/pokeapiv2_store.dart';

class AbaStatus extends StatelessWidget {
  final PokeApiV2Store _pokeV2Store = GetIt.instance<PokeApiV2Store>();

  List<int> getStatusPoke(PokeApiV2 pokeApiV2) {
    List<int> list = [1, 2, 3, 4, 5, 6, 7];
    int sum = 0;
    pokeApiV2.stats.forEach((f) {
      sum += f.baseStat;
      switch (f.stat.name) {
        case "speed":
          list[0] = f.baseStat;
          break;
        case "special-defense":
          list[1] = f.baseStat;
          break;
        case "special-attack":
          list[2] = f.baseStat;
          break;
        case "defense":
          list[3] = f.baseStat;
          break;
        case "attack":
          list[4] = f.baseStat;
          break;
        case "hp":
          list[5] = f.baseStat;
          break;
      }
    });
    list[6] = sum;

    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 30.0,
          vertical: 30.0,
        ),
        child: Observer(
          builder: (BuildContext context) {
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Speed:",
                        style: TextStyle(
                          fontFamily: "Google",
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        "Sp. Def:",
                        style: TextStyle(
                          fontFamily: "Google",
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        "Sp. Att:",
                        style: TextStyle(
                          fontFamily: "Google",
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        "Defense:",
                        style: TextStyle(
                          fontFamily: "Google",
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        "Attack:",
                        style: TextStyle(
                          fontFamily: "Google",
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        "HP:",
                        style: TextStyle(
                          fontFamily: "Google",
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        "Total:",
                        style: TextStyle(
                          fontFamily: "Google",
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  Observer(builder: (_) {
                    List<int> _list = getStatusPoke(_pokeV2Store.pokeApiV2);
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          _list[0].toString(),
                          style: TextStyle(
                            fontFamily: "Google",
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          _list[1].toString(),
                          style: TextStyle(
                            fontFamily: "Google",
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          _list[2].toString(),
                          style: TextStyle(
                            fontFamily: "Google",
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          _list[3].toString(),
                          style: TextStyle(
                            fontFamily: "Google",
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          _list[4].toString(),
                          style: TextStyle(
                            fontFamily: "Google",
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          _list[5].toString(),
                          style: TextStyle(
                            fontFamily: "Google",
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          _list[6].toString(),
                          style: TextStyle(
                            fontFamily: "Google",
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    );
                  }),
                  SizedBox(
                    width: 10.0,
                  ),
                  Observer(builder: (context) {
                    List<int> _list = getStatusPoke(_pokeV2Store.pokeApiV2);
                    return Column(
                      children: <Widget>[
                        StatusBar(
                          widthFactor: _list[0] / 160,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        StatusBar(
                          widthFactor: _list[1] / 160,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        StatusBar(
                          widthFactor: _list[2] / 160,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        StatusBar(
                          widthFactor: _list[3] / 160,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        StatusBar(
                          widthFactor: _list[4] / 160,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        StatusBar(
                          widthFactor: _list[5] / 160,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        StatusBar(
                          widthFactor: _list[6] / 600,
                        ),
                      ],
                    );
                  }),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class StatusBar extends StatelessWidget {
  final double widthFactor;

  StatusBar({Key key, this.widthFactor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20,
      child: Center(
        child: Container(
          height: 4,
          width: MediaQuery.of(context).size.width * .45,
          alignment: Alignment.centerLeft,
          decoration: ShapeDecoration(
            shape: StadiumBorder(),
            color: Colors.grey,
          ),
          child: FractionallySizedBox(
            widthFactor: widthFactor,
            heightFactor: 1.0,
            child: Container(
              decoration: ShapeDecoration(
                shape: StadiumBorder(),
                color: widthFactor > 0.5 ? Colors.teal : Colors.red,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
