import 'package:flutter_hackernews/src/resources/new_api_provider.dart';
import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';

void main() {
  test('FetchTopIds returns a list of ids', () async {
    // setup of test case
    final newsApi = NewsApiProvider();

    // create mock http client
    newsApi.client = MockClient((request) async {
      return Response(json.encode([1, 2, 3, 4]), 200);
    });

    final ids = await newsApi.fetchTopIds();

    // expectation
    expect(ids, [1, 2, 3, 4]);
  });
}
