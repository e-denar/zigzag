import 'dart:async';

import 'package:zigzag/data/repositories/covid_repository.dart';
import 'package:zigzag/domain/blocs/bloc.dart';
import 'package:zigzag/domain/entities/continent.dart';

enum ContinentBlocState { INIT, LOADED }

class ContinentBloc extends Bloc {
  CovidRepository repo;

  final StreamController<List<Continent>> _continents =
      StreamController<List<Continent>>();
  final StreamController<ContinentBlocState> _state =
      StreamController<ContinentBlocState>.broadcast();

  Map<String, Continent> _data = {};

  ContinentBlocState _currentState;

  ContinentBloc({this.repo}) {
    _stateListener();
    _state.sink.add(ContinentBlocState.INIT);
  }

  Stream<List<Continent>> get continents => _continents.stream;
  Stream<ContinentBlocState> get state => _state.stream;
  ContinentBlocState get currentState => _currentState;

  init() async {
    await repo
        .getContinents()
        .then((continents) => continents.forEach((continent) {
              _data.putIfAbsent(continent.name, () => continent);
            }))
        .whenComplete(() {
      _state.sink.add(ContinentBlocState.LOADED);
      fetchContinents();
    });
  }

  _stateListener() async {
    _state.stream.listen((state) {
      if (state == ContinentBlocState.INIT) {
        init();
      }
      _currentState = state;
    });
  }

  Future<void> fetchContinents() async {
    _continents.sink.add(_data.values.toList());
  }

  @override
  void dispose() {
    _continents.close();
    _state.close();
  }
}
