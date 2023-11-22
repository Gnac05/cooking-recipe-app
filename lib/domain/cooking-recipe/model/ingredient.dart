class Ingredient {
  final String name;
  final double quantity;
  final String type;

  Ingredient({required this.name, required this.quantity, required this.type});

  @override
  String toString() => "$name+$quantity+$type";

  static Ingredient? fromString(String data) {
    if (data.contains("+")) {
      int firstIndex = data.indexOf("+");
      int lastIndex = data.lastIndexOf("+");
      final name = data.substring(0, firstIndex);
      final quantity = data.substring(firstIndex + 1, lastIndex);
      final type = data.substring(lastIndex + 1);
      return Ingredient(
        name: name,
        quantity: double.parse(quantity),
        type: type,
      );
    }
    return Ingredient(name: "loading", quantity: 0, type: "loading");
  }

  Map<String, String> toMap() =>
      {"name": name, "quantity": quantity.toString(), "type": type};

  static fromMap(Map<String, String> map) => Ingredient(
        name: map["name"]??"",
        quantity: double.parse(map["quantity"]??"0"),
        type: map["type"]??"",
      );
}
