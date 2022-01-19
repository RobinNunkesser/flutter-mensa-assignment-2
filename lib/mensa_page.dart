import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:meal_ports/meal_ports.dart';
import 'package:mensa/collection_item.dart';
import 'package:mensa/mappings.dart';
import 'package:mensa/meal_query_dto.dart';
import 'package:mensa/meal_view_model.dart';
import 'package:mock_meal_adapters/mock_meal_adapters.dart';

import 'collection_view_model.dart';

class MensaPage extends StatefulWidget {
  const MensaPage({Key? key}) : super(key: key);

  @override
  State<MensaPage> createState() => _MensaPageState();
}

class _MensaPageState extends State<MensaPage> {
  final logger = Logger();
  var command = MockGetMealsCommand();
  List<CollectionViewModel> collections = [];

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
    return SafeArea(child: ListView.builder(
      itemBuilder: (BuildContext context, int index) =>
          CollectionItem(collections[index]),
      itemCount: collections.length,
    )
    );
  }

  void success(List<MealCollection> collections) {
    setState(() {
      this.collections = collections.map((collection) =>
          collection.toCollectionViewModel()).toList();
    });
  }

  handleError(error) {
    logger.e(error);
  }

}