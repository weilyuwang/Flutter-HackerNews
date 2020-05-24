import 'package:flutter/material.dart';
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
      // appBar: AppBar(title: Text('Hacker News')),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Text('Hacker News'),
            floating: true,
            snap: true,
          ),
          buildList(bloc),
        ],
      ),
    );
  }

  Widget buildList(StoriesBloc bloc) {
    return StreamBuilder(
      stream: bloc.topIds,
      builder: (context, AsyncSnapshot<List<int>> snapshot) {
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              bloc.fetchItem(snapshot.data[index]);
              return NewsListTile(itemId: snapshot.data[index]);
            },
            childCount: snapshot.hasData ? snapshot.data.length : 0,
          ),
        );
      },
    );
  }
}
