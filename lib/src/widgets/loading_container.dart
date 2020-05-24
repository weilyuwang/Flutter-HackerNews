import 'package:flutter/material.dart';

class LoadingContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: buildPlaceHolderContainer(),
          subtitle: buildPlaceHolderContainer(),
        ),
        Divider(
          height: 4.0,
        ),
      ],
    );
  }

  Widget buildPlaceHolderContainer() {
    return Container(
      color: Colors.grey[200],
      height: 24.0,
      width: 150.0,
      margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
    );
  }
}
