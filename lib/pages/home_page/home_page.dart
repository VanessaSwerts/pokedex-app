import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:pokedex_app/consts/consts_app.dart';
import 'package:pokedex_app/models/pokeapi.dart';
import 'package:pokedex_app/pages/home_page/widgets/appbar_home.dart';
import 'package:pokedex_app/pages/home_page/widgets/pokeItem.dart';
import 'package:pokedex_app/pages/poke_detail/poke_detail_page.dart';
import 'package:pokedex_app/stores/pokeapi_store.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final pokeStore = Provider.of<PokeApiStore>(context);
    if (pokeStore.pokeAPI == null) {
      pokeStore.fetchPokemonList();
    }
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
                        PokeAPI _pokeApi = pokeStore.pokeAPI;
                        return (_pokeApi == null)
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : AnimationLimiter(
                                child: GridView.builder(
                                  physics: BouncingScrollPhysics(),
                                  padding: EdgeInsets.all(12),
                                  addAutomaticKeepAlives: true,
                                  gridDelegate:
                                      new SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2),
                                  itemCount: pokeStore.pokeAPI.pokemon.length,
                                  itemBuilder: (context, index) {
                                    Pokemon pokemon =
                                        pokeStore.getPokemon(index);
                                    return AnimationConfiguration.staggeredGrid(
                                      position: index,
                                      duration:
                                          const Duration(milliseconds: 375),
                                      columnCount: 2,
                                      child: ScaleAnimation(
                                        child: GestureDetector(
                                          child: PokeItem(
                                            index: index,
                                            name: pokemon.name,
                                            number: pokemon.num,
                                            types: pokemon.type,
                                          ),
                                          onTap: () {
                                            pokeStore.setCurrentPokemon(index);
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        PokeDetailPage(
                                                  index: index,
                                                ),
                                                fullscreenDialog: true,
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
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
