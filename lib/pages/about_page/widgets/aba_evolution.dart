import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:pokedex_app/models/pokeapi.dart';
import 'package:pokedex_app/stores/pokeapi_store.dart';

class AbaEvolution extends StatelessWidget {
  final PokeApiStore _pokeStore = GetIt.instance<PokeApiStore>();

  Widget resizePoke(Widget pokeImg) {
    return SizedBox(
      height: 80,
      width: 80,
      child: pokeImg,
    );
  }

  List<Widget> getEvolution(Pokemon pokemon) {
    List<Widget> _list = [];
    if (pokemon.prevEvolution != null) {
      pokemon.prevEvolution.forEach((f) {
        _list.add(
          resizePoke(
            _pokeStore.getPokemonImage(f.num),
          ),
        );
        _list.add(
          SizedBox(
            height: 10,
          ),
        );
        _list.add(
          Text(
            f.name,
            style: TextStyle(
              fontFamily: "Google",
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
        _list.add(Icon(Icons.keyboard_arrow_down));
      });
    }

    _list.add(
      resizePoke(
        _pokeStore.getPokemonImage(_pokeStore.pokeCurrent.num),
      ),
    );
    _list.add(
      Text(
        _pokeStore.pokeCurrent.name,
        style: TextStyle(
          fontFamily: "Google",
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );

    if (pokemon.nextEvolution != null) {
      _list.add(Icon(Icons.keyboard_arrow_down));
      pokemon.nextEvolution.forEach((f) {
        _list.add(
          resizePoke(
            _pokeStore.getPokemonImage(f.num),
          ),
        );
        _list.add(
          Text(
            f.name,
            style: TextStyle(
              fontFamily: "Google",
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
        if (pokemon.nextEvolution.last.name != f.name) {
          _list.add(Icon(Icons.keyboard_arrow_down));
        }
      });
    }

    return _list;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 30.0,
          vertical: 30.0,
        ),
        child: Observer(builder: (_) {
          Pokemon pokemon = _pokeStore.pokeCurrent;
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: getEvolution(pokemon),
            ),
          );
        }),
      ),
    );
  }
}
