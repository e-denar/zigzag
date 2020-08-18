import 'package:zigzag/data/constants.dart';
import 'package:zigzag/data/helpers/api_client.dart';
import 'package:zigzag/domain/entities/continent.dart';
import 'package:zigzag/domain/entities/country.dart';

class CovidRepository {
  ApiClient _client;

  static final CovidRepository _inst = CovidRepository._internal();

  CovidRepository._internal();

  factory CovidRepository({ApiClient client}) {
    _inst._client = client;
    return _inst;
  }

  Future<Country> requestSpecificCountry(
      {String country = 'Philippines'}) async {
    // default to yesterday because todays data is sometimes not available
    final url = 'countries/$country?yesterday=true&strict=true&allowNull=false';
    return Country.fromJson(await _client.fetchJson(url));
  }

  Future<List<Country>> getCountries() async {
    final json = await _client.fetchJson(countriesSummaryURL);
    return List<Country>.from(json.map((e) => Country.fromJson(e)).toList());
  }

  Future<List<Continent>> getContinents() async {
    final json = await _client.fetchJson(continentsSummaryURL);
    return List<Continent>.from(
        json.map((e) => Continent.fromJson(e)).toList());
  }
}
