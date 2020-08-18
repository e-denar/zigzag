import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:zigzag/data/constants.dart';
import 'package:zigzag/data/helpers/api_client.dart';
import 'package:zigzag/data/repositories/covid_repository.dart';
import 'package:zigzag/domain/entities/country.dart';

class MockApiClient extends Mock implements ApiClient {}

void main() {
  group('CovidRepository', () {
    test('Should decode countries json correctly', () async {
      final mock = MockApiClient();
      final repo = CovidRepository(client: mock);
      when(mock.fetchJson(countriesSummaryURL))
          .thenAnswer((realInvocation) => Future.value(_countriesJson));
      final List<Country> expected =
          _countriesJson.map((e) => Country.fromJson(e)).toList();
      expect(await repo.getCountries(), expected);
    });
  });
}

final _countriesJson = [
  {
    "updated": 1597571435038,
    "country": "USA",
    "countryInfo": {
      "_id": 840,
      "iso2": "US",
      "iso3": "USA",
      "lat": 38,
      "long": -97,
      "flag": "https://disease.sh/assets/img/flags/us.png"
    },
    "cases": 5529789,
    "todayCases": 53523,
    "deaths": 172606,
    "todayDeaths": 1071,
    "recovered": 2900188,
    "todayRecovered": 25041,
    "active": 2456995,
    "critical": 17186,
    "casesPerOneMillion": 16694,
    "deathsPerOneMillion": 521,
    "tests": 70224673,
    "testsPerOneMillion": 212002,
    "population": 331245770,
    "continent": "North America",
    "oneCasePerPeople": 60,
    "oneDeathPerPeople": 1919,
    "oneTestPerPeople": 5,
    "activePerOneMillion": 7417.44,
    "recoveredPerOneMillion": 8755.4,
    "criticalPerOneMillion": 51.88
  },
  {
    "updated": 1597571435039,
    "country": "Brazil",
    "countryInfo": {
      "_id": 76,
      "iso2": "BR",
      "iso3": "BRA",
      "lat": -10,
      "long": -55,
      "flag": "https://disease.sh/assets/img/flags/br.png"
    },
    "cases": 3317832,
    "todayCases": 38937,
    "deaths": 107297,
    "todayDeaths": 726,
    "recovered": 2404272,
    "todayRecovered": 19970,
    "active": 806263,
    "critical": 8318,
    "casesPerOneMillion": 15595,
    "deathsPerOneMillion": 504,
    "tests": 13464336,
    "testsPerOneMillion": 63288,
    "population": 212747790,
    "continent": "South America",
    "oneCasePerPeople": 64,
    "oneDeathPerPeople": 1983,
    "oneTestPerPeople": 16,
    "activePerOneMillion": 3789.76,
    "recoveredPerOneMillion": 11301.04,
    "criticalPerOneMillion": 39.1
  },
];
