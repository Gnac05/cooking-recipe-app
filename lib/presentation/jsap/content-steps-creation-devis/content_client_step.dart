import 'package:cooking_recipe_app/application/jsap-bloc/jsap_bloc.dart';
import 'package:cooking_recipe_app/injection_container.dart';
import 'package:cooking_recipe_app/presentation/jsap/widget/demand_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class ContentClientStep extends StatelessWidget {
  const ContentClientStep({Key? key, required this.bloc}) : super(key: key);
  final JsapBloc bloc;

  @override
  Widget build(BuildContext context) {
    final blocClient = getIt<JsapBloc>();
    return BlocBuilder<JsapBloc, JsapState>(
      bloc: blocClient,
      builder: (context, state) {
        if (state is CreationClientInitialState) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(bottom: 2.0),
                        child: Text(
                          "NOUVEAU CLIENT :",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(bottom: 30.0),
                        child: Text(
                          "Merci de préciser les coordonnées complètes du client et son adresse fiscale pour la facturation.",
                        ),
                      ),
                      const Text(
                        "Nom",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        child: TextFormField(
                          initialValue: "Martin",
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.only(left: 15),
                              filled: true,
                              fillColor: Colors.white,
                              border: UnderlineInputBorder(
                                  borderRadius: BorderRadius.circular(0.0)),
                              hintText: "Nom"),
                        ),
                      ),
                      const Text(
                        "Prénom",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        child: TextFormField(
                          initialValue: "Bernard",
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.only(left: 15),
                              filled: true,
                              fillColor: Colors.white,
                              border: UnderlineInputBorder(
                                  borderRadius: BorderRadius.circular(0.0)),
                              hintText: "Prénom"),
                        ),
                      ),
                      const Text(
                        "Adresse mail",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        child: TextFormField(
                          initialValue: "bmartin@gmail.com",
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.only(left: 15),
                              filled: true,
                              fillColor: Colors.white,
                              border: UnderlineInputBorder(
                                  borderRadius: BorderRadius.circular(0.0)),
                              hintText: "Adresse mail"),
                        ),
                      ),
                      const Text(
                        "Numéro de télépone (optionnel)",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(bottom: 15.0),
                          child: InternationalPhoneNumberInput(
                            onInputChanged: (number) {
                              debugPrint(
                                  "Phone Number : ${number.phoneNumber}");
                            },
                            initialValue: PhoneNumber(
                              // phoneNumber: "+33 (0)612 345 678",
                              isoCode: "FR",
                            ),
                            selectorConfig: const SelectorConfig(
                              selectorType: PhoneInputSelectorType.DROPDOWN,
                              showFlags: true,
                            ),
                            hintText: "Numéro de téléphone",
                            errorMessage: "Numéro de téléphone invalide",
                            inputDecoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.only(left: 15, bottom: 15),
                              filled: true,
                              fillColor: Colors.white,
                              hintText: "(0)6 12 34 56 78",
                              border: UnderlineInputBorder(
                                  borderRadius: BorderRadius.circular(0.0)),
                            ),
                          )),
                      const Text(
                        "Adresse personnelle",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        child: TextFormField(
                          initialValue:
                              "12 Rue des Acacias, résidence le Loiret des Bois",
                          maxLines: 2,
                          minLines: 1,
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.only(left: 15),
                              filled: true,
                              fillColor: Colors.white,
                              border: UnderlineInputBorder(
                                  borderRadius: BorderRadius.circular(0.0)),
                              hintText: "Nom"),
                        ),
                      ),
                      const Text(
                        "Code postal",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        child: SizedBox(
                          width: 100,
                          child: TextFormField(
                            initialValue: "33100",
                            decoration: InputDecoration(
                                contentPadding: const EdgeInsets.only(left: 15),
                                filled: true,
                                fillColor: Colors.white,
                                border: UnderlineInputBorder(
                                    borderRadius: BorderRadius.circular(0.0)),
                                hintText: "Code postal"),
                          ),
                        ),
                      ),
                      const Text(
                        "Ville",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 40.0),
                        child: TextFormField(
                          initialValue: "Brignols",
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.only(left: 15),
                              filled: true,
                              fillColor: Colors.white,
                              border: UnderlineInputBorder(
                                  borderRadius: BorderRadius.circular(0.0)),
                              hintText: "Ville"),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(color: Colors.white),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: DemandButton(
                      label: "ENREGISTRER LE CLIENT",
                      onTap: () {
                        debugPrint("On Tap : ENREGISTRER LE CLIENT");
                        blocClient.add(SaveClientEvent());
                        // emit state Creation Client Successful
                        // Next Step
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        if (state is CreationClientSuccessfulState) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12,
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Merci de vérifier que les informations du client sont correctes :",
                        style: TextStyle(fontWeight: FontWeight.w100, color: Colors.grey,),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: 14,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "M. René Pierre",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            FaIcon(FontAwesomeIcons.penToSquare,
                                color: Color(0xffAB5F1C)),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 14.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                "Adresse personnelle :",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                "25 allée des Acacias Rue du Menhir 33100 Brignols",
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 14.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                "Mail :",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                "bmartin@gmail.com",
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 30.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                "Téléphone :",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                "03 30 30 03 03",
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 70),
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(color: Color(0xffF9F6E8)),
                    child: const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              "Adresse de l'intervention :",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "12 allée des Coquelicots, Lieu dit Chemin vert 33100 Brignols",
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(color: Colors.white),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: DemandButton(
                      label: "VALIDER ET CONTINUER",
                      onTap: () {
                        // bloc.add(AssociatClientEvent());
                        bloc.add(ContinueStepEvent(lastIndex: 0));
                        // emit state Creation Client Successful
                        // Next Step
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Pour commencer ce devis, vous pouvez vérifier si ce client ne fait pas déjà partie de votre fichier clientèle.\nSinon, vous pouvez créer un nouveau client (les informations présentes dans la demande de devis initiale seront automatiquement ajoutées dans le formulaire)",
                style: TextStyle(
                  fontWeight: FontWeight.w100,
                ),
                textAlign: TextAlign.center,
              ),
              Container(
                decoration: const BoxDecoration(color: Colors.white),
                height: 175.0,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 25,
                      ),
                      child: TextFormField(
                        decoration: const InputDecoration(
                            filled: true,
                            fillColor: Color(0xffF5F5F5),
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                            hintText: "Rechercher parmi vos clients...",
                            prefixIcon: Padding(
                              padding: EdgeInsets.all(10),
                              child: FaIcon(
                                FontAwesomeIcons.magnifyingGlass,
                                // color: Colors.black,
                              ),
                            )),
                      ),
                    ),
                    const Text(
                      "ou",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    DemandButton(
                      label: "CREER UN NOUVEAU CLIENT",
                      onTap: () {
                        blocClient.add(CreateNewClientEvent());
                      },
                    ),
                  ],
                ),
              ),
            ]);
      },
    );
  }
}
