import 'package:meal_ports/meal_ports.dart';
import 'package:mensa/collection_view_model.dart';
import 'package:mensa/meal_view_model.dart';

extension CollectionMapping on MealCollection {
  CollectionViewModel toCollectionViewModel() => CollectionViewModel(
      title: category.name,
      meals: meals.map((meal) => meal.toMealViewModel()).toList());
}

extension MealMapping on Meal {
  MealViewModel toMealViewModel() =>
      MealViewModel(name, price.employees!.toString(), image!);
}