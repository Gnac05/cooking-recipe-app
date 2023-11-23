import 'package:cooking_recipe_app/domain/cooking-recipe/model/cooking_recipe.dart';
import 'package:cooking_recipe_app/domain/cooking-recipe/model/ingredient.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// Content the local data source logic.
/// CRUD + methode to send share your cooking recipe
///
class DataSource {
  // Api url
  final _apiBaseUrl = "https://dev.afriksmeals.com/api/v1/";
  final _dio = Dio(
    BaseOptions(
      contentType: "application/json",
      headers: {
        "access-control-allow-origin": "*",
        "allow": "GET,POST,PUT,DELETE,HEAD,OPTIONS",
        "connection": "keep-alive",
        "content-language": "fr",
        //  content-length: 265
        "accept": "application/json",
        "content-type": "application/json",
        "cross-origin-opener-policy": "same-origin",
        'X-CSRFToken':
            'CrJLAj0kCALhtzbWX87RUqPqqCJJpdUp36qLA6jk6ziJKDGHq8wD9TV7Ye3YpVX1',
        "referrer-policy": "same-origin ",
        "server": "nginx/1.14.0 (Ubuntu)",
        "vary": "Accept,Accept-Language,Origin",
        "x-content-type-options": "nosniff",
        "x-frame-options": "DENY"
      },
    ),
  );

  // Created Cooking Recipe : POST
  Future<bool> createdCookingRecipe(CookingRecipe cookingRecipe) async {
    try {
      final map = cookingRecipe.toMap();
      _dio.options.baseUrl = _apiBaseUrl;
      final response = await _dio.post(
        'recipes',
        data: map,
        // options: Options(),
      );

      if (response.statusCode == 201) {
        return true;
      } else {
        debugPrint(
            "Error Code : ${response.statusCode}\nError message : ${response.statusMessage}");
        return false;
      }
    } catch (e) {
      debugPrint("Error message : $e");
      return false;
    }
  }

  // Read All Cooking Recipe : GET
  Future<List<CookingRecipe>?> readCookingRecipe() async {
    try {
      _dio.options.baseUrl = _apiBaseUrl;
      final response = await _dio.get('recipes');

      if (response.statusCode == 200) {
        final cookingRecipes = <CookingRecipe>[];
        final data = response.data;
        for (var recipe in data) {
          cookingRecipes.add(CookingRecipe.fromMap(recipe));
        }
        return cookingRecipes;
      } else {
        debugPrint(
            "Error Code : ${response.statusCode}\nError message : ${response.statusMessage}");
        return null;
      }
    } catch (e) {
      debugPrint("Error message : $e");
      return null;
    }
  }

  // Read One Cooking Recipe : GET /$id
  Future<CookingRecipe?> readOneCookingRecipe(String id) async {
    try {
      _dio.options.baseUrl = _apiBaseUrl;
      final response = await _dio.get('recipes/$id');

      if (response.statusCode == 200) {
        final data = response.data;

        return CookingRecipe.fromMap(data);
      } else {
        debugPrint(
            "Error Code : ${response.statusCode}\nError message : ${response.statusMessage}");
        return null;
      }
    } catch (e) {
      debugPrint("Error message : $e");
      return null;
    }
  }

  // Updated Cooking Recipe PUT /$id
  Future<bool> updatedCookingRecipe(CookingRecipe cookingRecipe, int id) async {
    try {
      final map = cookingRecipe.toMap();
      map["id"] = cookingRecipe.id;
      map["updatedAt"] = cookingRecipe.updatedAt;
      _dio.options.baseUrl = _apiBaseUrl;
      final response = await _dio.put('recipes/$id', data: map);

      if (response.statusCode == 200) {
        return true;
      } else {
        debugPrint(
            "Error Code : ${response.statusCode}\nError message : ${response.statusMessage}");
        return false;
      }
    } catch (e) {
      debugPrint("Error message : $e");
      return false;
    }
  }

  // Deleted Cooking Recipe
  Future<bool> deletedCookingRecipe(int id) async {
    try {
      _dio.options.baseUrl = _apiBaseUrl;
      final response = await _dio.delete('recipes/$id/realDelete');

      if (response.statusCode == 200) {
        return true;
      } else {
        debugPrint(
            "Error Code : ${response.statusCode}\nError message : ${response.statusMessage}");
        return false;
      }
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
    //     'subject': 'RECETTE ${data.name.toUpperCase()}',
    //     'body': "Cette recette a été réalisé par ${data.agent}.\nElle dure en moyenne ${data.time} minutes.\nVoici la vidéo de ça réalisation accessible avec ce lien : ${data.urlVideo}\n\nPour le faire, vous aviez besoins des ingrédients suivants : ${_prettyPrintIngredients(data.ingredients)}\n\nMaintenant, on vous montre étape par étape comment parvenir aux mêmes résultats que nous :${_prettyPrintSteps(data.stepsPreparation)}"
    //     },
    // );
    final subject = Uri.encodeComponent('RECETTE ${data.name.toUpperCase()}');
    final body = Uri.encodeComponent(
        "Cette recette a été réalisé par ${data.agent}.\nElle dure en moyenne ${data.preparationTime} minutes.\nVoici la vidéo de ça réalisation accessible avec ce lien : ${data.videoUrl}\n\nPour le faire, vous aviez besoins des ingrédients suivants : ${_prettyPrintIngredients(data.ingredients)}\n\nMaintenant, on vous montre étape par étape comment parvenir aux mêmes résultats que nous :${_prettyPrintSteps(data.steps)}");
    final emailLaunchUri =
        Uri.parse("mailto:$mailTo?subject=$subject&body=$body");
    if (await canLaunchUrl(emailLaunchUri)) {
      await launchUrl(emailLaunchUri);
    } else {
      throw "Impossible to launch mail";
    }
  }

  String _prettyPrintIngredients(List<Map<String, dynamic>> ingredientsStr) {
    List<String> ingredients = [];
    for (var str in ingredientsStr) {
      final data = Ingredient.fromMap(str);
      ingredients.add("• ${data!.quantity} ${data.type} de ${data.name}");
    }
    String ingredientList = "";
    for (var ing in ingredients) {
      ingredientList += "$ing\n";
    }
    return ingredientList;
  }

  String _prettyPrintSteps(List<Map<String, dynamic>> steps) {
    String stepList = "";
    for (var ing in steps) {
      stepList += "• ${ing["content"]}\n";
    }
    return stepList;
  }
}
