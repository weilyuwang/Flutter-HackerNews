import 'package:flutter/material.dart';
import 'dart:async';
import '../blocs/stories_provider.dart';

class NewsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // get the instance of StoriesBloc
    final StoriesBloc bloc = StoriesProvider.of(context);

    // TODO: BAD BEHAVIOR - ONLY FOR TEMPORARY TESTING
    bloc.fetchTopIds();

    return Scaffold(
      appBar: AppBar(title: Text('Top News')),
      body: buildList(bloc),
    );
  }

  Widget buildList(StoriesBloc bloc) {
    return StreamBuilder(
      stream: bloc.topIds,
      builder: (context, AsyncSnapshot<List<int>> snapshot) {
        if (!snapshot.hasData) {
          return Text('Still waiting on Ids');
        }

        return ListView.builder(
          itemCount: snapshot.data.length,
          itemBuilder: (BuildContext context, int index) {
            return Text((snapshot.data[index]).toString());
          },
        );
      },
    );
  }
}
