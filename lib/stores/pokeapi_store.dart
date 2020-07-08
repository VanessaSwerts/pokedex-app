import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:pokedex_app/consts/consts_api.dart';
import 'package:pokedex_app/consts/consts_app.dart';
import 'package:pokedex_app/models/pokeapi.dart';
import 'package:http/http.dart' as http;

part 'pokeapi_store.g.dart';

class PokeApiStore = _PokeApiStoreBase with _$PokeApiStore;

abstract class _PokeApiStoreBase with Store {
  @observable
  PokeAPI _pokeAPI;

  @observable
  Pokemon _pokeCurrent;

  @observable
  dynamic pokeColor;

  @computed
  PokeAPI get pokeAPI => _pokeAPI;

  @computed
  Pokemon get pokeCurrent => _pokeCurrent;   

  @action
  fetchPokemonList() {
    _pokeAPI = null;
    loadPokeAPI().then((pokeList) {
      _pokeAPI = pokeList;
    });
  } 

  @action
  setCurrentPokemon(int index) {
    _pokeCurrent = _pokeAPI.pokemon[index];
    pokeColor = ConstsApp.getColorType(type: _pokeCurrent.type[0]);    
  }  

  @action
  Widget getPokemonImage(String index) {
    return CachedNetworkImage(
        placeholder: (context, url) => Container(
              color: Colors.transparent,
            ),
        imageUrl:
            "https://raw.githubusercontent.com/fanzeyi/pokemon.json/master/images/$index.png");
  }

  Pokemon getPokemon(int index) {
    return _pokeAPI.pokemon[index];
  }  

  Future<PokeAPI> loadPokeAPI() async {
    try {
      final response = await http.get(ConstsAPI.pokeApiURL);
      var decodeJson = jsonDecode(response.body);
      return PokeAPI.fromJson(decodeJson);
    } catch (error, stacktrace) {
      print("Erro ao carregar lista!" + stacktrace.toString());
      return null;
    }
  }
}
