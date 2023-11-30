import 'package:cooking_recipe_app/presentation/jsap/creation_devis_screen.dart';
import 'package:cooking_recipe_app/presentation/jsap/widget/demand_button.dart';
import 'package:cooking_recipe_app/presentation/jsap/widget/demand_text_widget.dart';
import 'package:cooking_recipe_app/presentation/jsap/widget/type_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';

class DemandDevisScreen extends StatelessWidget {
  const DemandDevisScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Demande devis"),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const FaIcon(
            FontAwesomeIcons.chevronLeft,
          ),
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          const Center(
            child: FaIcon(
              FontAwesomeIcons.check,
              size: 150,
            ),
          ),
          const Center(
            child: Text(
              "Demande de devis acceptée !",
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(color: Colors.black),
            child: Stack(children: [
              Positioned(
                top: -50,
                right: MediaQuery.sizeOf(context).width * 0.5 - 25,
                child: FaIcon(
                  FontAwesomeIcons.caretDown,
                  color: ThemeData().scaffoldBackgroundColor,
                  size: 100,
                ),
              ),
              Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Nous vous invitons à contacter le client qui a émis cette demende au plus vite afin d'avoir les éléments pour créer votre devis",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DemandButton(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        label: "APPEL",
                        icon: FontAwesomeIcons.phone,
                        isBackgroundBlack: true,
                      ),
                      DemandButton(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        label: "SMS",
                        isBackgroundBlack: true,
                        icon: FontAwesomeIcons.commentDots,
                      ),
                    ],
                  ),
                ],
              ),
            ]),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 13.0, vertical: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Demande n° 123654",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                const Text.rich(
                  TextSpan(
                      text: "Vous pourrez retrouver cette demande dans la ",
                      children: [
                        TextSpan(
                          text: "rubrique Devis.",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                        )
                      ]),
                  style: TextStyle(
                    fontSize: 11,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          "M. Martin",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        DemandTextWidget(isNewDemand: false),
                      ],
                    ),
                    SizedBox(
                      width: 75.0,
                      child: Column(
                        children: [
                          Text(
                            "Publiée le 12/04/2023 à 16:12",
                            overflow: TextOverflow.visible,
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: Colors.grey,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                    "Nous recherchons un jardinier pour s'occuper de la remise en état de notre jardin suite à des travaux. \nBien Cordialement."),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Type de besoin :",
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(
                  height: 5,
                ),
                const TypeWidget(),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Lieu d'intervention :",
                  style: TextStyle(fontSize: 16),
                ),
                const Text(
                  "25 allée des Acacias\n33100 Brignols\nTél. 06 62 21 54 54",
                  style: TextStyle(fontSize: 13),
                ),
                DemandButton(
                  isBlack: false,
                  icon: FontAwesomeIcons.locationPin,
                  label: "Y ALLER",
                  onTap: () {},
                ),
                DemandButton(
                  isBlack: false,
                  icon: FontAwesomeIcons.calendar,
                  label: "AJOUTER UN RDV",
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                DemandButton(
                  isBlack: true,
                  label: "CREER LE DEVIS",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CreationDevisScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
