import 'package:flutter/material.dart';
import 'package:flutter_hackernews/src/screens/news_list.dart';
import 'blocs/stories_provider.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoriesProvider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Hacker News Flutter Demo',
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            color: Colors.orange[800],
          ),
        ),
        home: NewsList(),
      ),
    );
  }
}
