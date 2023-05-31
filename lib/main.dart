import 'package:flutter/material.dart';
import 'package:recipe/recipe_card.dart';
import 'package:recipe/recipe.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      body: AppBody(),
    ),
  ));
}

List<Recipe> searchList = [];
searchRecipe(String item) {
  searchList.clear();
  for (Recipe recipe in recipes) {
    for (String indg in recipe.ingredients) {
      if (indg.toLowerCase().contains(item.toLowerCase())) {
        searchList.add(recipe);
        break;
      }
    }
  }
}

class AppBody extends StatefulWidget {
  const AppBody({super.key});

  @override
  State<AppBody> createState() => _AppBodyState();
}

class _AppBodyState extends State<AppBody> {
  String activeScreen = 'RecipeCards';
  void switchScreen(String item) {
    setState(() {
      if (item.trim() == '') {
        activeScreen = 'RecipeCards';
      } else {
        activeScreen = 'searchResult';
        searchRecipe(item);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget screenWidget = const RecipeCards();
    if (activeScreen == 'searchResult') {
      screenWidget = const SearchResult();
    }
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        screenWidget,
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
