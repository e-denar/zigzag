import 'package:zigzag/data/constants.dart';
import 'package:zigzag/data/helpers/api_client.dart';
import 'package:zigzag/domain/entities/continent.dart';
import 'package:zigzag/domain/entities/country.dart';
import 'package:zigzag/domain/entities/global_summary.dart';

class CovidRepository {
  ApiClient _client;

  static final CovidRepository _inst = CovidRepository._internal();

  CovidRepository._internal();

  factory CovidRepository({ApiClient client}) {
    _inst._client = client;
    return _inst;
  }

  Future<GlobalSummary> requestGlobalSummary() async {
    final url = globalSummaryURL;
    return GlobalSummary.fromJson(await _client.fetchJson(url));
  }

  Future<Country> requestSpecificCountry(
      {String country = 'Philippines'}) async {
    // default to yesterday because todays data is sometimes not available
    final url = 'countries/$country?yesterday=true&strict=true&allowNull=false';
    return Country.fromJson(await _client.fetchJson(url));
  }

  Future<Country> requestContinentSummary(
      {String country = 'Philippines'}) async {
    // default to yesterday because todays data is sometimes not available
    final url = 'countries/$country?yesterday=true&strict=true&allowNull=false';
    return Country.fromJson(await _client.fetchJson(url));
  }

  Future<List<Country>> getCountries() async {
    List<Country> toReturn = [];

    final json = await _client.fetchJson(countriesSummaryURL);
    final data = List<Map<String, dynamic>>.from(json);

    data.forEach((e) {
      toReturn.add(Country.fromJson(e));
    });
    return toReturn;
  }

  Future<List<Continent>> getContinents() async {
    List<Continent> toReturn = [];

    final json = await _client.fetchJson(continentsSummaryURL);
    final data = List<Map<String, dynamic>>.from(json);

    data.forEach((e) {
      toReturn.add(Continent.fromJson(e));
    });
    return toReturn;
  }
}
