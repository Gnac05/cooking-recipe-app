import 'package:cooking_recipe_app/domain/cooking-recipe/model/cooking_recipe.dart';
import 'package:cooking_recipe_app/domain/cooking-recipe/model/ingredient.dart';
import 'package:cooking_recipe_app/infrastructure/cooking-recipe/data-sources/data_source.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Data Source", () {
    test('createdCookingRecipe should add a new cooking recipe', () async {
      TestWidgetsFlutterBinding.ensureInitialized();

      final dataSource = DataSource();

      // Create a sample CookingRecipe
      final cookingRecipe = CookingRecipe(
        ingredients: [Ingredient(name: "Riz", quantity: 2, type: "kg").toMap()],
        agent: "Mr Beast",
        name: "Riz Sauté",
        steps: [
          {"content": "Laver le riz"},
          {"content": "Mettre l'eau salé sur le feu"},
          {"content": "Verser le RIZ"},
          {"content": "..."}
        ],
        preparationTime: 30,
        videoUrl: "https://youtube.com/",
      );

      // Call the function to add the cooking recipe
      final result = await dataSource.createdCookingRecipe(cookingRecipe);

      expect(result, true, reason: 'The function return $result');
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
            Ingredient(name: "Riz", quantity: 2, type: "kg").toMap()
          ],
          agent: "Mr Beast",
          name: "Riz Sauté",
          steps: [
            {"content": "Laver le riz"},
            {"content": "Mettre l'eau salé sur le feu"},
            {"content": "Verser le RIZ",},
            {"content": "..."}
          ],
          preparationTime: 30,
          videoUrl: "https://youtube.com/");

      // Add the recipe to the database first
      await dataSource.createdCookingRecipe(cookingRecipe);

      // Retrieve the list of recipes
      final recipesBeforeUpdate = await dataSource.readCookingRecipe();

      // Update the first recipe
      final updatedRecipe = CookingRecipe(
          ingredients: [
            Ingredient(name: "Riz", quantity: 2, type: "kg").toMap(),
            Ingredient(
                    name: "Grosse Tomate Cuite",
                    quantity: 5,
                    type: "morceau")
                .toMap()
          ],
          name: "Riz au gras Sauté",
          agent: "Mr Beast",
          steps: [
            {"content": "Laver le riz"},
            {"content": "Mettre l'eau salé sur le feu"},
            {"content": "Verser le RIZ",},
            {"content": "..."}
          ],
          preparationTime: 32,
          videoUrl: "https://youtube.com/");
      final updateResult =
          await dataSource.updatedCookingRecipe(updatedRecipe, 0);

      // Retrieve the updated list of recipes
      final recipesAfterUpdate = await dataSource.readCookingRecipe();

      expect(updateResult, true);
      expect(recipesBeforeUpdate?[0], isNot(equals(recipesAfterUpdate?[0])));
      // Additional checks if needed
    });

    test('deletedCookingRecipe should delete an existing cooking recipe',
        () async {
      final dataSource = DataSource();

      final cookingRecipe = CookingRecipe(
          ingredients: [
            Ingredient(name: "Riz", quantity: 2, type: "kg").toMap()
          ],
          agent: "Mr Beast",
          name: "Riz Sauté",
          steps:[
            {"content": "Laver le riz"},
            {"content": "Mettre l'eau salé sur le feu"},
            {"content": "Verser le RIZ",},
            {"content": "..."}
          ],
          preparationTime: 30,
          videoUrl: "https://youtube.com/");

      // Add the recipe to the database first
      await dataSource.createdCookingRecipe(cookingRecipe);

      // Retrieve the list of recipes
      final recipesBeforeDeletion = await dataSource.readCookingRecipe();

      // Delete the first recipe
      final deleteResult = await dataSource.deletedCookingRecipe(0);

      // Retrieve the updated list of recipes
      final recipesAfterDeletion = await dataSource.readCookingRecipe();

      expect(deleteResult, true);
      expect(recipesBeforeDeletion!.length,
          equals(recipesAfterDeletion!.length + 1));
      // Additional checks if needed
    });

    test('sendEmail should not throw an exception', () {
      final dataSource = DataSource();

      final cookingRecipe = CookingRecipe(
          ingredients: [
            Ingredient(name: "Riz", quantity: 2, type: "kg").toMap()
          ],
          agent: "Mr Beast",
          name: "Riz Sauté",
          steps: [
            {"content": "Laver le riz"},
            {"content": "Mettre l'eau salé sur le feu"},
            {"content": "Verser le RIZ"},
            {"content": "..."}
          ],
          preparationTime: 30,
          videoUrl: "https://youtube.com/");

      expect(() => dataSource.sendEmail("test@example.com", cookingRecipe),
          returnsNormally);
    });

    // Additional tests for _prettyPrintIngredients and _prettyPrintSteps if needed
  });
}
