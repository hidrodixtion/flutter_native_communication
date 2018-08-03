import 'package:meta/meta.dart';
import 'package:flutter/material.dart';

import 'dart:convert';

class SecondRoute extends StatelessWidget {
  final String data;

  SecondRoute({Key key, @required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List jsonList = json.decode(data);

    return Scaffold(
      appBar: AppBar(
        title: Text("Teams"),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(jsonList[index]["strTeam"]),
            onTap: () {},
          );
        },
        itemCount: jsonList.length,
      ),
    );
  }
}
