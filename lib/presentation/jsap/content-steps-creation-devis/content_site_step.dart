import 'package:cooking_recipe_app/application/jsap-bloc/jsap_bloc.dart';
import 'package:cooking_recipe_app/injection_container.dart';
import 'package:cooking_recipe_app/presentation/jsap/widget/demand_button.dart';
import 'package:cooking_recipe_app/presentation/jsap/widget/dropdown_menu_item_delay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';

class ContentSiteStep extends StatelessWidget {
  const ContentSiteStep({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final blocTerrain = getIt<JsapBloc>();
    final blocDelay = getIt<JsapBloc>();
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Superficie : "),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 20),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        hintText: "0.00",
                      ),
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                    ),
                  ),
                  const Expanded(
                      flex: 2,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("M²"),
                      ))
                ],
              ),
            ),
            const Text("Type de terrain : "),
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
                  return DropdownButton<int>(
                    borderRadius: BorderRadius.circular(10),
                    icon: const FaIcon(FontAwesomeIcons.angleDown),
                    underline: Container(
                      height: 40,
                      width: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey)),
                    ),
                    value: terrain,
                    items: [
                      DropdownMenuItemDelay(label: "Jardin privé", value: 0),
                      DropdownMenuItemDelay(label: "Jardin public", value: 1),
                      DropdownMenuItemDelay(label: "Vaste Terrain", value: 2),
                      DropdownMenuItemDelay(label: "Petit Jardin", value: 3),
                    ],
                    onChanged: (value) {
                      blocTerrain.add(ChangeDelayEvent(value ?? 0));
                    },
                  );
                },
              ),
            ),
            const Text("Date de démarrage souhaitée par le cilent :"),
            const Text(
              "21/04/2023",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 16,
            ),
            const Text("Date prévisionnelle de début de mission : "),
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 16),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: TextFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        hintText: "01/05/2023",
                        suffixIcon: Padding(
                          padding: EdgeInsets.only(top: 8),
                          child: FaIcon(
                            FontAwesomeIcons.calendar,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      keyboardType: TextInputType.datetime,
                    ),
                  ),
                  const Expanded(
                    flex: 2,
                    child: SizedBox(),
                  ),
                ],
              ),
            ),
            const Text("Marge de délai"),
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
                        return DropdownButton<int>(
                          borderRadius: BorderRadius.circular(10),
                          icon: const FaIcon(FontAwesomeIcons.angleDown),
                          underline: Container(
                            height: 40,
                            width: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          value: delay,
                          items: [
                            DropdownMenuItemDelay(label: "Non", value: 0),
                            DropdownMenuItemDelay(label: "2 Jours", value: 1),
                            DropdownMenuItemDelay(label: "1 Semaine", value: 2),
                            DropdownMenuItemDelay(label: "Peut-être", value: 3),
                          ],
                          onChanged: (value) {
                            blocDelay.add(ChangeDelayEvent(value ?? 0));
                          },
                        );
                      },
                    ),
                  ),
                  const Center(child: Text("(Date précise)")),
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
                              FontAwesomeIcons.circle,
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
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 38),
                    child: Text("Aucune"),
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
                              FontAwesomeIcons.circle,
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
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 38),
                    child: Text("Aucune"),
                  ),
                ],
              ),
            ),

            const Padding(
              padding: EdgeInsets.only(bottom: 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Adresse de l'intervention : ",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  FaIcon(FontAwesomeIcons.penToSquare),
                ],
              ),
            ),

            const Text("12 rue des Acacias"),
            const Text("33150 Blanquefort"),

            const SizedBox(
              height: 50,
            ),

            const Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: Text("Informations complémentaires : "),
            ),

            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  hintText: "Code, conditions d'accès....",
                ),
                minLines: 5,
                maxLines: 7,
              ),
            ),

            const DemandButton(label: "ETAPE SUIVANTE (3/5)")
          ],
        ),
      ),
    );
  }
}
