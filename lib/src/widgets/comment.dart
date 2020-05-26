import 'package:flutter/material.dart';
import 'package:flutter_hackernews/src/widgets/loading_container.dart';
import '../models/item_model.dart';
import 'package:html/parser.dart';

class Comment extends StatelessWidget {
  final int itemId;
  final Map<int, Future<ItemModel>> itemMap;
  final int depth;

  Comment({this.itemId, this.itemMap, this.depth});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: itemMap[itemId],
      builder: (context, AsyncSnapshot<ItemModel> snapshot) {
        if (!snapshot.hasData) {
          return LoadingContainer();
        }

        final item = snapshot.data;

        final children = <Widget>[
          ListTile(
            title: buildText(item),
            subtitle: item.by == '' || item.by == null
                ? Text('This comment has been deleted.')
                : Text(item.by),
            contentPadding: EdgeInsets.only(right: 16.0, left: 16.0 * depth),
          ),
          Divider(),
        ];
        item.kids.forEach((kidId) {
          children
              .add(Comment(itemId: kidId, itemMap: itemMap, depth: depth + 1));
        });

        return Column(
          children: children,
        );
      },
    );
  }

  Widget buildText(ItemModel item) {
    final document = parse(item.text);
    return Text(parse(document.body.text).documentElement.text);
  }
}
