import 'package:card_loading/card_loading.dart';
import 'package:cooking_recipe_app/config/di.dart';
import 'package:cooking_recipe_app/presentation/bloc/cooking_recipe_bloc.dart';
import 'package:cooking_recipe_app/presentation/screen/cooking_recipe_screen.dart';
import 'package:cooking_recipe_app/presentation/widget/cooking_recipe_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = getIt<CookingRecipeBloc>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("MES RECETTES"),
        centerTitle: true,
      ),

      body: BlocBuilder<CookingRecipeBloc, CookingRecipeState>(
        bloc: bloc,
        builder: (context, state) {
          if (state is CookingRecipeInitial) {
            bloc.add(ReadCookingRecipesEvent());
          } else if (state is CookingRecipeSucessful) {
            debugPrint("### CookingRecipeSucessful");
            bloc.add(ReadCookingRecipesEvent());
          } else if (state is CookingRecipeReady) {
            final data = state.cookingRecipes;
            return data.isNotEmpty
                ? ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) => GestureDetector(
                      child: CookingRecipeWidget(
                        cR: data[data.length - 1 - index],
                        index: index,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CookingRecipeScreen(
                              isCreation: false,
                              index: index,
                              cookR: data[index],
                            ),
                          ),
                        );
                      },
                    ),
                    itemCount: data.length,
                  )
                : const Center(
                    child: Text(
                      "Aucune recette enregistrer. Appuier sur le bouton Ajouter en bas pour y remédier.",
                      textAlign: TextAlign.center,
                    ),
                  );
          } else if (state is CookingRecipeLoading) {
            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: 10,
              itemBuilder: (context, index) => const Padding(
                padding: EdgeInsets.all(10.0),
                child: CardLoading(
                  height: 175,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
              ),
            );
          } else if (state is CookingRecipeError) {
            return const Center(
              child: Text(
                "Quelque chose s'est mal passé !!!",
                textAlign: TextAlign.center,
              ),
            );
          }
          return const Padding(
            padding: EdgeInsets.all(10.0),
            child: CardLoading(
              height: 175,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    const CookingRecipeScreen(isCreation: true),
              ),
            );
          },
          child: const Text(
            "Nouvelle recette",
          ),
        ),
      ),
    );
  }
}
