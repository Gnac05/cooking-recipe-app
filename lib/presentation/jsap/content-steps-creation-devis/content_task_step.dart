import 'package:cooking_recipe_app/application/jsap-bloc/jsap_bloc.dart';
import 'package:cooking_recipe_app/injection_container.dart';
import 'package:cooking_recipe_app/presentation/jsap/widget/demand_button.dart';
import 'package:cooking_recipe_app/presentation/jsap/widget/type_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';

class ContentTaskStep extends StatelessWidget {
  const ContentTaskStep({Key? key, required this.bloc}) : super(key: key);
  final JsapBloc bloc;

  @override
  Widget build(BuildContext context) {
    final blocQuantity = getIt<JsapBloc>();
    final blocSwitch = getIt<JsapBloc>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 14, left: 12, right: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    "Type de mission : ",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  TypeWidget()
                ],
              ),
              FaIcon(FontAwesomeIcons.penToSquare),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 12, right: 12),
          child: Text(
            "Nature des travaux : ",
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 12, right: 12),
          child: Text(
            "Décrivez chaque tâche à effectuer dans un champ séparé",
            style: TextStyle(
              fontSize: 14,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          width: double.infinity,
          decoration: const BoxDecoration(color: Colors.black12),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Description de la tâche : ",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20, top: 8),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      hintText: "Tonte, taille de haie...",
                    ),
                  ),
                ),
                Row(
                  children: [
                    const Expanded(
                      child: Center(
                        child: Text(
                          "Tarif : ",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: TextFormField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                            hintText: "0.00",
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ),
                    const Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text("€ HT "),
                          FaIcon(
                            FontAwesomeIcons.circleQuestion,
                            size: 30,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Expanded(
                      child: Center(
                        child: Text(
                          "Quantité : ",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 18, bottom: 25, right: 35),
                        child: BlocBuilder<JsapBloc, JsapState>(
                          bloc: blocQuantity,
                          builder: (context, state) {
                            int quantity = 1;
                            TextEditingController controller =
                                TextEditingController(
                                    text: quantity.toString());
                            if (state is QuantityState) {
                              quantity = state.quantity;
                              controller.text = quantity.toString();
                            }
                            return TextFormField(
                              controller: controller,
                              onChanged: (value) {
                                quantity = int.parse(value);
                              },
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
                                suffixIcon: SizedBox(
                                  height: 50,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 25,
                                        child: IconButton(
                                          onPressed: () {
                                            blocQuantity.add(
                                              QuantityAddEvent(
                                                lastQuantity: quantity,
                                              ),
                                            );
                                          },
                                          icon: const FaIcon(
                                              FontAwesomeIcons.angleUp,
                                              color: Colors.black,
                                              size: 20),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 25,
                                        child: IconButton(
                                          color: Colors.white,
                                          onPressed: () {
                                            blocQuantity.add(
                                              QuantityRemoveEvent(
                                                lastQuantity: quantity,
                                              ),
                                            );
                                          },
                                          icon: const FaIcon(
                                            FontAwesomeIcons.angleDown,
                                            color: Colors.black,
                                            size: 20,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Divider(thickness: 1),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: BlocBuilder<JsapBloc, JsapState>(
                    bloc: blocSwitch,
                    builder: (context, state) {
                      bool isChecked = false;
                      if (state is SeeMoreState) {
                        isChecked = state.isSeeMore;
                      }
                      return SwitchListTile.adaptive(
                        controlAffinity: ListTileControlAffinity.leading,
                        value: isChecked,
                        title: const Text("AFFICHER PLUS DE CRITERES"),
                        onChanged: (value) {
                          blocSwitch.add(
                            SeeMoreCrEvent(
                              isSeeMore: value,
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 15),
                  child: DemandButton(
                    label: "VALIDER LA TÂCHE",
                    isBlack: false,
                  ),
                )
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 45,
        ),

        // Add Task
        const Padding(
          padding: EdgeInsets.only(right: 12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text("AJOUTER UNE TÂCHE"),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: FaIcon(FontAwesomeIcons.circlePlus),
              ),
            ],
          ),
        ),

        // Add Text
        const Padding(
          padding: EdgeInsets.only(right: 12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text("AJOUTER DU TEXTE"),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: FaIcon(FontAwesomeIcons.circlePlus),
              ),
            ],
          ),
        ),

        const SizedBox(
          height: 45,
        ),

        const Padding(
          padding: EdgeInsets.only(bottom: 8, left: 12, right: 12),
          child: Text("Matériel et fournitures nécessaires : "),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20.0, left: 12, right: 12),
          child: TextFormField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              hintText: "Tondeuse, rotofil, fil 25mm...",
            ),
            minLines: 5,
            maxLines: 7,
          ),
        ),

        DemandButton(
          label: "ETAPE SUIVANTE (4/5)",
          onTap: () {
            bloc.add(ContinueStepEvent(lastIndex: 2));
          },
        )
      ],
    );
  }
}
