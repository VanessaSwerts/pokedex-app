import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pokedex_app/consts/consts_app.dart';
import 'package:pokedex_app/models/pokeapi.dart';
import 'package:pokedex_app/pages/home_page/widgets/appbar_home.dart';
import 'package:pokedex_app/stores/pokeapi_store.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PokeApiStore pokeApiStore;

  @override
  void initState() {
    super.initState();
    pokeApiStore = PokeApiStore();
    pokeApiStore.fetchPokemonList();
  }

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
                      child: Observer(builder: (_) {
                        PokeAPI _pokeApi = pokeApiStore.pokeAPI;
                        return (_pokeApi == null)
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : ListView.builder(
                                itemCount: _pokeApi.pokemon.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    title: Text(_pokeApi.pokemon[index].name),
                                  );
                                });
                      }),
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
