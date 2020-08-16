import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:zigzag/data/constants.dart';
import 'package:zigzag/data/helpers/api_client.dart';
import 'package:zigzag/data/repositories/covid_repository.dart';
import 'package:zigzag/domain/entities/country.dart';
import 'package:zigzag/domain/entities/global_summary.dart';

class MockApiClient extends Mock implements ApiClient {}

void main() {
  group('CovidRepository', () {
    final todayJson = {
      "updated": 1597439738495,
      "cases": 21297252,
      "todayCases": 237975,
      "deaths": 761577,
      "todayDeaths": 4858,
      "recovered": 14076068,
      "todayRecovered": 156560,
      "active": 6459607,
      "critical": 64524,
      "tests": 380521464,
      "population": 7767238838,
      "affectedCountries": 215
    };
    final yesterdayJson = {
      "updated": 1597438540032,
      "cases": 21059277,
      "todayCases": 285486,
      "deaths": 756719,
      "todayDeaths": 6540,
      "recovered": 13919508,
      "todayRecovered": 214882,
      "active": 6383050,
      "critical": 64617,
      "tests": 381708144,
      "population": 7767238838,
      "affectedCountries": 215
    };

    GlobalSummary today = GlobalSummary.fromJson(todayJson);
    GlobalSummary yesterday = GlobalSummary.fromJson(yesterdayJson);

    test('Should return GlobalSummary for today', () async {
      final mock = MockApiClient();
      final repo = CovidRepository(client: mock);

      when(mock.fetchJson(globalSummaryURL + false.toString()))
          .thenAnswer((realInvocation) => Future.value(todayJson));

      expect(await repo.requestGlobalSummary(), today);
    });

    test('Should return GlobalSummary for yesterday', () async {
      final mock = MockApiClient();
      final repo = CovidRepository(client: mock);
      when(mock.fetchJson(globalSummaryURL + true.toString()))
          .thenAnswer((realInvocation) => Future.value(yesterdayJson));

      expect(await repo.requestGlobalSummary(), yesterday);
    });

    test('Should decode countries json correctly', () async {
      final mock = MockApiClient();
      final repo = CovidRepository(client: mock);
      when(mock.fetchJson(countriesSummaryURL))
          .thenAnswer((realInvocation) => Future.value(_countriesJson));
      final List<Country> expected =
          _countriesJson.values.map((e) => Country.fromJson(e)).toList();
      expect(await repo.getCountries(), expected);
    });
  });
}

final _countriesJson = {
  '0': {
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
  '1': {
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
  // {
  //   "updated": 1597571435039,
  //   "country": "India",
  //   "countryInfo": {
  //     "_id": 356,
  //     "iso2": "IN",
  //     "iso3": "IND",
  //     "lat": 20,
  //     "long": 77,
  //     "flag": "https://disease.sh/assets/img/flags/in.png"
  //   },
  //   "cases": 2589208,
  //   "todayCases": 63986,
  //   "deaths": 50084,
  //   "todayDeaths": 950,
  //   "recovered": 1860672,
  //   "todayRecovered": 53116,
  //   "active": 678452,
  //   "critical": 8944,
  //   "casesPerOneMillion": 1874,
  //   "deathsPerOneMillion": 36,
  //   "tests": 28563095,
  //   "testsPerOneMillion": 20673,
  //   "population": 1381678359,
  //   "continent": "Asia",
  //   "oneCasePerPeople": 534,
  //   "oneDeathPerPeople": 27587,
  //   "oneTestPerPeople": 48,
  //   "activePerOneMillion": 491.03,
  //   "recoveredPerOneMillion": 1346.68,
  //   "criticalPerOneMillion": 6.47
  // },
  // {
  //   "updated": 1597571435040,
  //   "country": "Russia",
  //   "countryInfo": {
  //     "_id": 643,
  //     "iso2": "RU",
  //     "iso3": "RUS",
  //     "lat": 60,
  //     "long": 100,
  //     "flag": "https://disease.sh/assets/img/flags/ru.png"
  //   },
  //   "cases": 917884,
  //   "todayCases": 5061,
  //   "deaths": 15617,
  //   "todayDeaths": 119,
  //   "recovered": 729411,
  //   "todayRecovered": 6447,
  //   "active": 172856,
  //   "critical": 2300,
  //   "casesPerOneMillion": 6289,
  //   "deathsPerOneMillion": 107,
  //   "tests": 32221546,
  //   "testsPerOneMillion": 220783,
  //   "population": 145942457,
  //   "continent": "Europe",
  //   "oneCasePerPeople": 159,
  //   "oneDeathPerPeople": 9345,
  //   "oneTestPerPeople": 5,
  //   "activePerOneMillion": 1184.41,
  //   "recoveredPerOneMillion": 4997.94,
  //   "criticalPerOneMillion": 15.76
  // },
};
