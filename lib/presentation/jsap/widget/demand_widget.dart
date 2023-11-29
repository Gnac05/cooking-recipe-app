import 'package:cooking_recipe_app/presentation/jsap/demand_detail_screen.dart';
import 'package:cooking_recipe_app/presentation/jsap/widget/demand_button.dart';
import 'package:cooking_recipe_app/presentation/jsap/widget/demand_text_widget.dart';
import 'package:cooking_recipe_app/presentation/jsap/widget/type_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';

class DemandWidget extends StatelessWidget {
  const DemandWidget({Key? key, required this.isNewDemand}) : super(key: key);
  final bool isNewDemand;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, border: Border.all(width: 2.5, color: Colors.white.withOpacity(0.95),),),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 8),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DemandTextWidget(isNewDemand: isNewDemand),
                const Text(
                  "16:10",
                  style: TextStyle(color: Colors.grey),
                )
              ],
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 25),
                  child: Text(
                    "A 2,3 km",
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
                Text(
                  "33100 Brignols",
                ),
              ],
            ),
            const SizedBox(height: 8,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  if (isNewDemand)
                const Text(
                  "Nous recherchons un jardinier pour s'occuper de la remise en état de notre jardin suite à des travaux. \nBien Cordialement.",
                  overflow: TextOverflow.ellipsis,
                ),
              
              const SizedBox(height: 6,),
              if (isNewDemand)
                DemandButton(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DemandDetailScreen(
                          isNewDemand: isNewDemand,
                        ),
                      ),
                    );
                  },
                  label: "CONSULTER",
                  isBlack: true
                ),
              if (!isNewDemand)
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text(
                          "Bernard Martin",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      SizedBox(height: 5,),
                        Text(
                          "Taille de haie",
                        ),
                      SizedBox(height: 4,),
                        TypeWidget(),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(child: FaIcon(FontAwesomeIcons.locationArrow, size: 35,),),
                    )
                  ],
                ),
              if (!isNewDemand)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton.icon(
                        onPressed: () {},
                        icon: const FaIcon(FontAwesomeIcons.angleRight, color: Colors.black),
                        label: const Text("OUVRIR", style: TextStyle(color: Colors.black,),),),
                    TextButton.icon(
                        onPressed: () {},
                        icon: const FaIcon(FontAwesomeIcons.xmark, color: Colors.black),
                        label: const Text("ME DESISTER", style: TextStyle(color: Colors.black,),)),
                  ],
                ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
