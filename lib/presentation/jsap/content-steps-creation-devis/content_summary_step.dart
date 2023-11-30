import 'package:cooking_recipe_app/application/jsap-bloc/jsap_bloc.dart';
import 'package:cooking_recipe_app/injection_container.dart';
import 'package:cooking_recipe_app/presentation/jsap/widget/demand_button.dart';
import 'package:cooking_recipe_app/presentation/jsap/widget/task_widget.dart';
import 'package:cooking_recipe_app/presentation/jsap/widget/type_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';

class ContentSummaryStep extends StatelessWidget {
  const ContentSummaryStep({Key? key, required this.bloc}) : super(key: key);
  final JsapBloc bloc;

  @override
  Widget build(BuildContext context) {
    final blocSwitch = getIt<JsapBloc>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Récapitulatif de votre devis : "),
        const Padding(
          padding: EdgeInsets.only(bottom: 14, top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    "MISSION : ",
                    style: TextStyle(
                      fontSize: 15,
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
          padding: EdgeInsets.only(top: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "CLIENT : ",
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              FaIcon(FontAwesomeIcons.penToSquare),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(bottom: 40.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 8, right: 40),
                child: FaIcon(
                  FontAwesomeIcons.imagePortrait,
                  size: 75,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 10.0, top: 8),
                    child: Text(
                      "M. Bernard Martin",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Text("12 rue des Acacias"),
                  Text("33150 Blanquefort"),
                  SizedBox(
                    height: 20,
                  ),
                  Text("Tél. 06 62 12 21 21"),
                  SizedBox(
                    height: 20,
                  ),
                  Text("Mail bmartin@gmail.com")
                ],
              )
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(bottom: 8.0),
          child: Divider(),
        ),
        const Padding(
          padding: EdgeInsets.only(bottom: 14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "SITE D'INTERVENTION",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              FaIcon(FontAwesomeIcons.penToSquare),
            ],
          ),
        ),
        const Text("Adresse site : "),
        const Text(
          "16 rue des Acacias",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        const Text(
          "33150 Blanquefort",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 25.0,
        ),
        const Text("Informations complémentaires : "),
        const Text(
          "Demander la clé du portail au client avant d'aller sur le chantier",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
        ),
        const SizedBox(
          height: 45.0,
        ),
        const Text(
          "Jardin Privé",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 20.0,
        ),
        const Text(
          "453 m²",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 20.0,
        ),
        const Text(
          "Travaux souhaités à partir du : ",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        const Text(
          "12/04/2023",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(
          height: 25,
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
          padding: EdgeInsets.only(bottom: 20),
          child: Divider(),
        ),

        const Text("TÂCHES", style: TextStyle(fontWeight: FontWeight.bold)),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0),
          child: TaskWidget(
            number: 1,
            description: "Tonte de pouleuse à l'engin mécanique à panier",
            price: "123,45",
            times: "4H",
            other: "1P",
          ),
        ),

        const Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0),
          child: TaskWidget(
            number: 1,
            description: "Tonte de pouleuse à l'engin mécanique à panier",
            price: "123,45",
            times: "4H",
            other: "1P",
          ),
        ),

        const Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0),
          child: TaskWidget(
            number: 1,
            description: "Taille de haie (haut 4m)",
            price: "1 420,45",
            times: "2J",
            other: "3P",
          ),
        ),

        const SizedBox(
          height: 20,
        ),
        const Text(
          "Matériel et fournitures : ",
          style: TextStyle(color: Colors.grey),
        ),
        const Text(
            "Tondeuse thermique, rotofil, fil 25mm, Taille-haie thermique, échafaudage 4m, Essence"),

        const SizedBox(
          height: 30,
        ),
        Container(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: const Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(children: [
              Padding(
                padding: EdgeInsets.only(bottom: 13.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text("TOTAL HT"), Text("573,90 €")],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 13.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text("TVA (20%)"), Text("114,78 €")],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 13.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("TOTAL HT",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text("688,68 €",
                        style: TextStyle(fontWeight: FontWeight.bold))
                  ],
                ),
              )
            ]),
          ),
        ),
        const SizedBox(
          height: 17.5,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<JsapBloc, JsapState>(
            bloc: blocSwitch,
            builder: (context, state) {
              bool isChecked = true;
              if (state is SeeMoreState) {
                isChecked = state.isSeeMore;
              }
              return SwitchListTile(
                value: isChecked,
                title: const Text("J'accepte de partager les données tarifaires émises dans ce devis dans ce devis\nEN SAVOIR PLUS"),
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

         DemandButton(label: "VALIDER LA CREATION DU DEVIS", onTap: (){
                bloc.add(ContinueStepEvent(lastIndex: 4));

        },)
      ],
    );
  }
}
