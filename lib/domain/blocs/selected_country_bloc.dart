import 'dart:async';

import 'package:zigzag/domain/blocs/bloc.dart';

class SelectedCountryBloc extends Bloc {
  final StreamController<String> _selected = StreamController<String>();
  String defaultSelected = 'Philippines';

  SelectedCountryBloc() {
    selectCountry(defaultSelected);
  }

  Stream<String> get selectedCountry => _selected.stream;
  void selectCountry(String s) => _selected.add(s);

  @override
  void dispose() {
    _selected.close();
  }
}
