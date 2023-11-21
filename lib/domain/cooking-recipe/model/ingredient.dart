class Ingredient {
  final String nom;
  final double quantite;
  final String typeQuantite;

  Ingredient(
      {required this.nom, required this.quantite, required this.typeQuantite});

  @override
  String toString() => "$nom+$quantite+$typeQuantite";

  static Ingredient? fromString(String data) {
    if (data.contains("+")) {
      int firstIndex = data.indexOf("+");
      int lastIndex = data.lastIndexOf("+");
      final name = data.substring(0, firstIndex);
      final quantity = data.substring(firstIndex + 1, lastIndex);
      final type = data.substring(lastIndex + 1);
      return Ingredient(
        nom: name,
        quantite: double.parse(quantity),
        typeQuantite: type,
      );
    }
    return Ingredient(nom: "loading", quantite: 0, typeQuantite: "loading");
  }
}
