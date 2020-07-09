import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:pokedex_app/consts/consts_app.dart';
import 'package:pokedex_app/models/pokeapi.dart';
import 'package:pokedex_app/stores/pokeapi_store.dart';
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
  MultiTrackTween _animation;
  double _progress;
  double _multiple;
  double _opacity;
  double _opacityTitleAppBar;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.index);
    _pokeStore = GetIt.instance<PokeApiStore>();
    pokemon = _pokeStore.getPokemon(widget.index);
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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: Observer(
          builder: (BuildContext context) {
            return AppBar(
              backgroundColor: _pokeStore.pokeColor,
              elevation: 0,
              title: Opacity(
                opacity: _opacityTitleAppBar,
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
                              opacity: _opacityTitleAppBar >= 0.2 ? 0.2 : 0.0,
                              child: Image.asset(
                                ConstsApp.whitePokeball,
                                height: 50,
                                width: 50,
                              ),
                            ),
                          );
                        }),
                    IconButton(
                      icon: Icon(
                        Icons.favorite_border,
                        color: Colors.white,
                      ),
                      onPressed: null,
                    ),
                  ],
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
              );
            },
          ),
          Opacity(
            opacity: _opacity,
            child: Padding(
              padding: EdgeInsets.only(
                  top: _opacityTitleAppBar == 1
                      ? 1000
                      : (MediaQuery.of(context).size.height * 0.11) -
                          _progress * 50),
              child: SizedBox(
                height: 200,
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    _pokeStore.setCurrentPokemon(index);
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
                                child: Hero(
                                  tag: " ", //_pokeItem.name + 'rotation',
                                  child: Opacity(
                                    opacity: 0.25,
                                    child: Image.asset(
                                      ConstsApp.whitePokeball,
                                      height: 270,
                                      width: 270,
                                    ),
                                  ),
                                ),
                              );
                            }),
                        Observer(builder: (_) {
                          return AnimatedPadding(
                            duration: Duration(milliseconds: 400),
                            curve: Curves.bounceInOut,
                            padding: EdgeInsets.all(
                              index == _pokeStore.currentPosition ? 0.0 : 60.0,
                            ),
                            child: Hero(
                              tag: _pokeItem.name,
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
}
