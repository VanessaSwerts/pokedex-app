import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:pokedex_app/models/pokeapi.dart';
import 'package:pokedex_app/stores/pokeapi_store.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

class PokeDetailPage extends StatefulWidget {
  final int index;

  PokeDetailPage({this.index});

  @override
  _PokeDetailPageState createState() => _PokeDetailPageState();
}

class _PokeDetailPageState extends State<PokeDetailPage> {  
  PageController _pageController;
  Pokemon pokemon;
  PokeApiStore  _pokeStore;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.index);
    _pokeStore = GetIt.instance<PokeApiStore>();
    pokemon = _pokeStore.getPokemon(widget.index);
  }

  @override
  Widget build(BuildContext context) {      
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
                controller: _pageController,
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
