import 'dart:async';
import 'news_api_provider.dart';
import 'news_db_provider.dart';
import '../models/item_model.dart';

class Repository {
  NewsDbProvider dbProvider = NewsDbProvider();
  NewsApiProvider apiProvider = NewsApiProvider();

  fetchTopIds() {
    return apiProvider.fetchTopIds();
  }

  fetchItem(int id) async {
    // search for item in local db first
    var item = await dbProvider.fetchItem(id);
    if (item != null) {
      return item;
    }
    // if items not cached in local db, call API
    item = await apiProvider.fetchItem(id);
    // then add item to local db
    dbProvider.addItem(item);

    return item;
  }
}
