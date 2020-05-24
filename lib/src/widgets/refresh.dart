import 'package:flutter/material.dart';

class Refresh extends StatelessWidget {
  final Widget child;

  const Refresh({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      child: child,
      onRefresh: () {
        print("Clear Cache");
        return;
      },
    );
  }
}
