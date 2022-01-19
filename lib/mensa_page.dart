import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:meal_ports/meal_ports.dart';
import 'package:mensa/collection_item.dart';
import 'package:mensa/mappings.dart';
import 'package:mensa/meal_query_dto.dart';
import 'package:mensa/settings_page.dart';
import 'package:mock_meal_adapters/mock_meal_adapters.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  late SharedPreferences prefs;
  int status = 0;

  @override
  void initState() {
    readStatus();
    super.initState();
    command
        .execute(MealQueryDTO(mensa: 42, date: DateTime.now()))
        .then(success)
        .catchError(handleError);
  }

  readStatus() async{
    prefs = await SharedPreferences.getInstance();
    status = prefs.getInt(statusKey) ?? 0;
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

  void success(List<MealCollection> collections) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var status = prefs.getInt(statusKey) ?? 0;
    setState(() {
      this.collections = collections.map((collection) =>
          collection.toCollectionViewModel(status)).toList();
    });
  }

  handleError(error) {
    showError(context, error);
  }

  Future<void> showError(BuildContext context, Exception e) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(e.toString()),
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: Text(MaterialLocalizations.of(context).okButtonLabel),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

}