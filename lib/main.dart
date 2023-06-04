import 'package:flutter/material.dart';
import 'package:recipe/controller.dart';
import 'package:recipe/recipe_card.dart';
import 'package:recipe/recipe.dart';
import 'package:get/get.dart';

void main() {
  runApp(const GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      body: AppBody(),
    ),
  ));
}

var searchList = [].obs;
searchRecipe(String item) {
  searchList.clear();
  for (Recipe recipe in Get.find<Mycontroller>().recipes) {
    for (String indg in recipe.ingredients) {
      if (indg.toLowerCase().contains(item.toLowerCase())) {
        searchList.add(recipe);
        break;
      }
    }
  }
}

class AppBody extends StatelessWidget {
  const AppBody({super.key});

  void switchScreen(String item) {
    if (item.trim() == '') {
      Get.to(() => const RecipeCards());
    } else {
      Get.to(() => const SearchResult());
      searchRecipe(item);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        const RecipeCards(),
        SearchBox(switchScreen),
      ],
    );
  }
}

class SearchResult extends StatelessWidget {
  const SearchResult({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: searchList.length,
        itemBuilder: (context, index) {
          return Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient:
                    const LinearGradient(colors: [Colors.red, Colors.pink]),
              ),
              child: Column(
                children: [
                  Text(
                    searchList[index].name,
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    searchList[index].ingredients.join(', '),
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    searchList[index].steps.join(', '),
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ));
        });
  }
}
