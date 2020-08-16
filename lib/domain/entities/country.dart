import 'package:equatable/equatable.dart';

class Country extends Equatable {
  final String name, flag;
  final int cases,
      todayDeaths,
      todayCases,
      deaths,
      recovered,
      todayRecovered,
      active,
      critical;
  final DateTime updated;

  const Country(
      {this.name,
      this.cases,
      this.todayDeaths,
      this.todayCases,
      this.deaths,
      this.recovered,
      this.todayRecovered,
      this.active,
      this.critical,
      this.updated,
      this.flag});

  factory Country.fromJson(Map<String, dynamic> json) => Country(
        name: json['country'],
        cases: json['cases'],
        updated: DateTime.fromMillisecondsSinceEpoch(json['updated']),
        todayCases: json['todayCases'],
        deaths: json['deaths'],
        todayDeaths: json['todayDeaths'],
        recovered: json['recovered'],
        todayRecovered: json['todayRecovered'],
        active: json['active'],
        critical: json['critical'],
        flag: json['countryInfo']['flag'] ?? '',
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
        updated
      ];
  double get casesIncreasedBy => (todayCases / cases) * 100;
  double get deathsIncreasedBy => (todayDeaths / deaths) * 100;
  double get recoveriesIncreasedBy => (todayRecovered / recovered) * 100;
}
