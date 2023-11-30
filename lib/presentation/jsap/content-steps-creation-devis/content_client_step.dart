import 'package:cooking_recipe_app/application/jsap-bloc/jsap_bloc.dart';
import 'package:cooking_recipe_app/injection_container.dart';
import 'package:cooking_recipe_app/presentation/jsap/widget/demand_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';

class ContentClientStep extends StatelessWidget {
  const ContentClientStep({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = getIt<JsapBloc>();
    return BlocBuilder<JsapBloc, JsapState>(
      bloc: bloc,
      builder: (context, state) {
        if (state is CreationClientInitialState) {
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 14),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "M. René Pierre",
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        FaIcon(FontAwesomeIcons.penToSquare),
                      ],
                    ),
                  ),
                  const Text("12 rue des Acacias"),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 14),
                    child: Text("33150 Blanquefort"),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 14),
                    child: Text("Tél. 06 62 12 21 21"),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 40),
                    child: Text("Mail bmartin@gmail.com"),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 70),
                    child: Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(color: Colors.white),
                      child: const Padding(
                        padding: EdgeInsets.all(14.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(bottom: 8),
                              child: Text(
                                "Adresse de l'intervention : ",
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                            Text("12 rue des Acacias"),
                            Text("33150 Blanquefort")
                          ],
                        ),
                      ),
                    ),
                  ),
                  DemandButton(
                    label: "ASSOCIER LE CLIENT AU DEVIS",
                    onTap: () {
                      bloc.add(AssociatClientEvent());
                      // emit state Creation Client Successful
                      // Next Step
                    },
                  )
                ],
              ),
            ),
          );
        }
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    hintText: "Rechercher dans vos clients",
                    suffixIcon: Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: FaIcon(
                        FontAwesomeIcons.magnifyingGlass,
                        color: Colors.black,
                      ),
                    )),
              ),
            ),
            const Text("ou"),
            DemandButton(
              label: "CREER UN NOUVEAU CLIENT",
              onTap: () {
                bloc.add(CreateNewClientEvent());
              },
            ),
          ],
        );
      },
    );
  }
}
