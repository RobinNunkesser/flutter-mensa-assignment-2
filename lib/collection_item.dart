import 'package:flutter/material.dart';
import 'package:mensa/collection_view_model.dart';
import 'package:mensa/meal_view_model.dart';

class CollectionItem extends StatelessWidget {
  const CollectionItem(this.entry);

  final CollectionViewModel entry;

  Widget _mealTile(MealViewModel meal) {
    return ListTile(
      title: Text(meal.title),
      subtitle: Text(meal.subtitle),
      leading: Image.network(meal.image,errorBuilder: (context, error, stackTrace) {
        return Text("No image");
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(entry.title),
      children: entry.meals.map(_mealTile).toList(),
      initiallyExpanded: true,
    );
  }
}
