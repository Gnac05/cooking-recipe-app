import 'package:cooking_recipe_app/injection_container.dart';
import 'package:cooking_recipe_app/infrastructure/cooking-recipe/data-sources/data_source.dart';
import 'package:cooking_recipe_app/domain/cooking-recipe/model/cooking_recipe.dart';
import 'package:cooking_recipe_app/domain/cooking-recipe/model/ingredient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'cooking_recipe_event.dart';
part 'cooking_recipe_state.dart';

class CookingRecipeBloc extends Bloc<CookingRecipeEvent, CookingRecipeState> {
  CookingRecipeBloc() : super(CookingRecipeInitial()) {
    on<CreatedCookingRecipeEvent>((event, emit) async {
      try {
        emit(CookingRecipeLoading());
        final isCreated =
            await getIt<DataSource>().createdCookingRecipe(event.cookingRecipe);
        if (isCreated) {
          emit(CookingRecipeSucessful());
        } else {
          emit(CookingRecipeError(message: "Something went wrong !!!"));
        }
      } catch (e) {
        debugPrint("### Error Message : $e");
        emit(
          CookingRecipeError(
            message: e.toString(),
          ),
        );
      }
    });

    on<ReadCookingRecipesEvent>((event, emit) async {
      try {
        emit(CookingRecipeLoading());
        final cookingRecipes = await getIt<DataSource>().readCookingRecipe();
        if (cookingRecipes == null) {
          emit(
            CookingRecipeError(
              message: "Something went wrong !!!",
            ),
          );
        } else {
          emit(CookingRecipeReady(cookingRecipes: cookingRecipes));
        }
      } catch (e) {
        debugPrint("### Error Message : $e");
        emit(
          CookingRecipeError(
            message: e.toString(),
          ),
        );
      }
    });

    on<UpdatedCookingRecipeEvent>((event, emit) async {
      try {
        emit(CookingRecipeLoading());
        final isUpdated = await getIt<DataSource>()
            .updatedCookingRecipe(event.cookingRecipe, event.index);
        if (isUpdated) {
          emit(CookingRecipeSucessful());
        } else {
          emit(CookingRecipeError(message: "Something went wrong !!!"));
        }
      } catch (e) {
        debugPrint("### Error Message : $e");
        emit(
          CookingRecipeError(
            message: e.toString(),
          ),
        );
      }
    });

    on<DeletedCookingRecipeEvent>((event, emit) async {
      try {
        emit(CookingRecipeLoading());
        final isDeleted =
            await getIt<DataSource>().deletedCookingRecipe(event.index);
        if (isDeleted) {
          emit(CookingRecipeSucessful());
        } else {
          emit(CookingRecipeError(message: "Something went wrong !!!"));
        }
      } catch (e) {
        debugPrint("### Error Message : $e");
        emit(
          CookingRecipeError(
            message: e.toString(),
          ),
        );
      }
    });

    on<ShareCookingRecipeEvent>((event, emit) {
      try {
        // emit(CookingRecipeLoading());
        getIt<DataSource>().sendEmail(event.email, event.cookingRecipe);
        // emit(CookingRecipeSucessful());
      } catch (e) {
        debugPrint("### Error Message : $e");
        emit(
          CookingRecipeError(
            message: e.toString(),
          ),
        );
      }
    });

    on<AddIngredientEvent>((event, emit) {
      try {
        final data = <Ingredient>[];
        data.addAll(event.ingredients);
        data.add(event.ingredient);
        emit(
          IngredientReady(
            ingredients: data,
          ),
        );
      } catch (e) {
        debugPrint("### Error Message : $e");
        emit(
          CookingRecipeError(
            message: e.toString(),
          ),
        );
      }
    });

    on<AddStepEvent>((event, emit) {
      try {
        final data = <String>[];
        data.addAll(event.steps);
        data.add(event.step);
        emit(
          StepReady(
            steps: data,
          ),
        );
      } catch (e) {
        debugPrint("### Error Message : $e");
        emit(
          CookingRecipeError(
            message: e.toString(),
          ),
        );
      }
    });
  }
}
