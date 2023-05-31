import 'package:flutter/material.dart';
import 'package:recipe/recipe.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

final List<Recipe> recipes = [];

class RecipeCards extends StatelessWidget {
  const RecipeCards({super.key});

  Future<void> readJson() async {
    final jsonString = await rootBundle.loadString('asset/recipes.json');
    final jsonData = jsonDecode(jsonString);
    final List<dynamic> recipeList = jsonData['recipes'];
    for (dynamic json in recipeList) {
      Recipe recipe = Recipe.fromJson(json);
      recipes.add(recipe);
    }
    // return recipeList.map((e) => Recipe.fromJson(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: readJson(),
        builder: (context, snapshot) {
          return ListView.builder(
              itemCount: recipes.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: const LinearGradient(
                            colors: [Colors.red, Colors.pink])),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Column(
                      children: [
                        Text(
                          recipes[index].name.toString(),
                          style: const TextStyle(color: Colors.white),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(recipes[index].ingredients.join(', '),
                            style: const TextStyle(color: Colors.white)),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(recipes[index].steps.join(', '),
                            style: const TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                );
              });
        });
  }
}

class SearchBox extends StatefulWidget {
  final void Function(String item) switchScreen;
  SearchBox(this.switchScreen, {super.key});

  final TextEditingController tc = TextEditingController();

  @override
  State<SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: 20),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsetsDirectional.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white,
                ),
                child: TextField(
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Search',
                  ),
                  controller: widget.tc,
                ),
              ),
            ),
            ElevatedButton.icon(
              label: const Text('Search'),
              onPressed: () {
                widget.switchScreen(widget.tc.text);
              },
              icon: const Icon(Icons.search),
            )
          ],
        ));
  }
}
