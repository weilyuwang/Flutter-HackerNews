import 'package:flutter/material.dart';
import 'dart:async';
import '../blocs/stories_provider.dart';
import '../widgets/news_list_tile.dart';

class NewsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // get the instance of StoriesBloc
    final StoriesBloc bloc = StoriesProvider.of(context);

    // TODO: BAD BEHAVIOR - ONLY FOR TEMPORARY TESTING
    bloc.fetchTopIds();

    return Scaffold(
      appBar: AppBar(title: Text('Hacker News')),
      body: buildList(bloc),
    );
  }

  Widget buildList(StoriesBloc bloc) {
    return StreamBuilder(
      stream: bloc.topIds,
      builder: (context, AsyncSnapshot<List<int>> snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          itemCount: snapshot.data.length,
          itemBuilder: (BuildContext context, int index) {
            bloc.fetchItem(snapshot.data[index]);
            return NewsListTile(itemId: snapshot.data[index]);
          },
        );
      },
    );
  }
}
