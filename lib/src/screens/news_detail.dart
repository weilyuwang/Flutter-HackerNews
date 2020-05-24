import 'package:flutter/material.dart';

class NewsDetail extends StatelessWidget {
  final int itemId;

  const NewsDetail({Key key, this.itemId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News Detail'),
      ),
      body: Text('Item $itemId Detail Screen'),
    );
  }
}