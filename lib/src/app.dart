import 'package:flutter/material.dart';
import 'package:flutter_hackernews/src/screens/news_list.dart';
import 'blocs/stories_provider.dart';
import 'screens/news_detail.dart';

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
        onGenerateRoute: routes,
      ),
    );
  }

  Route routes(RouteSettings settings) {
    if (settings.name == '/') {
      return MaterialPageRoute(builder: (context) {
        return NewsList();
      });
    } else {
      // if '/:id'
      return MaterialPageRoute(builder: (context) {
        // TODO: extract the item id from settings.name
        // and pass into NewsDetail
        return NewsDetail();
      });
    }
  }
}
