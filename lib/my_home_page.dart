import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:meal_ports/meal_ports.dart';
import 'package:mensa/meal_query_dto.dart';
import 'package:mensa/mensa_page.dart';
import 'package:mensa/settings_page.dart';
import 'package:mock_meal_adapters/mock_meal_adapters.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _selectedIndex = 0;
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
      body: body(),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant),
            label: "Mensa",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Settings",
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(
          () {
        _selectedIndex = index;
      },
    );
  }

  Widget body() {
    switch (_selectedIndex) {
      case 0:
        return MensaPage();
      case 1:
        return SettingsPage();
      default:
        return MensaPage();
    }
  }

  void success(List<MealCollection> collections) {
    logger.i(collections.toString());
  }

  handleError(error) {
    logger.e(error);
  }
}

