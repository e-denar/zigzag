import '../../../lib/data/constants.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:zigzag/data/helpers/api_client.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

class MockHttpClient extends Mock implements http.Client {}

void main() {
  group('ApiClient', () {
    final mock = MockHttpClient();
    final client = ApiClient(client: mock);

    test('should return data when response is OK', () async {
      final someURL = 'someUrl/someEndPoint';
      final mockData = '''{"someData": "someData"}''';

      when(mock.get('$baseURL/$someURL')).thenAnswer(
          (_) => Future.value(http.Response(mockData.toString(), OK_RESPONSE)));

      expect(await client.fetchJson(someURL), {'someData': 'someData'});
    });

    test('should throw exception when response is NOK', () async {
      final someURL = 'someUrl/someEndPoint';
      final mockData =
          '''{"_id": "123", "quoteText": "abc", "quoteAuthor": "-"}''';

      when(mock.get('$baseURL/$someURL'))
          .thenAnswer((_) => Future.value(http.Response(mockData, 199)));

      expectLater(client.fetchJson(someURL), throwsException);
    });
  });
}
