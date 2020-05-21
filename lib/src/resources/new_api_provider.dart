import 'package:flutter_hackernews/src/models/item_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

final _root = "https://hacker-news.firebaseio.com/v0";

class NewsApiProvider {
  final http.Client client = http.Client();

  fetchTopIds() async {
    final response = await client.get('$_root/topstories.json');
    final ids = json.decode(response.body); // json from dart:convert lib

    return ids;
  }

  fetchItem(int id) async {
    final response = await client.get('$_root/item/$id.json');
    final parsedJson = json.decode(response.body);

    return ItemModel.fromJson(parsedJson);
  }
}
