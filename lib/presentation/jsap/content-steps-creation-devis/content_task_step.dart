import 'package:cooking_recipe_app/application/jsap-bloc/jsap_bloc.dart';
// import 'package:cooking_recipe_app/injection_container.dart';
import 'package:cooking_recipe_app/presentation/jsap/widget/demand_button.dart';
import 'package:cooking_recipe_app/presentation/jsap/widget/type_widget.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';

class ContentTaskStep extends StatelessWidget {
  const ContentTaskStep({Key? key, required this.bloc}) : super(key: key);
  final JsapBloc bloc;

  @override
  Widget build(BuildContext context) {
    // final blocQuantity = getIt<JsapBloc>();
    // final blocSwitch = getIt<JsapBloc>();
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(12.0),
            child: Text(
              "Précisez les différentes tâches à effectuer dans le cadre de ce devis :",
              style: TextStyle(
                fontWeight: FontWeight.w100,
                color: Colors.grey,
              ),
            ),
          ),
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
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TypeWidget(),
                    )
                  ],
                ),
                FaIcon(
                  FontAwesomeIcons.penToSquare,
                  color: Color(0xffAB5F1C),
                ),
              ],
            ),
          ),

          //// Widget Add Task
          // const Padding(
          //   padding: EdgeInsets.only(left: 12, right: 12),
          //   child: Text(
          //     "Nature des travaux : ",
          //     style: TextStyle(
          //       fontSize: 18,
          //     ),
          //   ),
          // ),
          // const Padding(
          //   padding: EdgeInsets.only(left: 12, right: 12),
          //   child: Text(
          //     "Décrivez chaque tâche à effectuer dans un champ séparé",
          //     style: TextStyle(
          //       fontSize: 14,
          //       fontStyle: FontStyle.italic,
          //     ),
          //   ),
          // ),
          // const SizedBox(
          //   height: 20,
          // ),
          // Container(
          //   width: double.infinity,
          //   decoration: const BoxDecoration(color: Colors.black12),
          //   child: Padding(
          //     padding: const EdgeInsets.all(12.0),
          //     child: Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         const Text(
          //           "Description de la tâche : ",
          //           style: TextStyle(
          //             fontSize: 18,
          //           ),
          //         ),
          //         Padding(
          //           padding: const EdgeInsets.only(bottom: 20, top: 8),
          //           child: TextFormField(
          //             decoration: const InputDecoration(
          //               border: OutlineInputBorder(
          //                   borderRadius: BorderRadius.all(Radius.circular(15))),
          //               hintText: "Tonte, taille de haie...",
          //             ),
          //           ),
          //         ),
          //         Row(
          //           children: [
          //             const Expanded(
          //               child: Center(
          //                 child: Text(
          //                   "Tarif : ",
          //                   style: TextStyle(
          //                     fontSize: 18,
          //                   ),
          //                 ),
          //               ),
          //             ),
          //             Expanded(
          //               child: Center(
          //                 child: TextFormField(
          //                   decoration: const InputDecoration(
          //                     border: OutlineInputBorder(
          //                         borderRadius:
          //                             BorderRadius.all(Radius.circular(15))),
          //                     hintText: "0.00",
          //                   ),
          //                   keyboardType: TextInputType.number,
          //                 ),
          //               ),
          //             ),
          //             const Expanded(
          //               child: Row(
          //                 mainAxisAlignment: MainAxisAlignment.spaceAround,
          //                 children: [
          //                   Text("€ HT "),
          //                   FaIcon(
          //                     FontAwesomeIcons.circleQuestion,
          //                     size: 30,
          //                   )
          //                 ],
          //               ),
          //             ),
          //           ],
          //         ),
          //         Row(
          //           children: [
          //             const Expanded(
          //               child: Center(
          //                 child: Text(
          //                   "Quantité : ",
          //                   style: TextStyle(
          //                     fontSize: 18,
          //                   ),
          //                 ),
          //               ),
          //             ),
          //             Expanded(
          //               flex: 2,
          //               child: Padding(
          //                 padding: const EdgeInsets.only(
          //                     top: 18, bottom: 25, right: 35),
          //                 child: BlocBuilder<JsapBloc, JsapState>(
          //                   bloc: blocQuantity,
          //                   builder: (context, state) {
          //                     int quantity = 1;
          //                     TextEditingController controller =
          //                         TextEditingController(
          //                             text: quantity.toString());
          //                     if (state is QuantityState) {
          //                       quantity = state.quantity;
          //                       controller.text = quantity.toString();
          //                     }
          //                     return TextFormField(
          //                       controller: controller,
          //                       onChanged: (value) {
          //                         quantity = int.parse(value);
          //                       },
          //                       keyboardType: TextInputType.number,
          //                       inputFormatters: [
          //                         FilteringTextInputFormatter.digitsOnly
          //                       ],
          //                       decoration: InputDecoration(
          //                         border: const OutlineInputBorder(
          //                             borderRadius:
          //                                 BorderRadius.all(Radius.circular(15))),
          //                         suffixIcon: SizedBox(
          //                           height: 50,
          //                           child: Column(
          //                             children: [
          //                               SizedBox(
          //                                 height: 25,
          //                                 child: IconButton(
          //                                   onPressed: () {
          //                                     blocQuantity.add(
          //                                       QuantityAddEvent(
          //                                         lastQuantity: quantity,
          //                                       ),
          //                                     );
          //                                   },
          //                                   icon: const FaIcon(
          //                                       FontAwesomeIcons.angleUp,
          //                                       color: Colors.black,
          //                                       size: 20),
          //                                 ),
          //                               ),
          //                               SizedBox(
          //                                 height: 25,
          //                                 child: IconButton(
          //                                   color: Colors.white,
          //                                   onPressed: () {
          //                                     blocQuantity.add(
          //                                       QuantityRemoveEvent(
          //                                         lastQuantity: quantity,
          //                                       ),
          //                                     );
          //                                   },
          //                                   icon: const FaIcon(
          //                                     FontAwesomeIcons.angleDown,
          //                                     color: Colors.black,
          //                                     size: 20,
          //                                   ),
          //                                 ),
          //                               ),
          //                             ],
          //                           ),
          //                         ),
          //                       ),
          //                     );
          //                   },
          //                 ),
          //               ),
          //             ),
          //           ],
          //         ),
          //         const Padding(
          //           padding: EdgeInsets.all(8.0),
          //           child: Divider(thickness: 1),
          //         ),
          //         Padding(
          //           padding: const EdgeInsets.all(8.0),
          //           child: BlocBuilder<JsapBloc, JsapState>(
          //             bloc: blocSwitch,
          //             builder: (context, state) {
          //               bool isChecked = false;
          //               if (state is SeeMoreState) {
          //                 isChecked = state.isSeeMore;
          //               }
          //               return SwitchListTile.adaptive(
          //                 controlAffinity: ListTileControlAffinity.leading,
          //                 value: isChecked,
          //                 title: const Text("AFFICHER PLUS DE CRITERES"),
          //                 onChanged: (value) {
          //                   blocSwitch.add(
          //                     SeeMoreCrEvent(
          //                       isSeeMore: value,
          //                     ),
          //                   );
          //                 },
          //               );
          //             },
          //           ),
          //         ),
          //         const Padding(
          //           padding: EdgeInsets.only(bottom: 15),
          //           child: DemandButton(
          //             label: "VALIDER LA TÂCHE",
          //             isBlack: false,
          //           ),
          //         )
          //       ],
          //     ),
          //   ),
          // ),
          // const SizedBox(
          //   height: 45,
          // ),

          // Add Task
          Padding(
            padding: const EdgeInsets.only(right: 12.0, bottom: 15,),
            child: Center(
              child: TextButton(
                child: const Text(
                  "AJOUTER UNE TÂCHE",
                  style: TextStyle(
                    color: Color(0xffAB5F1C),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {},
              ),
            ),
          ),

          // Add Text
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: Center(
              child: TextButton(
                child: const Text(
                  "AJOUTER DU TEXTE",
                  style: TextStyle(
                    color: Color(0xffAB5F1C),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {},
              ),
            ),
          ),

          const SizedBox(
            height: 45,
          ),

          const Padding(
            padding: EdgeInsets.only(bottom: 8, left: 12, right: 12),
            child: Text(
              "Matériel et fournitures nécessaires : ",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0, left: 12, right: 12),
            child: TextFormField(
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(left: 15, top: 15),
                filled: true,
                fillColor: Colors.white,
                border: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(0.0)),
                hintText: "Tondeuse, rotofil, fil 25mm...",
              ),
              minLines: 5,
              maxLines: 7,
            ),
          ),

          Container(
            decoration: const BoxDecoration(color: Colors.white),
            padding: const EdgeInsets.all(10),
            child: DemandButton(
                      isEnable: false,
              label: "ETAPE SUIVANTE",
              onTap: () {
                bloc.add(ContinueStepEvent(lastIndex: 2));
              },
            ),
          )
        ],
      ),
    );
  }
}
