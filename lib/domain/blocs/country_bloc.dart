import 'dart:async';

import 'package:zigzag/data/repositories/covid_repository.dart';
import 'package:zigzag/domain/blocs/bloc.dart';
import 'package:zigzag/domain/entities/country.dart';

enum CountryBlocState { INIT, LOADED }

class CountryBloc extends Bloc {
  CovidRepository repo;

  final StreamController<Country> _country = StreamController<Country>();
  final StreamController<List<Country>> _countries =
      StreamController<List<Country>>();
  final StreamController<CountryBlocState> _state =
      StreamController<CountryBlocState>.broadcast();

  Map<String, Country> _data = {};

  CountryBlocState _currentState;

  CountryBloc({this.repo}) {
    _stateListener();
    _state.sink.add(CountryBlocState.INIT);
  }

  Stream<Country> get country => _country.stream;
  Stream<List<Country>> get countries => _countries.stream;
  Stream<CountryBlocState> get state => _state.stream;
  CountryBlocState get currentState => _currentState;

  init() async {
    await repo
        .getCountries()
        .then((countries) => countries.forEach((country) {
              _data.putIfAbsent(country.name, () => country);
            }))
        .whenComplete(() {
      _state.sink.add(CountryBlocState.LOADED);
      fetchCountries();
    });
  }

  _stateListener() async {
    _state.stream.listen((state) {
      if (state == CountryBlocState.INIT) {
        init();
      }
      _currentState = state;
    });
  }

  Future<void> fetchCountries() async {
    _countries.sink.add(_data.values.toList());
  }

  Future<void> fetchSpecificCountry(String name) async {
    if (_currentState == CountryBlocState.LOADED) {
      _country.sink.add(_data[name]);
    } else {
      final country = await repo.requestSpecificCountry(country: name);
      _country.sink.add(country);
    }
  }

  @override
  void dispose() {
    _country.close();
    _countries.close();
    _state.close();
  }
}
