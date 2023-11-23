import 'dart:convert';

class CookingRecipe {
  final String id;
  final String agent;
  final String name;
  final String videoUrl;

  final List<Map<String, dynamic>>
      ingredients; // One Ingredient will be like : nom+quantite+type_quantite (Riz+1+kg)
  final List<Map<String, dynamic>> steps;
  final int preparationTime;
  final String updatedAt;

  CookingRecipe({
    this.id = "ID",
    required this.agent,
    required this.name,
    required this.videoUrl,
    required this.ingredients,
    required this.steps,
    required this.preparationTime,
    this.updatedAt = "loading"
  });

  Map<String, dynamic> toMap() => {
        "agent": agent,
        "name": name,
        "video_url": videoUrl,
        "ingredients_data": ingredients,
        "steps_data": steps,
        "preparation_time": preparationTime,
        "status": true
      };

  static CookingRecipe fromMap(Map<String, dynamic> map) {
    List tempIng = map["ingredients"];
    List tempSte = map["steps"];
    List<Map<String, dynamic>> ing = [];
    for (var temp in tempIng) {
      ing.add(temp);
    }
    List<Map<String, dynamic>> ste = [];
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
      updatedAt: map["updatedAt"]
    );
  }

  @override
  String toString() => jsonEncode(toMap());

  static Map<String, dynamic> toJson(String data) => jsonDecode(data);
}
