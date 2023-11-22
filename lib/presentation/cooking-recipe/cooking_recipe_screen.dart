import 'package:cooking_recipe_app/injection_container.dart';
import 'package:cooking_recipe_app/domain/cooking-recipe/model/cooking_recipe.dart';
import 'package:cooking_recipe_app/domain/cooking-recipe/model/ingredient.dart';
import 'package:cooking_recipe_app/application/cooking-recipe/cooking_recipe_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CookingRecipeScreen extends StatefulWidget {
  const CookingRecipeScreen(
      {Key? key, required this.isCreation, this.index, this.cookR})
      : super(key: key);
  final bool isCreation;
  final int? index;
  final CookingRecipe? cookR;

  @override
  State<CookingRecipeScreen> createState() => _CookingRecipeScreenState();
}

class _CookingRecipeScreenState extends State<CookingRecipeScreen> {
  TextEditingController agentController = TextEditingController();
  TextEditingController platController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController urlController = TextEditingController();

  final addIngBloc = CookingRecipeBloc();
  final addStepBloc = CookingRecipeBloc();

  List<Ingredient> ingredients = [];
  List<String> steps = [];

  @override
  void initState() {
    ingredients = <Ingredient>[];
    steps = <String>[];
    if (!widget.isCreation) {
      for (var step in widget.cookR!.steps) {
        steps.add(step["content"]??"Loading...");
      }
      for (var map in widget.cookR!.ingredients) {
        ingredients.add(Ingredient.fromMap(map));
      }
      agentController.text = widget.cookR!.agent;
      platController.text = widget.cookR!.name;
      timeController.text = widget.cookR!.preparationTime.toString();
      urlController.text = widget.cookR!.videoUrl;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MA RECETTE"),
        centerTitle: true,
        actions: [
          if (!widget.isCreation)
            IconButton(
              onPressed: () {
                getIt<CookingRecipeBloc>().add(
                  DeletedCookingRecipeEvent(index: widget.index!),
                );
                debugPrint("### DeletedCookingRecipeEvent");
                Navigator.pop(context);
              },
              icon: const Icon(Icons.delete),
            ),
          if (!widget.isCreation)
            IconButton(
              onPressed: () {
                TextEditingController emailCtr = TextEditingController();
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text("Partage par email"),
                    content: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if (value!.isEmpty ||
                                    !RegExp(r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$")
                                        .hasMatch(value)) {
                                  return 'Entrer un email valide';
                                }
                                return null;
                              },
                              controller: emailCtr,
                              maxLines: 5,
                              minLines: 1,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                  ),
                                  labelText: "Email"),
                            ),
                          ),
                        ],
                      ),
                    ),
                    actionsAlignment: MainAxisAlignment.spaceBetween,
                    actions: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Retour"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (emailCtr.text.isNotEmpty) {
                            getIt<CookingRecipeBloc>().add(
                                ShareCookingRecipeEvent(
                                    email: emailCtr.text.trim(),
                                    cookingRecipe: widget.cookR!,),);
                            Navigator.pop(context);
                          }
                        },
                        child: const Text("OK"),
                      )
                    ],
                  ),
                );
              },
              icon: const Icon(Icons.share),
            )
        ],
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) =>
                  value!.isEmpty ? "Ne doit pas être vide" : null,
              controller: agentController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  labelText: "name de l'Agent"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) =>
                  value!.isEmpty ? "Ne doit pas être vide" : null,
              controller: platController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                labelText: "name du Plat",
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) =>
                  value!.isEmpty ? "Ne doit pas être vide" : null,
              controller: timeController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  labelText: "Temps de Préparation"),
              keyboardType: TextInputType.number,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) =>
                  value!.isEmpty ? "Ne doit pas être vide" : null,
              controller: urlController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  labelText: "URL de la Vidéo"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: BlocBuilder<CookingRecipeBloc, CookingRecipeState>(
              bloc: addIngBloc,
              builder: (context, state) {
                if (state is IngredientReady) {
                  ingredients = state.ingredients;
                }
                return AddIngredient(
                  list: ingredients,
                  bloc: addIngBloc,
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: BlocBuilder<CookingRecipeBloc, CookingRecipeState>(
              bloc: addStepBloc,
              builder: (context, state) {
                if (state is StepReady) {
                  steps = state.steps;
                }
                return AddStep(
                  list: steps,
                  bloc: addStepBloc,
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: ElevatedButton(
          onPressed: () {
            final agent = agentController.text.trim();
            final plat = platController.text.trim();
            final url = urlController.text.trim();
            final time = timeController.text.trim();
            if (agent.isNotEmpty &&
                plat.isNotEmpty &&
                url.isNotEmpty &&
                time.isNotEmpty) {
              final ing = <Map<String, String>>[];
              for (var element in ingredients) {
                ing.add(element.toMap());
              }
              final stepsMap = <Map<String, String>>[];
              for (var element in steps) {
                stepsMap.add({"content": element});
              }
              CookingRecipe cook = CookingRecipe(
                agent: agent,
                name: plat,
                videoUrl: url,
                ingredients: ing,
                steps: stepsMap,
                preparationTime: int.parse(time),
              );

              if (widget.isCreation) {
                getIt<CookingRecipeBloc>().add(
                  CreatedCookingRecipeEvent(
                    cookingRecipe: cook,
                  ),
                );
                debugPrint("### CreatedCookingRecipeEvent");
              } else {
                getIt<CookingRecipeBloc>().add(
                  UpdatedCookingRecipeEvent(
                    cookingRecipe: cook,
                    index: widget.index!,
                  ),
                );
                debugPrint("### UpdatedCookingRecipeEvent");
              }
              Navigator.pop(context);
            }
          },
          child: Text(
            widget.isCreation ? "Ajouter" : "Mettre à jour",
          ),
        ),
      ),
    );
  }
}

class AddIngredient extends StatelessWidget {
  const AddIngredient({Key? key, required this.list, required this.bloc})
      : super(key: key);
  final List<Ingredient> list;
  final CookingRecipeBloc bloc;
  @override
  Widget build(BuildContext context) {
    TextEditingController nomCtr = TextEditingController();
    TextEditingController quantiteCtr = TextEditingController();
    TextEditingController typeQuCtr = TextEditingController();
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Ingrédiens",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            FloatingActionButton(
              heroTag: "ADD_INGREDIENT",
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text("Ajouter un ingrédient"),
                    content: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) => value!.isEmpty
                                  ? "Ne doit pas être vide"
                                  : null,
                              controller: nomCtr,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                  ),
                                  labelText: "name"),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) => value!.isEmpty
                                  ? "Ne doit pas être vide"
                                  : null,
                              controller: quantiteCtr,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                  ),
                                  labelText: "Quantité"),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) => value!.isEmpty
                                  ? "Ne doit pas être vide"
                                  : null,
                              controller: typeQuCtr,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                ),
                                labelText: "Type de quantité",
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    actionsAlignment: MainAxisAlignment.spaceBetween,
                    actions: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Retour"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (nomCtr.text.isNotEmpty &&
                              typeQuCtr.text.isNotEmpty &&
                              quantiteCtr.text.isNotEmpty) {
                            bloc.add(AddIngredientEvent(
                                ingredient: Ingredient(
                                  name: nomCtr.text.trim(),
                                  quantity:
                                      double.parse(quantiteCtr.text.trim()),
                                  type: typeQuCtr.text.trim(),
                                ),
                                ingredients: list));
                            Navigator.pop(context);
                          }
                        },
                        child: const Text("OK"),
                      )
                    ],
                  ),
                );
              },
              child: const Icon(Icons.add, size: 30),
            ),
          ],
        ),
        Column(
          children: List.generate(
            list.length,
            (index) => Text(
              "• ${list[index].quantity} ${list[index].type} de ${list[index].name}",
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
          ),
        )
      ],
    );
  }
}

class AddStep extends StatelessWidget {
  const AddStep({Key? key, required this.list, required this.bloc})
      : super(key: key);
  final List<String> list;
  final CookingRecipeBloc bloc;
  @override
  Widget build(BuildContext context) {
    TextEditingController descCtr = TextEditingController();
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Etapes",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            FloatingActionButton(
              heroTag: "ADD_SPET",
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text("Nouvelle étape"),
                    content: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) => value!.isEmpty
                                  ? "Ne doit pas être vide"
                                  : null,
                              controller: descCtr,
                              maxLines: 5,
                              minLines: 1,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                  ),
                                  labelText: "Description"),
                            ),
                          ),
                        ],
                      ),
                    ),
                    actionsAlignment: MainAxisAlignment.spaceBetween,
                    actions: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Retour"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (descCtr.text.isNotEmpty) {
                            bloc.add(
                              AddStepEvent(
                                step: descCtr.text.trim(),
                                steps: list,
                              ),
                            );
                            Navigator.pop(context);
                          }
                        },
                        child: const Text("OK"),
                      )
                    ],
                  ),
                );
              },
              child: const Icon(Icons.add, size: 30),
            ),
          ],
        ),
        Column(
          children: List.generate(
            list.length,
            (index) => Text(
              "• ${list[index]}",
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
          ),
        )
      ],
    );
  }
}
