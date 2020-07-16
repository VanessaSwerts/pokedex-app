import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:md2_tab_indicator/md2_tab_indicator.dart';
import 'package:pokedex_app/models/specie.dart';
import 'package:pokedex_app/stores/pokeapi_store.dart';
import 'package:pokedex_app/stores/pokeapiv2_store.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  PageController _pageController;
  PokeApiStore _pokeStore;
  PokeApiV2Store _pokeV2Store;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _pageController = PageController(initialPage: 0);
    _pokeStore = GetIt.instance<PokeApiStore>();
    _pokeV2Store = GetIt.instance<PokeApiV2Store>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(30),
          child: Observer(
            builder: (BuildContext context) {
              _pokeV2Store.getInfoPokemon(_pokeStore.pokeCurrent.name);
              _pokeV2Store.getInfoSpecie(_pokeStore.pokeCurrent.id.toString());
              return TabBar(
                onTap: (index) {
                  _pageController.animateToPage(
                    index,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
                controller: _tabController,
                labelStyle: TextStyle(
                  fontFamily: "Google",
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                indicatorSize: TabBarIndicatorSize.label,
                labelColor: _pokeStore.pokeColor,
                unselectedLabelColor: Color(0xff5f6368),
                isScrollable: true,
                indicator: MD2Indicator(
                    indicatorHeight: 3,
                    indicatorColor: _pokeStore.pokeColor,
                    indicatorSize: MD2IndicatorSize.normal),
                tabs: <Widget>[
                  Tab(
                    text: "Sobre",
                  ),
                  Tab(
                    text: "Evolução",
                  ),
                  Tab(
                    text: "Status",
                  ),
                ],
              );
            },
          ),
        ),
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          _tabController.animateTo(
            index,
            duration: Duration(milliseconds: 300),
          );
        },
        children: <Widget>[
          Container(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 30.0,
                vertical: 10.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Descrição:",
                    style: TextStyle(
                      fontFamily: "Google",
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Observer(builder: (_) {
                    Specie _specie = _pokeV2Store.specie;
                    return _specie != null
                        ? Text(
                          _specie.flavorTextEntries
                              .where((item) => item.language.name == 'en')
                              .first
                              .flavorText,
                          style: TextStyle(
                            //fontFamily: "Google",
                            fontSize: 14,
                          ),
                        )
                        : SizedBox(
                            width: 15,
                            height: 15,
                            child: Center(
                                child: CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation(_pokeStore.pokeColor),
                            )));
                  }),
                ],
              ),
            ),
          ),
          Container(
            color: Colors.green,
          ),
          Container(
            color: Colors.blue,
          ),
        ],
      ),
    );
  }
}
