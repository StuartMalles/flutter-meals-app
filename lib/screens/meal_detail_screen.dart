import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../data/dummy_data.dart';

class MealDetailScreen extends StatelessWidget {
  static const routeName = '/meal-detail';
  String mealId;
  Function toggleFavorite;
  Function isFavorite;

  MealDetailScreen([Function paraToggleFavorite, Function paraIsFavorite, String paraMealId]) {
    toggleFavorite = paraToggleFavorite;
    isFavorite = paraIsFavorite;
    mealId = paraMealId;
  }

  Widget buildSectionTitle(BuildContext context, String text) {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 0),
      child: Text(text, style: Theme.of(context).textTheme.title),
    );
  }

  Widget buildContainer(Widget child) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(10)),
      height: 200,
      width: 300,
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final Meal selectedMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);

    if (mealId == null) {
      mealId = ModalRoute.of(context).settings.arguments as String;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('${selectedMeal.title}'),
      ),
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          Container(
            height: 300,
            width: double.infinity,
            child: Image.network(selectedMeal.imageUrl, fit: BoxFit.cover),
          ),
          buildSectionTitle(context, 'Ingredients'),
          buildContainer(ListView.builder(
            itemBuilder: (ctx, index) => Card(
              color: Theme.of(context).accentColor,
              child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: Text(selectedMeal.ingredients[index])),
            ),
            itemCount: selectedMeal.ingredients.length,
          )),
          buildSectionTitle(context, 'Steps'),
          buildContainer(ListView.builder(
            itemBuilder: (ctx, index) => Column(
              children: <Widget>[
                ListTile(
                  title: Text(selectedMeal.steps[index]),
                  leading: CircleAvatar(child: Text('# ${index + 1}')),
                ),
                Divider(),
              ],
            ),
            itemCount: selectedMeal.steps.length,
          )),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(isFavorite(mealId) ? Icons.star : Icons.star_border),
        onPressed: () => toggleFavorite(mealId),
      ),
    );
  }
}
