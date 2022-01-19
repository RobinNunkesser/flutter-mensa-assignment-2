import 'package:mensa/meal_view_model.dart';

class CollectionViewModel {
  CollectionViewModel({required this.title, required this.meals});
  final String title;
  List<MealViewModel> meals;
}