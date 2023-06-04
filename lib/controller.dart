import 'package:get/get.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:recipe/recipe.dart';

class MycontrollerOne extends GetxController {
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

class MycontrollerTwo extends GetxController {
  List<Recipe> searchList = [];
  late String item;
  @override
  void onInit() {
    super.onInit();
    searchRecipe();
  }

  searchRecipe() {
    searchList.clear();
    item = Get.arguments[0];
    for (Recipe recipe in Get.find<MycontrollerOne>().recipes) {
      for (String indg in recipe.ingredients) {
        if (indg.toLowerCase().contains(item.toLowerCase())) {
          searchList.add(recipe);
          break;
        }
      }
    }
    update();
  }
}
