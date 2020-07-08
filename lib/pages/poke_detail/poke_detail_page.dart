import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pokedex_app/consts/consts_app.dart';
import 'package:pokedex_app/models/pokeapi.dart';
import 'package:pokedex_app/stores/pokeapi_store.dart';
import 'package:provider/provider.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

class PokeDetailPage extends StatelessWidget {
  final int index;
  Color colorPoke;
  PokeDetailPage({this.index});

  @override
  Widget build(BuildContext context) {
    final _pokeStore = Provider.of<PokeApiStore>(context);
    Pokemon pokemon = _pokeStore.getPokemon(index);
    colorPoke = ConstsApp.getColorType(type: pokemon.type[0]);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: Observer(
          builder: (BuildContext context) {
            return AppBar(
              backgroundColor: _pokeStore.pokeColor,
              elevation: 0,
              title: Opacity(
                opacity: 1.0,
                child: Text(
                  _pokeStore.pokeCurrent.name,
                  style: TextStyle(
                    fontFamily: "Google",
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              centerTitle: true,
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.favorite_border),
                  onPressed: null,
                ),
              ],
            );
          },
        ),
      ),
      body: Stack(
        children: <Widget>[
          Observer(
            builder: (context) {
              return Container(color: _pokeStore.pokeColor);
            },
          ),
          Container(
            height: MediaQuery.of(context).size.height / 0.3,
          ),
          SlidingSheet(
            elevation: 0,
            cornerRadius: 16,
            snapSpec: const SnapSpec(
              snap: true,
              snappings: [0.6, 1.0],
              positioning: SnapPositioning.relativeToAvailableSpace,
            ),
            builder: (context, state) {
              return Container(
                height: MediaQuery.of(context).size.height,
              );
            },
          ),
          Padding(
            padding: EdgeInsets.only(top: 50),
            child: SizedBox(
              height: 150,
              child: PageView.builder(
                onPageChanged: (index) {
                  _pokeStore.setCurrentPokemon(index);                  
                },
                itemCount: _pokeStore.pokeAPI.pokemon.length,
                itemBuilder: (BuildContext context, int count) {                                   
                  Pokemon _pokeItem = _pokeStore.getPokemon(count);
                  return CachedNetworkImage(
                    height: 60,
                    width: 60,
                    placeholder: (context, url) => Container(
                      color: Colors.transparent,
                    ),
                    imageUrl:
                        "https://raw.githubusercontent.com/fanzeyi/pokemon.json/master/images/${_pokeItem.num}.png",
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
