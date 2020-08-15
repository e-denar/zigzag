import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:zigzag/data/constants.dart';
import 'package:zigzag/data/helpers/api_client.dart';
import 'package:zigzag/data/repositories/covid_repository.dart';
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

      expect(await repo.fetchGlobalSummary(), today);
    });

    test('Should return GlobalSummary for yesterday', () async {
      final mock = MockApiClient();
      final repo = CovidRepository(client: mock);
      when(mock.fetchJson(globalSummaryURL + true.toString()))
          .thenAnswer((realInvocation) => Future.value(yesterdayJson));

      expect(await repo.fetchGlobalSummary(yesterday: true), yesterday);
    });
  });
}
