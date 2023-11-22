import 'package:cooking_recipe_app/domain/cooking-recipe/model/cooking_recipe.dart';
import 'package:cooking_recipe_app/domain/cooking-recipe/model/ingredient.dart';
import 'package:cooking_recipe_app/infrastructure/cooking-recipe/data-sources/data_source.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group("Data Source", () {
    test('createdCookingRecipe should add a new cooking recipe', () async {
      TestWidgetsFlutterBinding.ensureInitialized();

      final dataSource = DataSource();

      // Create a sample CookingRecipe
      final cookingRecipe = CookingRecipe(
        ingredients: [
          Ingredient(nom: "Riz", quantite: 2, typeQuantite: "kg").toString()
        ],
        nomAgent: "Mr Beast",
        nomPlat: "Riz Sauté",
        stepsPreparation: [
          "Laver le riz",
          "Mettre l'eau salé sur le feu",
          "Verser le RIZ",
          "..."
        ],
        time: 30,
        urlVideo: "https://youtube.com/",
      );

      // Before adding
      final prefsBefore = await SharedPreferences.getInstance();
      final originalRecipes = prefsBefore.getStringList("COOKING-RECIPE") ?? [];
      final originalLength = originalRecipes.length;

      // Call the function to add the cooking recipe
      final result = await dataSource.createdCookingRecipe(cookingRecipe);

      // Print debug information
      debugPrint('Result of createdCookingRecipe: $result');
      debugPrint('Before adding recipe: $originalRecipes');
      debugPrint(
          'After adding recipe: ${prefsBefore.getStringList("COOKING-RECIPE") ?? []}');

      // Check if the result is true, indicating success
      expect(result, true, reason: 'The function did not return true');

      // Check that the size of the list increased as expected
      final prefsAfter = await SharedPreferences.getInstance();
      final updatedRecipes = prefsAfter.getStringList("COOKING-RECIPE") ?? [];
      expect(updatedRecipes.length, equals(originalLength + 1),
          reason: 'The length of the list did not increase as expected');
    });

    test('readCookingRecipe should return a list of cooking recipes', () async {
      final dataSource = DataSource();

      final result = await dataSource.readCookingRecipe();
      debugPrint(result.toString());

      expect(result, isA<List<CookingRecipe>>());
      // Additional checks if needed
    });

    test('updatedCookingRecipe should update an existing cooking recipe',
        () async {
      final dataSource = DataSource();

      final cookingRecipe = CookingRecipe(
          ingredients: [
            Ingredient(nom: "Riz", quantite: 2, typeQuantite: "kg").toString()
          ],
          nomAgent: "Mr Beast",
          nomPlat: "Riz Sauté",
          stepsPreparation: [
            "Laver le riz",
            "Mettre l'eau salé sur le feu",
            "Verser le RIZ",
            "..."
          ],
          time: 30,
          urlVideo: "https://youtube.com/");

      // Add the recipe to the database first
      await dataSource.createdCookingRecipe(cookingRecipe);

      // Retrieve the list of recipes
      final recipesBeforeUpdate = await dataSource.readCookingRecipe();

      // Update the first recipe
      final updatedRecipe = CookingRecipe(
          ingredients: [
            Ingredient(nom: "Riz", quantite: 2, typeQuantite: "kg").toString(),
            Ingredient(
                    nom: "Grosse Tomate Cuite",
                    quantite: 5,
                    typeQuantite: "morceau")
                .toString()
          ],
          nomPlat: "Riz au gras Sauté",
          nomAgent: "Mr Beast",
          stepsPreparation: [
            "Laver le riz",
            "Faire une friture de tomate simple",
            "Verser le RIZ",
            "..."
          ],
          time: 32,
          urlVideo: "https://youtube.com/");
      final updateResult =
          await dataSource.updatedCookingRecipe(updatedRecipe, 0);

      // Retrieve the updated list of recipes
      final recipesAfterUpdate = await dataSource.readCookingRecipe();

      expect(updateResult, true);
      expect(recipesBeforeUpdate[0], isNot(equals(recipesAfterUpdate[0])));
      // Additional checks if needed
    });

    test('deletedCookingRecipe should delete an existing cooking recipe',
        () async {
      final dataSource = DataSource();

      final cookingRecipe = CookingRecipe(
          ingredients: [
            Ingredient(nom: "Riz", quantite: 2, typeQuantite: "kg").toString()
          ],
          nomAgent: "Mr Beast",
          nomPlat: "Riz Sauté",
          stepsPreparation: [
            "Laver le riz",
            "Mettre l'eau salé sur le feu",
            "Verser le RIZ",
            "..."
          ],
          time: 30,
          urlVideo: "https://youtube.com/");

      // Add the recipe to the database first
      await dataSource.createdCookingRecipe(cookingRecipe);

      // Retrieve the list of recipes
      final recipesBeforeDeletion = await dataSource.readCookingRecipe();

      // Delete the first recipe
      final deleteResult = await dataSource.deletedCookingRecipe(0);

      // Retrieve the updated list of recipes
      final recipesAfterDeletion = await dataSource.readCookingRecipe();

      expect(deleteResult, true);
      expect(recipesBeforeDeletion.length,
          equals(recipesAfterDeletion.length + 1));
      // Additional checks if needed
    });

    test('sendEmail should not throw an exception', () {
      final dataSource = DataSource();

      final cookingRecipe = CookingRecipe(
          ingredients: [
            Ingredient(nom: "Riz", quantite: 2, typeQuantite: "kg").toString()
          ],
          nomAgent: "Mr Beast",
          nomPlat: "Riz Sauté",
          stepsPreparation: [
            "Laver le riz",
            "Mettre l'eau salé sur le feu",
            "Verser le RIZ",
            "..."
          ],
          time: 30,
          urlVideo: "https://youtube.com/");

      expect(() => dataSource.sendEmail("test@example.com", cookingRecipe),
          returnsNormally);
    });

    // Additional tests for _prettyPrintIngredients and _prettyPrintSteps if needed
  });
}
