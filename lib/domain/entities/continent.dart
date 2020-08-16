import 'package:equatable/equatable.dart';

class Continent extends Equatable {
  final String name;
  final int cases,
      todayDeaths,
      todayCases,
      deaths,
      recovered,
      todayRecovered,
      active,
      critical;
  final DateTime updated;
  final List<String> countries;

  const Continent({
    this.name,
    this.cases,
    this.todayDeaths,
    this.todayCases,
    this.deaths,
    this.recovered,
    this.todayRecovered,
    this.active,
    this.critical,
    this.updated,
    this.countries,
  });

  factory Continent.fromJson(Map<String, dynamic> json) => Continent(
        name: json['continent'],
        cases: json['cases'],
        updated: DateTime.fromMillisecondsSinceEpoch(json['updated']),
        todayCases: json['todayCases'],
        deaths: json['deaths'],
        todayDeaths: json['todayDeaths'],
        recovered: json['recovered'],
        todayRecovered: json['todayRecovered'],
        active: json['active'],
        critical: json['critical'],
        countries: List<String>.from(json['countries']),
      );

  @override
  List<Object> get props => [
        name,
        cases,
        todayDeaths,
        todayCases,
        deaths,
        recovered,
        todayRecovered,
        active,
        critical,
        updated,
        countries,
      ];

  double get casesIncreasedBy => (todayCases / cases) * 100;
  double get deathsIncreasedBy => (todayDeaths / deaths) * 100;
  double get recoveriesIncreasedBy => (todayRecovered / recovered) * 100;
}
