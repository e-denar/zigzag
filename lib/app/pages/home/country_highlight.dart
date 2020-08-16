import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:zigzag/domain/blocs/country_bloc.dart';

import 'package:zigzag/domain/entities/country.dart';
import 'package:zigzag/app/widgets/incrementing_text.dart';
import 'package:zigzag/app/widgets/moving_widget.dart';
import 'package:zigzag/data/repositories/covid_repository.dart';
import 'package:zigzag/domain/blocs/selected_country_bloc.dart';
import 'package:zigzag/domain/blocs/theme_bloc.dart';

class CountryHighlight extends StatefulWidget {
  @override
  _CountryHighlightState createState() => _CountryHighlightState();
}

class _CountryHighlightState extends State<CountryHighlight> {
  Stream<String> _selected;
  CovidRepository repo;
  CountryBloc _bloc;

  @override
  void initState() {
    super.initState();
    final bloc = Provider.of<SelectedCountryBloc>(context, listen: false);
    _bloc = Provider.of<CountryBloc>(context, listen: false);
    _selected = bloc.selectedCountry;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
        initialData: 'Philippines',
        stream: _selected,
        builder: (context, selected) {
          _bloc.fetchSpecificCountry(selected.data);
          return StreamBuilder<Country>(
            initialData: Country(name: selected.data, cases: 0, todayCases: 0),
            stream: _bloc.country,
            builder: (context, snapshot) {
              final country = snapshot.data;
              return AnimatedContainer(
                duration: Duration(milliseconds: 200),
                height: MediaQuery.of(context).size.height * 0.3,
                child: Stack(
                  children: [
                    Positioned.fill(child: Container()),
                    _title(country),
                    _info(),
                    _cases(country),
                    _covidIcon(),
                  ],
                ),
              );
            },
          );
        });
  }

  MovingWidget _covidIcon() {
    return MovingWidget(
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Icon(
          MdiIcons.virus,
          color: Colors.red,
          size: 180,
        ),
      ),
      begin: RelativeRect.fromLTRB(-200, 0, 0, -200),
      end: RelativeRect.fromLTRB(-50, 0, 0, -50),
      // begin: RelativeRect.fromLTRB(0, 0, 0, 0),
      // end: RelativeRect.fromLTRB(0, 0, 0, 0),
    );
  }

  MovingWidget _cases(Country country) {
    return MovingWidget(
      begin: RelativeRect.fromLTRB(0, 0, -50, 0),
      end: RelativeRect.fromLTRB(0, 0, 20, 0),
      child: Align(
        alignment: Alignment.centerRight,
        child: Container(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            IncrementingText(
              count: country.todayCases,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 48),
            ),
            Text(
              'Cases Today',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ],
        )),
      ),
    );
  }

  MovingWidget _info() {
    return MovingWidget(
      begin: RelativeRect.fromLTRB(0, -50, -50, 0),
      end: RelativeRect.fromLTRB(0, 0, 0, 0),
      child: Align(
        alignment: Alignment.topRight,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Icon(
            Icons.info,
            color: Colors.white.withOpacity(0.6),
          ),
        ),
      ),
    );
  }

  MovingWidget _title(Country country) {
    return MovingWidget(
      begin: RelativeRect.fromLTRB(0, -100, 0, 0),
      end: RelativeRect.fromLTRB(0, 0, 0, 0),
      child: Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            country.name,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w300,
              fontSize: 24,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
