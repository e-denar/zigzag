import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zigzag/domain/blocs/continent_bloc.dart';
import 'package:zigzag/domain/entities/continent.dart';

import 'continent_tile.dart';

class Master extends StatefulWidget {
  @override
  _MasterState createState() => _MasterState();
}

class _MasterState extends State<Master> {
  Stream<List<Continent>> _stream;
  Stream<ContinentBlocState> _state;

  ContinentBlocState _currentState;

  @override
  void initState() {
    super.initState();
    final bloc = Provider.of<ContinentBloc>(context, listen: false);
    _currentState = bloc.currentState;
    _stream = bloc.continents;
    _state = bloc.state;
  }

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height * 0.7;
    return Container(
      height: _height,
      padding: const EdgeInsets.fromLTRB(8, 20, 8, 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Continents',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: StreamBuilder<List<Continent>>(
              initialData: [],
              stream: _stream,
              builder: (context, continents) {
                if (continents.hasData) {
                  return ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: continents.data.length,
                    itemBuilder: (context, index) => ContinentTile(
                        continent: continents.data.elementAt(index),
                        onTap: () {
                          // Navigator.of(context).pushNamed(routeName,
                          // arguments: continents.data.elementAt(index));
                        }),
                  );
                }

                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

final _continent = {
  "updated": 1597498553917,
  "cases": 6456808,
  "todayCases": 8178,
  "deaths": 244948,
  "todayDeaths": 667,
  "recovered": 3521231,
  "todayRecovered": 5463,
  "active": 2690629,
  "critical": 24219,
  "casesPerOneMillion": 10949.96,
  "deathsPerOneMillion": 415.4,
  "tests": 77067493,
  "testsPerOneMillion": 130697.03,
  "population": 589665242,
  "continent": "North America",
  "activePerOneMillion": 4562.98,
  "recoveredPerOneMillion": 5971.58,
  "criticalPerOneMillion": 41.07,
  "continentInfo": {"lat": 31.6768272, "long": -146.4707474},
  "countries": [
    "Anguilla",
    "Antigua and Barbuda",
    "Aruba",
    "Bahamas",
    "Barbados",
    "Belize",
    "Bermuda",
    "British Virgin Islands",
    "Canada",
    "Caribbean Netherlands",
    "Cayman Islands",
    "Costa Rica",
    "Cuba",
    "Curaçao",
    "Dominica",
    "Dominican Republic",
    "El Salvador",
    "Greenland",
    "Grenada",
    "Guadeloupe",
    "Guatemala",
    "Haiti",
    "Honduras",
    "Jamaica",
    "Martinique",
    "Mexico",
    "Montserrat",
    "Nicaragua",
    "Panama",
    "Saint Kitts and Nevis",
    "Saint Lucia",
    "Saint Martin",
    "Saint Pierre Miquelon",
    "Saint Vincent and the Grenadines",
    "Sint Maarten",
    "St. Barth",
    "Trinidad and Tobago",
    "Turks and Caicos Islands",
    "USA"
  ]
};
