import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:pokedex_app/consts/consts_app.dart';
import 'package:pokedex_app/models/pokeapi.dart';
import 'package:pokedex_app/pages/about_page/about_page.dart';
import 'package:pokedex_app/stores/pokeapi_store.dart';
import 'package:pokedex_app/stores/pokeapiv2_store.dart';
import 'package:simple_animations/simple_animations/controlled_animation.dart';
import 'package:simple_animations/simple_animations/multi_track_tween.dart';
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
  PokeApiStore _pokeStore;
  PokeApiV2Store _pokeV2Store;
  MultiTrackTween _animation;
  double _progress;
  double _multiple;
  double _opacity;
  double _opacityTitleAppBar;

  @override
  void initState() {
    super.initState();
    _pageController =
        PageController(initialPage: widget.index, viewportFraction: 0.5);
    _pokeStore = GetIt.instance<PokeApiStore>();
    _pokeV2Store = GetIt.instance<PokeApiV2Store>();
    _pokeV2Store.getInfoPokemon(_pokeStore.pokeCurrent.name);
    _pokeV2Store.getInfoSpecie(_pokeStore.pokeCurrent.id.toString());
    _animation = MultiTrackTween([
      Track("rotation").add(Duration(seconds: 5), Tween(begin: 0.0, end: 6.0),
          curve: Curves.linear)
    ]);
    _progress = 0;
    _multiple = 1;
    _opacity = 1;
    _opacityTitleAppBar = 0;
  }

  double interval(double lower, double upper, double progress) {
    assert(lower < upper);

    if (progress > upper) return 1.0;
    if (progress < lower) return 0.0;

    return ((progress - lower) / (upper - lower)).clamp(0.0, 1.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Observer(
            builder: (context) {
              return AnimatedContainer(
                color: _pokeStore.pokeColor,
                duration: Duration(milliseconds: 300),
                child: Stack(
                  children: <Widget>[
                    AppBar(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      leading: IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      actions: <Widget>[
                        Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            ControlledAnimation(
                                playback: Playback.LOOP,
                                duration: _animation.duration,
                                tween: _animation,
                                builder: (context, animation) {
                                  return Transform.rotate(
                                    angle: animation['rotation'],
                                    child: Opacity(
                                      opacity: _opacityTitleAppBar >= 0.2
                                          ? 0.2
                                          : 0.0,
                                      child: Image.asset(
                                        ConstsApp.whitePokeball,
                                        height: 50,
                                        width: 50,
                                      ),
                                    ),
                                  );
                                }),
                            Observer(
                              builder: (BuildContext context) {
                                return IconButton(
                                  icon: _pokeStore.favPoke.isEmpty
                                      ? Icon(Icons.favorite_border,
                                          color: Colors.white)
                                      : Icon(
                                          !_pokeStore.favPoke.contains(
                                                  _pokeStore.pokeCurrent.num)
                                              ? Icons.favorite_border
                                              : Icons.favorite,
                                          color: !_pokeStore.favPoke.contains(
                                                  _pokeStore.pokeCurrent.num)
                                              ? Colors.white
                                              : Colors.red[300],                                          
                                        ),
                                  onPressed: _pokeStore.setFavPoke,
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                    Positioned(
                      top: MediaQuery.of(context).size.height * 0.11 -
                          _progress *
                              (MediaQuery.of(context).size.height * 0.060),
                      left: 20 +
                          _progress *
                              (MediaQuery.of(context).size.height * 0.060),
                      child: Text(
                        _pokeStore.pokeCurrent.name,
                        style: TextStyle(
                            fontFamily: 'Google',
                            fontSize: 38 -
                                _progress *
                                    (MediaQuery.of(context).size.height *
                                        0.011),
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    Positioned(
                      top: MediaQuery.of(context).size.height * 0.16,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, right: 20.0, top: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              setTypes(_pokeStore.pokeCurrent.type),
                              Text(
                                "#" + _pokeStore.pokeCurrent.num.toString(),
                                style: TextStyle(
                                    fontFamily: 'Google',
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          SlidingSheet(
            listener: (state) {
              setState(() {
                _progress = state.progress;
                _multiple = 1 - interval(0.60, 0.87, _progress);
                _opacity = _multiple;
                _opacityTitleAppBar = interval(0.60, 0.87, _progress);
              });
            },
            elevation: 0,
            cornerRadius: 30,
            snapSpec: const SnapSpec(
              snap: true,
              snappings: [0.60, 0.87],
              positioning: SnapPositioning.relativeToAvailableSpace,
            ),
            builder: (context, state) {
              return Container(
                height: MediaQuery.of(context).size.height,
                child: AboutPage(),
              );
            },
          ),
          Opacity(
            opacity: _opacity,
            child: Padding(
              padding: EdgeInsets.only(
                  top: _opacityTitleAppBar == 1
                      ? 1000
                      : (MediaQuery.of(context).size.height * 0.2) -
                          _progress * 50),
              child: SizedBox(
                height: 200,
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    _pokeStore.setCurrentPokemon(index);
                    _pokeV2Store.getInfoPokemon(_pokeStore.pokeCurrent.name);
                    _pokeV2Store
                        .getInfoSpecie(_pokeStore.pokeCurrent.id.toString());
                  },
                  itemCount: _pokeStore.pokeAPI.pokemon.length,
                  itemBuilder: (BuildContext context, int index) {
                    Pokemon _pokeItem = _pokeStore.getPokemon(index);
                    return Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        ControlledAnimation(
                            playback: Playback.LOOP,
                            duration: _animation.duration,
                            tween: _animation,
                            builder: (context, animation) {
                              return Transform.rotate(
                                angle: animation['rotation'],
                                child: Opacity(
                                  opacity: index == _pokeStore.currentPosition
                                      ? 0.2
                                      : 0,
                                  child: Image.asset(
                                    ConstsApp.whitePokeball,
                                    height: 270,
                                    width: 270,
                                  ),
                                ),
                              );
                            }),
                        IgnorePointer(
                          child: Observer(
                              name: "Pokemon",
                              builder: (_) {
                                return AnimatedPadding(
                                  duration: Duration(milliseconds: 400),
                                  curve: Curves.bounceInOut,
                                  padding: EdgeInsets.all(
                                    index == _pokeStore.currentPosition
                                        ? 0.0
                                        : 60.0,
                                  ),
                                  child: Hero(
                                    tag: index == _pokeStore.currentPosition
                                        ? _pokeItem.name
                                        : 'none' + index.toString(),
                                    child: CachedNetworkImage(
                                      height: 160,
                                      width: 160,
                                      placeholder: (context, url) => Container(
                                        color: Colors.transparent,
                                      ),
                                      color: index == _pokeStore.currentPosition
                                          ? null
                                          : Colors.black.withOpacity(0.5),
                                      imageUrl:
                                          "https://raw.githubusercontent.com/fanzeyi/pokemon.json/master/images/${_pokeItem.num}.png",
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget setTypes(List<String> types) {
    List<Widget> lista = [];
    types.forEach((name) {
      lista.add(
        Row(
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
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              width: 8,
            )
          ],
        ),
      );
    });
    return Row(
      children: lista,
      crossAxisAlignment: CrossAxisAlignment.start,
    );
  }
}
