import 'package:cooking_recipe_app/domain/entities/cooking_recipe.dart';
import 'package:cooking_recipe_app/model/ingredient.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

/// Content the local data source logic.
/// CRUD + methode to send share your cooking recipe
///
class DataSource {
  // Creation of Cooking Recipe Key
  final String _itemsCode = "COOKING-RECIPE";

  // Created Cooking Recipe
  Future<bool> createdCookingRecipe(CookingRecipe cookingRecipe) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final newCookingRecipe = cookingRecipe.toString();
      final lastCookingRecipes = prefs.getStringList(_itemsCode) ?? [];
      lastCookingRecipes.add(newCookingRecipe);
      return await prefs.setStringList(_itemsCode, lastCookingRecipes);
    } catch (e) {
      debugPrint("Error message : $e");
      return false;
    }
  }

  // Read Cooking Recipe
  Future<List<CookingRecipe>> readCookingRecipe() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final dataStr = prefs.getStringList(_itemsCode) ?? <String>[];
    List<CookingRecipe> data = [];
    for (var str in dataStr) {
      final map = CookingRecipe.toJson(str);
      final cookingRecipe = CookingRecipe.fromMap(map);
      data.add(cookingRecipe);
    }

    return data;
  }

  // Updated Cooking Recipe
  Future<bool> updatedCookingRecipe(
      CookingRecipe cookingRecipe, int index) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final newCookingRecipe = cookingRecipe.toString();
      final lastCookingRecipes = prefs.getStringList(_itemsCode) ?? [];
      lastCookingRecipes.removeAt(index);
      lastCookingRecipes.add(newCookingRecipe);
      return await prefs.setStringList(_itemsCode, lastCookingRecipes);
    } catch (e) {
      debugPrint("Error message : $e");
      return false;
    }
  }

  // Deleted Cooking Recipe
  Future<bool> deletedCookingRecipe(int index) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final lastCookingRecipes = prefs.getStringList(_itemsCode) ?? [];
      lastCookingRecipes.removeAt(index);
      return await prefs.setStringList(_itemsCode, lastCookingRecipes);
    } catch (e) {
      debugPrint("Error message : $e");
      return false;
    }
  }

  // Share by mail
  void sendEmail(String mailTo, CookingRecipe data) async {
    // final Uri emailLaunchUri = Uri(
    //   scheme: 'mailto',
    //   path: mailTo,
    //   queryParameters: {
    //     'subject': 'RECETTE ${data.nomPlat.toUpperCase()}',
    //     'body': "Cette recette a été réalisé par ${data.nomAgent}.\nElle dure en moyenne ${data.time} minutes.\nVoici la vidéo de ça réalisation accessible avec ce lien : ${data.urlVideo}\n\nPour le faire, vous aviez besoins des ingrédients suivants : ${_prettyPrintIngredients(data.ingredients)}\n\nMaintenant, on vous montre étape par étape comment parvenir aux mêmes résultats que nous :${_prettyPrintSteps(data.stepsPreparation)}"
    //     },
    // );
    final subject =
        Uri.encodeComponent('RECETTE ${data.nomPlat.toUpperCase()}');
    final body = Uri.encodeComponent(
        "Cette recette a été réalisé par ${data.nomAgent}.\nElle dure en moyenne ${data.time} minutes.\nVoici la vidéo de ça réalisation accessible avec ce lien : ${data.urlVideo}\n\nPour le faire, vous aviez besoins des ingrédients suivants : ${_prettyPrintIngredients(data.ingredients)}\n\nMaintenant, on vous montre étape par étape comment parvenir aux mêmes résultats que nous :${_prettyPrintSteps(data.stepsPreparation)}");
    final emailLaunchUri =
        Uri.parse("mailto:$mailTo?subject=$subject&body=$body");
    if (await canLaunchUrl(emailLaunchUri)) {
      await launchUrl(emailLaunchUri);
    } else {
      throw "Impossible to launch mail";
    }
  }

  String _prettyPrintIngredients(List<String> ingredientsStr) {
    List<String> ingredients = [];
    for (var str in ingredientsStr) {
      final data = Ingredient.fromString(str);
      ingredients
          .add("• ${data!.quantite} ${data.typeQuantite} de ${data.nom}");
    }
    String ingredientList = "";
    for (var ing in ingredients) {
      ingredientList += "$ing\n";
    }
    return ingredientList;
  }

  String _prettyPrintSteps(List<String> steps) {
    String stepList = "";
    for (var ing in steps) {
      stepList += "• $ing\n";
    }
    return stepList;
  }
}
