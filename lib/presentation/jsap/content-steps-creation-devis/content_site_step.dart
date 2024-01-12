import 'package:cooking_recipe_app/application/jsap-bloc/jsap_bloc.dart';
import 'package:cooking_recipe_app/injection_container.dart';
import 'package:cooking_recipe_app/presentation/jsap/widget/demand_button.dart';
import 'package:cooking_recipe_app/presentation/jsap/widget/dropdown_menu_item_delay.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';

class ContentSiteStep extends StatelessWidget {
  const ContentSiteStep({Key? key, required this.bloc}) : super(key: key);
  final JsapBloc bloc;

  @override
  Widget build(BuildContext context) {
    TextEditingController calandarController = TextEditingController();
    final blocTerrain = getIt<JsapBloc>();
    final blocDelay = getIt<JsapBloc>();
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Superficie du site d'intervention : ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 8.0,
                    bottom: 20,
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 100,
                        child: TextFormField(
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.only(left: 15),
                              filled: true,
                              fillColor: Colors.white,
                              border: UnderlineInputBorder(
                                  borderRadius: BorderRadius.circular(0.0)),
                              hintText: "0,00"),
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "M²",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const Text(
                  "Type de terrain : ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 8.0,
                    bottom: 16,
                  ),
                  child: BlocBuilder<JsapBloc, JsapState>(
                    bloc: blocTerrain,
                    builder: (context, state) {
                      int? terrain;
                      if (state is JsapInitial) {
                        terrain = 0;
                      }
                      if (state is DelayChangingSuccessful) {
                        terrain = state.newDelay;
                      }
                      return Container(
                        decoration: const BoxDecoration(color: Colors.white),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            DropdownButton<int>(
                              borderRadius: BorderRadius.circular(10),
                              icon: const Padding(
                                padding: EdgeInsets.only(right: 8.0),
                                child: FaIcon(FontAwesomeIcons.angleDown,
                                    size: 12),
                              ),
                              isExpanded: true,
                              value: terrain,
                              items: [
                                DropdownMenuItemDelay(
                                    label: "Jardin privé", value: 0),
                                DropdownMenuItemDelay(
                                    label: "Jardin public", value: 1),
                                DropdownMenuItemDelay(
                                    label: "Vaste Terrain", value: 2),
                                DropdownMenuItemDelay(
                                    label: "Petit Jardin", value: 3),
                              ],
                              onChanged: (value) {
                                blocTerrain.add(ChangeDelayEvent(value ?? 0));
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                const Text(
                  "Date de démarrage",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const Text("souhaitée par le cilent :"),
                const Text(
                  "21/04/2023",
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 16,
                ),
                const Text(
                  "Date prévisionnelle",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const Text("de début de mission : "),
                Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 16),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 100,
                        child: TextFormField(
                          controller: calandarController,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(left: 15),
                            filled: true,
                            fillColor: Colors.white,
                            border: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(0.0)),
                            hintText: "jj/mm/aaaa",
                          ),
                          onChanged: (value) {
                            debugPrint("Value : $value");
                            if (value.length == 2) {
                              calandarController.text = '$value/';
                            } else if (value.length > 2) {
                              if (value.length < 5) {
                                calandarController.text =
                                    '${value.substring(0, 2)}/${value.substring(2)}';
                              } else {
                                calandarController.text =
                                    '${value.substring(0, 2)}/${value.substring(2, 4)}/${value.substring(4)}';
                              }
                            }
                          },
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(8)
                          ],
                          keyboardType: TextInputType.datetime,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(12),
                        child: FaIcon(
                          FontAwesomeIcons.calendar,
                          color: Color(0xffAB5F1C),
                        ),
                      ),
                    ],
                  ),
                ),
                const Text("Marge de délai",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Row(
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 8, right: 8, bottom: 20),
                        child: BlocBuilder<JsapBloc, JsapState>(
                          bloc: blocDelay,
                          builder: (context, state) {
                            int? delay;
                            if (state is JsapInitial) {
                              delay = 0;
                            }
                            if (state is DelayChangingSuccessful) {
                              delay = state.newDelay;
                            }
                            return Container(
                              decoration:
                                  const BoxDecoration(color: Colors.white),
                              child: DropdownButton<int>(
                                borderRadius: BorderRadius.circular(10),
                                icon: const Padding(
                                  padding: EdgeInsets.only(right: 8.0),
                                  child: FaIcon(FontAwesomeIcons.angleDown),
                                ),
                                value: delay,
                                items: [
                                  DropdownMenuItemDelay(label: "Non", value: 0),
                                  DropdownMenuItemDelay(
                                      label: "2 Jours", value: 1),
                                  DropdownMenuItemDelay(
                                      label: "1 Semaine", value: 2),
                                  DropdownMenuItemDelay(
                                      label: "Peut-être", value: 3),
                                ],
                                onChanged: (value) {
                                  blocDelay.add(ChangeDelayEvent(value ?? 0));
                                },
                              ),
                            );
                          },
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(bottom: 15.0),
                        child: Text("(Date précise)"),
                      ),
                    ],
                  ),
                ),
                // Add Notes
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: FaIcon(
                                  FontAwesomeIcons.blog,
                                ),
                              ),
                              Text(
                                "Notes : ",
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              "AJOUTER",
                              style: TextStyle(
                                  color: Color(0xffAB5F1C),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 38),
                        child: Text("Aucune note"),
                      ),
                    ],
                  ),
                ),

                // Add Pictures
                Padding(
                  padding: const EdgeInsets.only(bottom: 40.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: FaIcon(
                                  FontAwesomeIcons.images,
                                ),
                              ),
                              Text(
                                "Photos : ",
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              "AJOUTER",
                              style: TextStyle(
                                  color: Color(0xffAB5F1C),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 38),
                        child: Text("Aucune photo"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(bottom: 44),
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xffF9F6E8),
              ),
              child: const Padding(
                padding: EdgeInsets.all(12.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Text(
                        "Adresse de l'intervention : ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                        flex: 3,
                        child: Text(
                            "12 allée des Coquelicots, Lieu dit Chemin vert 33100 Brignols")),
                    Expanded(
                        child: Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: FaIcon(
                        FontAwesomeIcons.penToSquare,
                        color: Color(0xffAB5F1C),
                      ),
                    )),
                  ],
                ),
              ),
            ),
          ),

          const Padding(
            padding: EdgeInsets.only(bottom: 8.0, left: 12, right: 12),
            child: Text(
              "Informations complémentaires : ",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(bottom: 20.0, left: 12, right: 12,),
            child: TextFormField(
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(left: 15),
                filled: true,
                fillColor: Colors.white,
                border: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(0.0)),
                hintText:
                    "Consignes, codes d'entrée, renseignement important...",
              ),
              minLines: 5,
              maxLines: 7,
            ),
          ),

          Container(
            decoration: const BoxDecoration(
              color: Colors.white
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: DemandButton(
                label: "VALIDER ET CONTINUER",
                onTap: () {
                  bloc.add(ContinueStepEvent(lastIndex: 1));
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
