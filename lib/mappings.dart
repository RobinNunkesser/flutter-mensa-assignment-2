import 'package:common_ui/common_ui.dart';
import 'package:meal_ports/meal_ports.dart';

extension CollectionMapping on MealCollection {
  ListSection toListSection(int status) {
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

    return ListSection(
        title: categoryName,
        items: meals.map((meal) => meal.toListItem(status)).toList());
  }
}

extension MealMapping on Meal {
  ListItem toListItem(int status) {
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
    return ListItem(
        title: name,
        subtitle: concretePrice != null
            ? concretePrice.toString() + ' €'
            : "Unknown price",
        image: image);
  }
}
