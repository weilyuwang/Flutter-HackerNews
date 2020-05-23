import 'package:flutter/material.dart';
import 'stories_bloc.dart';

class StoriesProvider extends InheritedWidget {
  final StoriesBloc bloc;

  StoriesProvider({Key key, Widget child})
      : bloc = StoriesBloc(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(_) => true;

  // static method to get the instance of StoriesBloc from anywhere under StoriesProvider widget
  static StoriesBloc of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<StoriesProvider>()).bloc;
  }
}
