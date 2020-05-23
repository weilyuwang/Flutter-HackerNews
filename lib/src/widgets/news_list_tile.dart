import 'package:flutter/material.dart';
import '../models/item_model.dart';
import '../blocs/stories_provider.dart';
// Future and Stream are now exported via dart:core -
// no longer need to import async module to use Future/Stream

class NewsListTile extends StatelessWidget {
  final int itemId;

  const NewsListTile({Key key, this.itemId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // fetch stories bloc first
    final bloc = StoriesProvider.of(context);
    return StreamBuilder(
      stream: bloc.items,
      builder: (BuildContext context,
          AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot) {
        if (!snapshot.hasData) {
          return Text('Stream still loading');
        }
      },
    );
  }
}
