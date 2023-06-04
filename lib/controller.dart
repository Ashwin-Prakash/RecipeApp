import 'package:get/get.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:recipe/recipe.dart';

class Mycontroller extends GetxController {
  final List<Recipe> recipes = [];
  @override
  void onInit() {
    super.onInit();
    readJson();
  }

  void readJson() async {
    final jsonString = await rootBundle.loadString('asset/recipes.json');
    final jsonData = jsonDecode(jsonString);
    final List<dynamic> recipeList = jsonData['recipes'];
    for (dynamic json in recipeList) {
      Recipe recipe = Recipe.fromJson(json);
      recipes.add(recipe);
    }
    update();
  }
}
