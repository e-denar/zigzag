import 'dart:async';

import 'package:zigzag/domain/blocs/bloc.dart';

class SelectedCountryBloc extends Bloc {
  final StreamController<String> _selected =
      StreamController<String>.broadcast();
  String defaultSelected = 'Philippines';

  String currentSelected;

  SelectedCountryBloc() {
    _selected.stream.listen((event) {
      currentSelected = event;
    });
    selectCountry(defaultSelected);
  }

  Stream<String> get selectedCountry => _selected.stream;
  void selectCountry(String s) => _selected.add(s);

  @override
  void dispose() {
    _selected.close();
  }
}
