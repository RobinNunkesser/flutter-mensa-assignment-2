import 'dart:async';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:meal_ports/meal_ports.dart';
import 'package:mensa/meal_query_dto.dart';
import 'package:mock_meal_adapters/mock_meal_adapters.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var command = MockGetMealsCommand();
  final logger = Logger();

  @override
  void initState() {
    super.initState();
    command
        .execute(MealQueryDTO(mensa: 42, date: DateTime.now()))
        .then(success)
        .catchError(handleError);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
          ],
        ),
      ),
    );
  }

  void success(List<MealCollection> collections) {
    logger.i(collections.toString());
  }

  handleError(error) {
    logger.e(error);
  }
}
