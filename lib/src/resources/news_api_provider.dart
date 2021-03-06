import 'package:flutter_hackernews/src/models/item_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'repository.dart';

final _root = "https://hacker-news.firebaseio.com/v0";

// Dart has no interface keyword.
class NewsApiProvider implements Source {
  http.Client client = http.Client();

  Future<List<int>> fetchTopIds() async {
    final response = await client.get('$_root/topstories.json');
    final ids = json.decode(response.body); // json from dart:convert lib

    return ids.cast<int>(); // tell dart that ids is a list of int
  }

  Future<ItemModel> fetchItem(int id) async {
    final response = await client.get('$_root/item/$id.json');
    final parsedJson = json.decode(response.body);

    return ItemModel.fromJson(parsedJson);
  }
}
