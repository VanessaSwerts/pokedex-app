// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokeapi_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PokeApiStore on _PokeApiStoreBase, Store {
  Computed<PokeAPI> _$pokeAPIComputed;

  @override
  PokeAPI get pokeAPI =>
      (_$pokeAPIComputed ??= Computed<PokeAPI>(() => super.pokeAPI,
              name: '_PokeApiStoreBase.pokeAPI'))
          .value;
  Computed<Pokemon> _$pokeCurrentComputed;

  @override
  Pokemon get pokeCurrent =>
      (_$pokeCurrentComputed ??= Computed<Pokemon>(() => super.pokeCurrent,
              name: '_PokeApiStoreBase.pokeCurrent'))
          .value;

  final _$_pokeAPIAtom = Atom(name: '_PokeApiStoreBase._pokeAPI');

  @override
  PokeAPI get _pokeAPI {
    _$_pokeAPIAtom.reportRead();
    return super._pokeAPI;
  }

  @override
  set _pokeAPI(PokeAPI value) {
    _$_pokeAPIAtom.reportWrite(value, super._pokeAPI, () {
      super._pokeAPI = value;
    });
  }

  final _$_pokeCurrentAtom = Atom(name: '_PokeApiStoreBase._pokeCurrent');

  @override
  Pokemon get _pokeCurrent {
    _$_pokeCurrentAtom.reportRead();
    return super._pokeCurrent;
  }

  @override
  set _pokeCurrent(Pokemon value) {
    _$_pokeCurrentAtom.reportWrite(value, super._pokeCurrent, () {
      super._pokeCurrent = value;
    });
  }

  final _$pokeColorAtom = Atom(name: '_PokeApiStoreBase.pokeColor');

  @override
  dynamic get pokeColor {
    _$pokeColorAtom.reportRead();
    return super.pokeColor;
  }

  @override
  set pokeColor(dynamic value) {
    _$pokeColorAtom.reportWrite(value, super.pokeColor, () {
      super.pokeColor = value;
    });
  }

  final _$currentPositionAtom = Atom(name: '_PokeApiStoreBase.currentPosition');

  @override
  int get currentPosition {
    _$currentPositionAtom.reportRead();
    return super.currentPosition;
  }

  @override
  set currentPosition(int value) {
    _$currentPositionAtom.reportWrite(value, super.currentPosition, () {
      super.currentPosition = value;
    });
  }

  final _$favPokeAtom = Atom(name: '_PokeApiStoreBase.favPoke');

  @override
  List<String> get favPoke {
    _$favPokeAtom.reportRead();
    return super.favPoke;
  }

  @override
  set favPoke(List<String> value) {
    _$favPokeAtom.reportWrite(value, super.favPoke, () {
      super.favPoke = value;
    });
  }

  final _$_PokeApiStoreBaseActionController =
      ActionController(name: '_PokeApiStoreBase');

  @override
  dynamic fetchPokemonList() {
    final _$actionInfo = _$_PokeApiStoreBaseActionController.startAction(
        name: '_PokeApiStoreBase.fetchPokemonList');
    try {
      return super.fetchPokemonList();
    } finally {
      _$_PokeApiStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setCurrentPokemon(int index) {
    final _$actionInfo = _$_PokeApiStoreBaseActionController.startAction(
        name: '_PokeApiStoreBase.setCurrentPokemon');
    try {
      return super.setCurrentPokemon(index);
    } finally {
      _$_PokeApiStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setFavPoke() {
    final _$actionInfo = _$_PokeApiStoreBaseActionController.startAction(
        name: '_PokeApiStoreBase.setFavPoke');
    try {
      return super.setFavPoke();
    } finally {
      _$_PokeApiStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  Widget getPokemonImage(String index) {
    final _$actionInfo = _$_PokeApiStoreBaseActionController.startAction(
        name: '_PokeApiStoreBase.getPokemonImage');
    try {
      return super.getPokemonImage(index);
    } finally {
      _$_PokeApiStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
pokeColor: ${pokeColor},
currentPosition: ${currentPosition},
favPoke: ${favPoke},
pokeAPI: ${pokeAPI},
pokeCurrent: ${pokeCurrent}
    ''';
  }
}
