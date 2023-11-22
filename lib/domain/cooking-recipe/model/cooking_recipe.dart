import 'dart:convert';

class CookingRecipe {
  final String id;
  final String agent;
  final String name;
  final String videoUrl;

  final List<Map<String, String>>
      ingredients; // One Ingredient will be like : nom+quantite+type_quantite (Riz+1+kg)
  final List<Map<String, String>> steps;
  final int preparationTime;

  CookingRecipe({
    this.id = "ID",
    required this.agent,
    required this.name,
    required this.videoUrl,
    required this.ingredients,
    required this.steps,
    required this.preparationTime,
  });

  Map<String, dynamic> toMap() => {
        "agent": agent,
        "name": name,
        "video_url": videoUrl,
        "ingredients": ingredients,
        "stepsPreparation": steps,
        "preparation_time": preparationTime
      };

  static CookingRecipe fromMap(Map<String, dynamic> map) {
    List tempIng = map["ingredients"];
    List tempSte = map["stepsPreparation"];
    List<Map<String, String>> ing = [];
    for (var temp in tempIng) {
      ing.add(temp);
    }
    List<Map<String, String>> ste = [];
    for (var temp in tempSte) {
      ste.add(temp);
    }
    return CookingRecipe(
      id: map["id"],
      agent: map["agent"],
      name: map["name"],
      videoUrl: map["video_url"],
      ingredients: ing,
      steps: ste,
      preparationTime: map["preparation_time"],
    );
  }

  @override
  String toString() => jsonEncode(toMap());

  static Map<String, dynamic> toJson(String data) => jsonDecode(data);
}
