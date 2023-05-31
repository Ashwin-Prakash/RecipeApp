class Recipe {
  String name = '';
  List<String> ingredients = [];
  List<String> steps = [];

  Recipe({required this.name, required this.ingredients, required this.steps});

  Recipe.fromJson(Map<String, dynamic> json) {
    name = json['title'];
    ingredients = List<String>.from(json['ingredients']);
    steps = List<String>.from(json['steps']);
  }
}
