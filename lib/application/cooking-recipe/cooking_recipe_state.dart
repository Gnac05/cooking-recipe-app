part of 'cooking_recipe_bloc.dart';

@immutable
sealed class CookingRecipeState {}

final class CookingRecipeInitial extends CookingRecipeState {}

class CookingRecipeLoading extends CookingRecipeState {}

class CookingRecipeReady extends CookingRecipeState {
  final List<CookingRecipe> cookingRecipes;

  CookingRecipeReady({required this.cookingRecipes});
}

class CookingRecipeSucessful extends CookingRecipeState {}

class CookingRecipeError extends CookingRecipeState {
  final String message;

  CookingRecipeError({required this.message});
}

class IngredientReady extends CookingRecipeState {
  final List<Ingredient> ingredients;

  IngredientReady({required this.ingredients});
}

class StepReady extends CookingRecipeState {
  final List<String> steps;

  StepReady({required this.steps});
}
