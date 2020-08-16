import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:zigzag/domain/blocs/bloc.dart';

class ThemeBloc extends Bloc {
  final StreamController<ThemeData> _theme = StreamController<ThemeData>();
  get theme => _theme.stream;

  void randomBgColor() => _theme.add(ThemeData(
        backgroundColor: Color.fromRGBO(
          0,
          Random().nextInt(150),
          Random().nextInt(150),
          1,
        ),
        primarySwatch: Colors.amber,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ));

  @override
  void dispose() {
    _theme.close();
  }
}
