part of 'cooking_recipe_bloc.dart';

@immutable
sealed class CookingRecipeEvent {}

class CreatedCookingRecipeEvent extends CookingRecipeEvent{
  final CookingRecipe cookingRecipe;

  CreatedCookingRecipeEvent({required this.cookingRecipe});
}

class ReadCookingRecipesEvent extends CookingRecipeEvent{
}

class UpdatedCookingRecipeEvent extends CookingRecipeEvent{
  final CookingRecipe cookingRecipe;
  final int index;

  UpdatedCookingRecipeEvent({required this.cookingRecipe, required this.index});
}

class DeletedCookingRecipeEvent extends CookingRecipeEvent{
  final int index;

  DeletedCookingRecipeEvent({required this.index});
}

class ShareCookingRecipeEvent extends CookingRecipeEvent{
  final String email;
  final CookingRecipe cookingRecipe;

  ShareCookingRecipeEvent({required this.email, required this.cookingRecipe});
}

class AddIngredientEvent extends CookingRecipeEvent{
  final Ingredient ingredient;
  final List<Ingredient> ingredients;

  AddIngredientEvent({required this.ingredient, required this.ingredients});
}

class AddStepEvent extends CookingRecipeEvent{
  final String step;
  final List<String> steps;

  AddStepEvent({required this.step, required this.steps});
}
