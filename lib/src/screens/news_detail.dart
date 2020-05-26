import 'package:flutter/material.dart';
import 'package:flutter_hackernews/src/models/item_model.dart';
import 'package:flutter_hackernews/src/widgets/comment.dart';
import '../blocs/comments_provider.dart';

class NewsDetail extends StatelessWidget {
  final int itemId;

  const NewsDetail({Key key, this.itemId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = CommentsProvider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('News Detail'),
      ),
      body: buildBody(bloc),
    );
  }

  Widget buildBody(CommentsBloc bloc) {
    return StreamBuilder(
      stream: bloc.itemWithComments,
      builder: (BuildContext context,
          AsyncSnapshot<Map<int, Future<ItemModel>>> mapSnapshot) {
        if (!mapSnapshot.hasData) {
          return Text('Map Loading');
        }
        final itemFuture = mapSnapshot.data[itemId];

        return FutureBuilder(
          future: itemFuture,
          builder:
              (BuildContext context, AsyncSnapshot<ItemModel> itemSnapshot) {
            if (!itemSnapshot.hasData) {
              return Text('Item Loading');
            }
            return buildList(itemSnapshot.data, mapSnapshot.data);
          },
        );
      },
    );
  }

  Widget buildList(ItemModel item, Map<int, Future<ItemModel>> itemMap) {
    final commentsList = item.kids.map((kidId) {
      return Comment(
        itemId: kidId,
        itemMap: itemMap,
        depth: 1,
      );
    }).toList();

    return ListView(
      children: <Widget>[
        buildTitle(item),
        ...commentsList,
      ],
    );
  }

  Widget buildTitle(ItemModel item) {
    return Container(
      margin: EdgeInsets.all(10.0),
      alignment: Alignment.topCenter,
      child: Text(
        item.title,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
