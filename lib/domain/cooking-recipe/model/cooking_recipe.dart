import 'dart:convert';

class CookingRecipe {
  final String nomAgent;
  final String nomPlat;
  final String urlVideo;
  final List<String>
      ingredients; // One Ingredient will be like : nom+quantite+type_quantite (Riz+1+kg)
  final List<String> stepsPreparation;
  final int time;

  CookingRecipe({
    required this.nomAgent,
    required this.nomPlat,
    required this.urlVideo,
    required this.ingredients,
    required this.stepsPreparation,
    required this.time,
  });

  Map<String, dynamic> toMap() => {
        "nomAgent": nomAgent,
        "nomPlat": nomPlat,
        "urlVideo": urlVideo,
        "ingredients": ingredients,
        "stepsPreparation": stepsPreparation,
        "time": time
      };

  static CookingRecipe fromMap(Map<String, dynamic> map) {
    List tempIng = map["ingredients"];
    List tempSte = map["stepsPreparation"];
    List<String> ing = [];
    for (var temp in tempIng) {
      ing.add(temp.toString());
    }
    List<String> ste = [];
    for (var temp in tempSte) {
      ste.add(temp.toString());
    }
    return CookingRecipe(
      nomAgent: map["nomAgent"],
      nomPlat: map["nomPlat"],
      urlVideo: map["urlVideo"],
      ingredients:  ing,
      stepsPreparation: ste,
      time: map["time"]);
}

  @override
  String toString() => jsonEncode(toMap());

  static Map<String, dynamic> toJson(String data) => jsonDecode(data);

}
