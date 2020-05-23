import 'package:rxdart/rxdart.dart';
import '../models/item_model.dart';
import '../resources/repository.dart';
import 'dart:async';

class StoriesBloc {
  final _repository = Repository();
  // subjects are basically stream controllers created by rxdart lib

  // Exactly like a normal broadcast StreamController with one exception:
  // this class is both a Stream and Sink.
  final _topIds = PublishSubject<List<int>>();

  // A special StreamController that captures the latest item that has been added to the controller,
  // and emits that as the first item to any new listener.
  final _items = BehaviorSubject<int>();

  // Transformed Stream
  Stream<Map<int, Future<ItemModel>>> items;

  // Getters to Streams
  Stream<List<int>> get topIds => _topIds.stream;

  // Getters to Sinks
  Function(int) get fetchItem => _items.sink.add;

  StoriesBloc() {
    // create the _itemsTransformer/cache only once
    items = _items.stream.transform(_itemsTransformer());
  }

  fetchTopIds() async {
    final ids = await _repository.fetchTopIds();
    _topIds.sink.add(ids);
  }

  _itemsTransformer() {
    return ScanStreamTransformer(
      (Map<int, Future<ItemModel>> cache, int id, _) {
        cache[id] = _repository.fetchItem(id);
        return cache;
      },
      <int, Future<ItemModel>>{},
    );
  }

  // clean up / dispose streamControllers/subjects
  dispose() {
    _topIds.close();
    _items.close();
  }
}
