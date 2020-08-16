import 'dart:async';

import 'package:zigzag/data/repositories/covid_repository.dart';
import 'package:zigzag/domain/blocs/bloc.dart';
import 'package:zigzag/domain/entities/country.dart';

enum CountryBlocState { INIT, LOADED }

class CountryBloc extends Bloc {
  CovidRepository repo;

  final StreamController<Country> _country = StreamController<Country>();
  final StreamController<Map<String, Country>> countriesController =
      StreamController<Map<String, Country>>.broadcast();
  final StreamController<CountryBlocState> _state =
      StreamController<CountryBlocState>.broadcast();

  Map<String, Country> _data = {};

  CountryBlocState _currentState;

  CountryBloc({this.repo}) {
    _stateListener();
    _state.sink.add(CountryBlocState.INIT);
  }

  Stream<Country> get country => _country.stream;
  Stream<Map<String, Country>> get countries => countriesController.stream;
  Stream<CountryBlocState> get state => _state.stream;
  CountryBlocState get currentState => _currentState;

  init() async {
    await repo
        .getCountries()
        .then((countries) => countries.forEach((country) {
              _data.putIfAbsent(country.name, () => country);
            }))
        .whenComplete(() async {
      _state.sink.add(CountryBlocState.LOADED);
      await fetchCountries();
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

  Future<void> fetchCountries({List<String> names}) async {
    countriesController.sink.add(_data);
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
    countriesController.close();
    _state.close();
  }
}
