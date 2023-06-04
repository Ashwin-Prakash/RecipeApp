import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe/controller.dart';
// import 'package:recipe/recipe.dart';

class RecipeCards extends StatelessWidget {
  const RecipeCards({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<Mycontroller>(
        init: Mycontroller(),
        builder: (controller) {
          return ListView.builder(
              itemCount: controller.recipes.length,
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
                          controller.recipes[index].name.toString(),
                          style: const TextStyle(color: Colors.white),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(controller.recipes[index].ingredients.join(', '),
                            style: const TextStyle(color: Colors.white)),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(controller.recipes[index].steps.join(', '),
                            style: const TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                );
              });
        });
  }
}

class SearchBox extends StatelessWidget {
  final void Function(String item) switchScreen;
  SearchBox(this.switchScreen, {super.key});

  final TextEditingController tc = TextEditingController();

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
                  controller: tc,
                ),
              ),
            ),
            ElevatedButton.icon(
              label: const Text('Search'),
              onPressed: () {
                switchScreen(tc.text);
              },
              icon: const Icon(Icons.search),
            )
          ],
        ));
  }
}
