import 'package:cooking_recipe_app/application/jsap-bloc/jsap_bloc.dart';
import 'package:cooking_recipe_app/injection_container.dart';
import 'package:cooking_recipe_app/presentation/jsap/jsap_home_screen.dart';
import 'package:cooking_recipe_app/presentation/jsap/widget/demand_button.dart';
import 'package:cooking_recipe_app/presentation/jsap/widget/dropdown_menu_item_delay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';

class DemandDevisDeniedScreen extends StatelessWidget {
  const DemandDevisDeniedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = getIt<JsapBloc>();
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: FaIcon(
                FontAwesomeIcons.xmark,
                size: 150,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Text(
                "Demande refusée",
                style: TextStyle(fontSize: 20),
              ),
            ),
            const Text("Merci pour votre retour"),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: DemandButton(
                label: "RETOUR A L'ACCUEIL",
                isBlack: true,
                icon: FontAwesomeIcons.circle,
                onTap: () {
                  Navigator.popUntil(context, (route) => false);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const JsapHomeScreen(),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        height: 250,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Text(
                  "Souhaitez-vous mettre en veille les demandes de devis ?",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                ),
              ),
              const Row(
                children: [
                  Text("Pendant combien de temps : "),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: BlocBuilder<JsapBloc, JsapState>(
                      bloc: bloc,
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
                                border: Border.all(color: Colors.black)),
                          ),
                          value: delay,
                          items: [
                            DropdownMenuItemDelay(label: "1 Jour", value: 0),
                            DropdownMenuItemDelay(label: "7 Jours", value: 1),
                            DropdownMenuItemDelay(
                                label: "2 Semaines", value: 2),
                            DropdownMenuItemDelay(label: "1 Mois", value: 3),
                          ],
                          onChanged: (value) {
                            bloc.add(ChangeDelayEvent(value ?? 0));
                          },
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: DemandButton(
                      onTap: () {},
                      label: "VALIDER",
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
