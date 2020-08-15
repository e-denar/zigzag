import 'package:zigzag/data/constants.dart';
import 'package:zigzag/data/helpers/api_client.dart';
import 'package:zigzag/domain/entities/global_summary.dart';

class CovidRepository {
  final ApiClient _client;

  const CovidRepository({ApiClient client}) : _client = client;

  Future<GlobalSummary> fetchGlobalSummary({bool yesterday = false}) async {
    final url = globalSummaryURL + yesterday.toString();
    return GlobalSummary.fromJson(await _client.fetchJson(url));
  }
}
