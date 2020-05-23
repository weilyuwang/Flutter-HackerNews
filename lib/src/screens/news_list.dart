import 'package:flutter/material.dart';
import 'dart:async';
import '../blocs/stories_provider.dart';

class NewsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // get the instance of StoriesBloc
    final bloc = StoriesProvider.of(context);

    return Scaffold(
      appBar: AppBar(title: Text('Top News')),
      body: buildList(),
    );
  }

  Widget buildList() {
    return ListView.builder(
      itemCount: 500,
      itemBuilder: (BuildContext context, int index) {
        return FutureBuilder(
          future: getFuture(),
          builder: (context, snapshot) {
            return Container(
              height: 80.0,
              child: snapshot.hasData
                  ? Text('Im visible $index')
                  : Text('I havent fetched data yet $index'),
            );
          },
        );
      },
    );
  }

  getFuture() {
    return Future.delayed(
      Duration(seconds: 2),
      () => 'h1',
    );
  }
}
