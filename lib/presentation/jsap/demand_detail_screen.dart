import 'package:cooking_recipe_app/presentation/jsap/demand_devis_screen.dart';
import 'package:cooking_recipe_app/presentation/jsap/widget/type_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:cooking_recipe_app/presentation/jsap/widget/demand_text_widget.dart';

class DemandDetailScreen extends StatelessWidget {
  const DemandDetailScreen({Key? key, required this.isNewDemand})
      : super(key: key);
  final bool isNewDemand;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Détail de la demande"),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const FaIcon(
            FontAwesomeIcons.chevronLeft,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(13.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DemandTextWidget(isNewDemand: isNewDemand),
                const FaIcon(
                  FontAwesomeIcons.locationArrow,
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("A 2.3 km"),
                Text("33100 Brignois"),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Row(
              children: [
                Text(
                  "Publiée le 12/04/2023 à 16:10",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.start,
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Row(
              children: [
                Text(
                  "M. M.",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ],
            ),
            const Text(
              "Nous recherchons un jardinier pour s'occuper de la remise en état de notre jardin suite à des travaux. \nBien cordialement",
            ),
            const SizedBox(
              height: 16,
            ),
            const Row(
              children: [
                TypeWidget(),
              ],
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.white.withOpacity(0.855),
        height: 200,
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 15,
              ),
              child: Row(
                children: [
                  Text(
                    "Intéressé ?",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const DemandDevisScreen()));
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 25),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FaIcon(
                          FontAwesomeIcons.check,
                          color: Colors.white,
                        ),
                        Text(
                          "J'ACCEPTE LA DEMANDE",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 25),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(width: 2.5)),
                  child: const Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FaIcon(FontAwesomeIcons.xmark),
                        Text(
                          "JE REFUSE LA DEMANDE",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
