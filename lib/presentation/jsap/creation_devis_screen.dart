import 'package:cooking_recipe_app/presentation/jsap/content-steps-creation-devis/content_billing_step.dart';
import 'package:cooking_recipe_app/presentation/jsap/content-steps-creation-devis/content_client_step.dart';
import 'package:cooking_recipe_app/presentation/jsap/content-steps-creation-devis/content_site_step.dart';
import 'package:cooking_recipe_app/presentation/jsap/content-steps-creation-devis/content_summary_step.dart';
import 'package:cooking_recipe_app/presentation/jsap/content-steps-creation-devis/content_task_step.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';

class CreationDevisScreen extends StatelessWidget {
  const CreationDevisScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Création devis"),
        bottom: AppBar(
          leading: const SizedBox(),
          title: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Nouveau devis (n°123654)",
                style: TextStyle(fontSize: 22),
              ),
              Text(
                "M. Martin",
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const FaIcon(
            FontAwesomeIcons.xmark,
          ),
        ),
      ),
      body: Stepper(
        currentStep: 4,
        physics: const BouncingScrollPhysics(),
        controller: ScrollController(),
        type: StepperType.horizontal,
        steps: const <Step>[
          Step(
            title: SizedBox(),
            label: Text("Client"),
            content: ContentClientStep(),
          ),
          Step(
            title: SizedBox(),
            label: Text("Site"),
            content: ContentSiteStep(),
          ),
          Step(
            title: SizedBox(),
            label: Text("Tâches"),
            content: ContentTaskStep(),
          ),
           Step(
            title: SizedBox(),
            label: Text("Facturation"),
            content: ContentBillingStep(),
          ),

          Step(
            isActive: true,
            title: SizedBox(),
            label: Text("Résumé"),
            content: ContentSummaryStep(),
          ),
        ],
      ),
    );
  }
}
