import 'package:flutter/material.dart';
import 'package:flutter_hackernews/src/screens/news_list.dart';
import 'blocs/stories_provider.dart';
import 'screens/news_detail.dart';
import 'blocs/comments_provider.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CommentsProvider(
      child: StoriesProvider(
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
      ),
    );
  }

  Route routes(RouteSettings settings) {
    if (settings.name == '/') {
      return MaterialPageRoute(builder: (context) {
        final storiesBloc = StoriesProvider.of(context);
        storiesBloc.fetchTopIds();
        return NewsList();
      });
    } else {
      // if '/:id'
      return MaterialPageRoute(builder: (context) {
        final commentsBloc = CommentsProvider.of(context);
        final itemId = int.parse(settings.name.replaceFirst('/', ''));

        commentsBloc.fetchItemWithComments(itemId);

        // and pass into NewsDetail
        return NewsDetail(itemId: itemId);
      });
    }
  }
}
