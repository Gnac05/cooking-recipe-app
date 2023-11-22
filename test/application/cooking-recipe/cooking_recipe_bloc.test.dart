// import 'package:bloc_test/bloc_test.dart';
// import 'package:cooking_recipe_app/application/cooking-recipe/cooking_recipe_bloc.dart';
// import 'package:cooking_recipe_app/domain/cooking-recipe/model/cooking_recipe.dart';
// import 'package:cooking_recipe_app/domain/cooking-recipe/model/ingredient.dart';
// import 'package:cooking_recipe_app/infrastructure/cooking-recipe/data-sources/data_source.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';

// class MockDataSource extends Mock implements DataSource {}

// void main() {
//   group('CookingRecipeBloc', () {
//     final mockDataSource = MockDataSource();
//     final cookingRecipeBloc =
//         CookingRecipeBloc(/* dataSource: mockDataSource */);
//     final cookingRecipe = CookingRecipe(
//       ingredients: [
//         Ingredient(nom: "Riz", quantite: 2, typeQuantite: "kg").toString()
//       ],
//       nomAgent: "Mr Beast",
//       nomPlat: "Riz Sauté",
//       stepsPreparation: [
//         "Laver le riz",
//         "Mettre l'eau salé sur le feu",
//         "Verser le RIZ",
//         "..."
//       ],
//       time: 30,
//       urlVideo: "https://youtube.com/",
//     );
//     final cookingRecipeNew = CookingRecipe(
//         ingredients: [
//           Ingredient(nom: "Riz", quantite: 2, typeQuantite: "kg").toString(),
//           Ingredient(
//                   nom: "Grosse Tomate Cuite",
//                   quantite: 5,
//                   typeQuantite: "morceau")
//               .toString()
//         ],
//         nomPlat: "Riz au gras Sauté",
//         nomAgent: "Mr Beast",
//         stepsPreparation: [
//           "Laver le riz",
//           "Faire une friture de tomate simple",
//           "Verser le RIZ",
//           "..."
//         ],
//         time: 32,
//         urlVideo: "https://youtube.com/");

//     blocTest<CookingRecipeBloc, CookingRecipeState>(
//       'emits CookingRecipeSucessful when CreatedCookingRecipeEvent is added',
//       build: () => cookingRecipeBloc,
//       act: (bloc) async {
//         // Mock the behavior of createdCookingRecipe to return true
//         when(mockDataSource.createdCookingRecipe(cookingRecipe))
//             .thenAnswer((_) async => true);

//         bloc.add(CreatedCookingRecipeEvent(cookingRecipe: cookingRecipe));
//       },
//       expect: () => [CookingRecipeLoading(), CookingRecipeSucessful()],
//     );

//     blocTest<CookingRecipeBloc, CookingRecipeState>(
//       'emits CookingRecipeError when CreatedCookingRecipeEvent fails',
//       build: () => cookingRecipeBloc,
//       act: (bloc) async {
//         // Mock the behavior of createdCookingRecipe to return false (failure)
//         when(mockDataSource.createdCookingRecipe(cookingRecipe))
//             .thenAnswer((_) async => false);

//         bloc.add(CreatedCookingRecipeEvent(cookingRecipe: cookingRecipe));
//       },
//       expect: () => [
//         CookingRecipeLoading(),
//         CookingRecipeError(message: "Something went wrong !!!")
//       ],
//     );

//     blocTest<CookingRecipeBloc, CookingRecipeState>(
//       'emits CookingRecipeReady when ReadCookingRecipesEvent is added',
//       build: () => cookingRecipeBloc,
//       act: (bloc) async {
//         // Mock the behavior of readCookingRecipe to return a list of cooking recipes
//         when(mockDataSource.readCookingRecipe())
//             .thenAnswer((_) async => [cookingRecipe]);

//         bloc.add(ReadCookingRecipesEvent());
//       },
//       expect: () => [
//         CookingRecipeLoading(),
//         CookingRecipeReady(cookingRecipes: [cookingRecipe])
//       ],
//     );

//     blocTest<CookingRecipeBloc, CookingRecipeState>(
//       'emits CookingRecipeError when ReadCookingRecipesEvent fails',
//       build: () => cookingRecipeBloc,
//       act: (bloc) async {
//         // Mock the behavior of readCookingRecipe to throw an error (failure)
//         when(mockDataSource.readCookingRecipe())
//             .thenThrow(Exception("Something went wrong !!!"));

//         bloc.add(ReadCookingRecipesEvent());
//       },
//       expect: () => [
//         CookingRecipeLoading(),
//         CookingRecipeError(message: "Something went wrong !!!")
//       ],
//     );

//     blocTest<CookingRecipeBloc, CookingRecipeState>(
//       'emits CookingRecipeSucessful when UpdatedCookingRecipeEvent is added',
//       build: () => cookingRecipeBloc,
//       act: (bloc) async {
//         // Mock the behavior of updatedCookingRecipe to return true
//         when(mockDataSource.updatedCookingRecipe(cookingRecipeNew, 0))
//             .thenAnswer((_) async => true);

//         bloc.add(UpdatedCookingRecipeEvent(
//             cookingRecipe: cookingRecipeNew, index: 0));
//       },
//       expect: () => [CookingRecipeLoading(), CookingRecipeSucessful()],
//     );

//     blocTest<CookingRecipeBloc, CookingRecipeState>(
//       'emits CookingRecipeError when UpdatedCookingRecipeEvent fails',
//       build: () => cookingRecipeBloc,
//       act: (bloc) async {
//         // Mock the behavior of updatedCookingRecipe to return false (failure)
//         when(mockDataSource.updatedCookingRecipe(cookingRecipeNew, 0))
//             .thenAnswer((_) async => false);

//         bloc.add(UpdatedCookingRecipeEvent(
//             cookingRecipe: cookingRecipeNew, index: 0));
//       },
//       expect: () => [
//         CookingRecipeLoading(),
//         CookingRecipeError(message: "Something went wrong !!!")
//       ],
//     );

//     blocTest<CookingRecipeBloc, CookingRecipeState>(
//       'emits CookingRecipeSucessful when DeletedCookingRecipeEvent is added',
//       build: () => cookingRecipeBloc,
//       act: (bloc) async {
//         // Mock the behavior of deletedCookingRecipe to return true
//         when(mockDataSource.deletedCookingRecipe(0))
//             .thenAnswer((_) async => true);

//         bloc.add(DeletedCookingRecipeEvent(index: 0));
//       },
//       expect: () => [CookingRecipeLoading(), CookingRecipeSucessful()],
//     );

//     blocTest<CookingRecipeBloc, CookingRecipeState>(
//       'emits CookingRecipeError when DeletedCookingRecipeEvent fails',
//       build: () => cookingRecipeBloc,
//       act: (bloc) async {
//         // Mock the behavior of deletedCookingRecipe to return false (failure)
//         when(mockDataSource.deletedCookingRecipe(0))
//             .thenAnswer((_) async => false);

//         bloc.add(DeletedCookingRecipeEvent(index: 0));
//       },
//       expect: () => [
//         CookingRecipeLoading(),
//         CookingRecipeError(message: "Something went wrong !!!")
//       ],
//     );

//     blocTest<CookingRecipeBloc, CookingRecipeState>(
//       'emits CookingRecipeError when ShareCookingRecipeEvent fails',
//       build: () => cookingRecipeBloc,
//       act: (bloc) async {
//         // Mock the behavior of sendEmail to throw an error (failure)
//         when(mockDataSource.sendEmail("test@example.com", cookingRecipe))
//             .thenThrow(Exception("Something went wrong !!!"));

//         bloc.add(ShareCookingRecipeEvent(
//             email: "test@example.com", cookingRecipe: cookingRecipe));
//       },
//       expect: () => [CookingRecipeError(message: "Something went wrong !!!")],
//     );

//     blocTest<CookingRecipeBloc, CookingRecipeState>(
//       'emits IngredientReady when AddIngredientEvent is added',
//       build: () => cookingRecipeBloc,
//       act: (bloc) async {
//         bloc.add(AddIngredientEvent(
//             ingredients: [
//               Ingredient(
//                   nom: "Ingr Name", quantite: 5, typeQuantite: "typeQuantite")
//             ],
//             ingredient:
//                 Ingredient(nom: "LKJ", quantite: 2, typeQuantite: "mesure")));
//       },
//       expect: () => [
//         IngredientReady(ingredients: [
//           Ingredient(
//               nom: "Ingr Name", quantite: 5, typeQuantite: "typeQuantite"),
//           Ingredient(nom: "LKJ", quantite: 2, typeQuantite: "mesure")
//         ])
//       ],
//     );

//     blocTest<CookingRecipeBloc, CookingRecipeState>(
//       'emits StepReady when AddStepEvent is added',
//       build: () => cookingRecipeBloc,
//       act: (bloc) async {
//         bloc.add(
//             AddStepEvent(steps: const ["Step 1", "Step 2"], step: "New Step"));
//       },
//       expect: () => [
//         StepReady(steps: const ["Step 1", "Step 2", "New Step"])
//       ],
//     );

//     tearDown(() {
//       cookingRecipeBloc.close();
//     });
//   });
// }
