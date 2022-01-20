import 'package:meal_ports/meal_ports.dart';
import 'package:mensa/collection_view_model.dart';
import 'package:mensa/meal_view_model.dart';

extension CollectionMapping on MealCollection {
  CollectionViewModel toCollectionViewModel(int status) {
    String categoryName = "";

    switch (category) {
      case MealCategory.none:
        categoryName = "";
        break;
      case MealCategory.dessert:
        categoryName = "Desserts";
        break;
      case MealCategory.dish:
        categoryName = "Hauptgerichte";
        break;
      case MealCategory.sidedish:
        categoryName = "Beilagen";
        break;
      case MealCategory.soup:
        categoryName = "Suppen / Eintöpfe";
        break;
    }

    return CollectionViewModel(
        title: categoryName,
        meals: meals.map((meal) => meal.toMealViewModel(status)).toList());
  }
}

extension MealMapping on Meal {
  MealViewModel toMealViewModel(int status) {
    double? concretePrice;
    switch (status) {
      case 0:
        concretePrice = price.students;
        break;
      case 1:
        concretePrice = price.employees;
        break;
      case 2:
        concretePrice = price.pupils;
        break;
      case 3:
        concretePrice = price.others;
        break;
    }
    return MealViewModel(
        name,
        concretePrice != null
            ? concretePrice.toString() + ' €'
            : "Unknown price",
        image ?? "");
  }
}
