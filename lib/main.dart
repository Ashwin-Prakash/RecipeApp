import 'package:flutter/material.dart';
import 'package:recipe/controller.dart';
import 'package:recipe/recipe_card.dart';
import 'package:get/get.dart';

void main() {
  runApp(const GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      body: AppBody(),
    ),
  ));
}

class AppBody extends StatelessWidget {
  const AppBody({super.key});

  void switchScreen(String item) {
    if (item.trim() == '') {
      Get.snackbar("Oops", "Enter the ingredient to search.");
    } else {
      Get.to(const SearchResult(), arguments: [item]);
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
    return Scaffold(
      body: GetBuilder(
          init: MycontrollerTwo(),
          builder: (controller) {
            if (controller.searchList.isEmpty) {
              return const Center(
                child: Text('Sorry!! NO Recipes Found'),
              );
            } else {
              return ListView.builder(
                  itemCount: controller.searchList.length,
                  itemBuilder: (context, index) {
                    return Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: const LinearGradient(
                              colors: [Colors.red, Colors.pink]),
                        ),
                        child: Column(
                          children: [
                            Text(
                              controller.searchList[index].name,
                              style: const TextStyle(color: Colors.white),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              controller.searchList[index].ingredients
                                  .join(', '),
                              style: const TextStyle(color: Colors.white),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              controller.searchList[index].steps.join(', '),
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ));
                  });
            }
          }),
    );
  }
}
