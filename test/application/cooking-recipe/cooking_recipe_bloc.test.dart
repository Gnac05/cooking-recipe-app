import 'package:bloc_test/bloc_test.dart';
import 'package:cooking_recipe_app/application/cooking-recipe/cooking_recipe_bloc.dart';
import 'package:cooking_recipe_app/domain/cooking-recipe/model/cooking_recipe.dart';
import 'package:cooking_recipe_app/domain/cooking-recipe/model/ingredient.dart';
import 'package:cooking_recipe_app/infrastructure/cooking-recipe/data-sources/data_source.dart';
import 'package:cooking_recipe_app/injection_container.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockDataSource extends Mock implements DataSource {
  // @override
  // Future<bool> createdCookingRecipe(cookingRecipe);
}

void main()  {
  setup();
  group('CookingRecipeBloc', () {
    final mockDataSource = MockDataSource();
    final cookingRecipeBloc =
        CookingRecipeBloc();
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
        videoUrl: "https://youtube.com/");
    final cookingRecipeNew = CookingRecipe(
        ingredients: [
          Ingredient(name: "Riz", quantity: 2, type: "kg").toMap(),
          Ingredient(name: "Grosse Tomate Cuite", quantity: 5, type: "morceau")
              .toMap()
        ],
        name: "Riz au gras Sauté",
        agent: "Mr Beast",
        steps: [
          {"content": "Laver le riz"},
          {"content": "Mettre l'eau salé sur le feu"},
          {
            "content": "Verser le RIZ",
          },
          {"content": "..."}
        ],
        preparationTime: 32,
        videoUrl: "https://youtube.com/");

    blocTest<CookingRecipeBloc, CookingRecipeState>(
      'emits CookingRecipeSucessful when CreatedCookingRecipeEvent is added',
      build: () => cookingRecipeBloc,
      act: (bloc) {
        // Mock the behavior of createdCookingRecipe to return true
        when(mockDataSource.createdCookingRecipe(cookingRecipe))
            .thenAnswer((_) async => true);

        bloc.add(CreatedCookingRecipeEvent(cookingRecipe: cookingRecipe));
      },
      expect: () => [CookingRecipeLoading(), CookingRecipeSucessful()],
    );

    blocTest<CookingRecipeBloc, CookingRecipeState>(
      'emits CookingRecipeError when CreatedCookingRecipeEvent fails',
      build: () => cookingRecipeBloc,
      act: (bloc) async {
        // Mock the behavior of createdCookingRecipe to return false (failure)
        when(mockDataSource.createdCookingRecipe(cookingRecipe))
            .thenAnswer((_) async => false);

        bloc.add(CreatedCookingRecipeEvent(cookingRecipe: cookingRecipe));
      },
      expect: () => [
        CookingRecipeLoading(),
        CookingRecipeError(message: "Something went wrong !!!")
      ],
    );

    blocTest<CookingRecipeBloc, CookingRecipeState>(
      'emits CookingRecipeReady when ReadCookingRecipesEvent is added',
      build: () => cookingRecipeBloc,
      act: (bloc) async {
        // Mock the behavior of readCookingRecipe to return a list of cooking recipes
        when(mockDataSource.readCookingRecipe())
            .thenAnswer((_) async => [cookingRecipe]);

        bloc.add(ReadCookingRecipesEvent());
      },
      expect: () => [
        CookingRecipeLoading(),
        CookingRecipeReady(cookingRecipes: [cookingRecipe])
      ],
    );

    blocTest<CookingRecipeBloc, CookingRecipeState>(
      'emits CookingRecipeError when ReadCookingRecipesEvent fails',
      build: () => cookingRecipeBloc,
      act: (bloc) async {
        // Mock the behavior of readCookingRecipe to throw an error (failure)
        when(mockDataSource.readCookingRecipe())
            .thenThrow(Exception("Something went wrong !!!"));

        bloc.add(ReadCookingRecipesEvent());
      },
      expect: () => [
        CookingRecipeLoading(),
        CookingRecipeError(message: "Something went wrong !!!")
      ],
    );

    blocTest<CookingRecipeBloc, CookingRecipeState>(
      'emits CookingRecipeSucessful when UpdatedCookingRecipeEvent is added',
      build: () => cookingRecipeBloc,
      act: (bloc) async {
        final recipes = await DataSource().readCookingRecipe();
        // Mock the behavior of updatedCookingRecipe to return true
        when(mockDataSource.updatedCookingRecipe(cookingRecipeNew, recipes!.first.id))
            .thenAnswer((_) async => true);

        bloc.add(UpdatedCookingRecipeEvent(
            cookingRecipe: cookingRecipeNew, index: recipes.first.id));
      },
      expect: () => [CookingRecipeLoading(), CookingRecipeSucessful()],
    );

    blocTest<CookingRecipeBloc, CookingRecipeState>(
      'emits CookingRecipeError when UpdatedCookingRecipeEvent fails',
      build: () => cookingRecipeBloc,
      act: (bloc) async {
        final recipes = await DataSource().readCookingRecipe();
        // Mock the behavior of updatedCookingRecipe to return false (failure)
        when(mockDataSource.updatedCookingRecipe(cookingRecipeNew, recipes!.first.id))
            .thenAnswer((_) async => false);

        bloc.add(UpdatedCookingRecipeEvent(
            cookingRecipe: cookingRecipeNew, index: recipes.first.id));
      },
      expect: () => [
        CookingRecipeLoading(),
        CookingRecipeError(message: "Something went wrong !!!")
      ],
    );

    blocTest<CookingRecipeBloc, CookingRecipeState>(
      'emits CookingRecipeSucessful when DeletedCookingRecipeEvent is added',
      build: () => cookingRecipeBloc,
      act: (bloc) async {
        final recipes = await DataSource().readCookingRecipe();
        // Mock the behavior of deletedCookingRecipe to return true
        when(mockDataSource.deletedCookingRecipe(recipes!.first.id))
            .thenAnswer((_) async => true);

        bloc.add(DeletedCookingRecipeEvent(index: recipes.first.id));
      },
      expect: () => [CookingRecipeLoading(), CookingRecipeSucessful()],
    );

    blocTest<CookingRecipeBloc, CookingRecipeState>(
      'emits CookingRecipeError when DeletedCookingRecipeEvent fails',
      build: () => cookingRecipeBloc,
      act: (bloc) async {
        final recipes = await DataSource().readCookingRecipe();
        // Mock the behavior of deletedCookingRecipe to return false (failure)
        when(mockDataSource.deletedCookingRecipe(recipes!.first.id))
            .thenAnswer((_) async => false);

        bloc.add(DeletedCookingRecipeEvent(index: recipes.first.id));
      },
      expect: () => [
        CookingRecipeLoading(),
        CookingRecipeError(message: "Something went wrong !!!")
      ],
    );

    blocTest<CookingRecipeBloc, CookingRecipeState>(
      'emits CookingRecipeError when ShareCookingRecipeEvent fails',
      build: () => cookingRecipeBloc,
      act: (bloc) async {
        // Mock the behavior of sendEmail to throw an error (failure)
        when(mockDataSource.sendEmail("test@example.com", cookingRecipe))
            .thenThrow(Exception("Something went wrong !!!"));

        bloc.add(ShareCookingRecipeEvent(
            email: "test@example.com", cookingRecipe: cookingRecipe));
      },
      expect: () => [CookingRecipeError(message: "Something went wrong !!!")],
    );

    blocTest<CookingRecipeBloc, CookingRecipeState>(
      'emits IngredientReady when AddIngredientEvent is added',
      build: () => cookingRecipeBloc,
      act: (bloc) async {
        bloc.add(AddIngredientEvent(
            ingredients: [
              Ingredient(
                  name: "Ingr Name", quantity: 5, type: "type")
            ],
            ingredient:
                Ingredient(name: "LKJ", quantity: 2, type: "mesure")));
      },
      expect: () => [
        IngredientReady(ingredients: [
          Ingredient(
              name: "Ingr Name", quantity: 5, type: "type"),
          Ingredient(name: "LKJ", quantity: 2, type: "mesure")
        ])
      ],
    );

    blocTest<CookingRecipeBloc, CookingRecipeState>(
      'emits StepReady when AddStepEvent is added',
      build: () => cookingRecipeBloc,
      act: (bloc) async {
        bloc.add(
            AddStepEvent(steps: const ["Step 1", "Step 2"], step: "New Step"));
      },
      expect: () => [
        StepReady(steps: const ["Step 1", "Step 2", "New Step"])
      ],
    );

    tearDown(() {
      cookingRecipeBloc.close();
    });
  });
}
