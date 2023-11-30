import 'package:cooking_recipe_app/application/jsap-bloc/jsap_bloc.dart';
import 'package:cooking_recipe_app/injection_container.dart';
import 'package:cooking_recipe_app/presentation/jsap/content-steps-creation-devis/content_billing_step.dart';
import 'package:cooking_recipe_app/presentation/jsap/content-steps-creation-devis/content_client_step.dart';
import 'package:cooking_recipe_app/presentation/jsap/content-steps-creation-devis/content_site_step.dart';
import 'package:cooking_recipe_app/presentation/jsap/content-steps-creation-devis/content_summary_step.dart';
import 'package:cooking_recipe_app/presentation/jsap/content-steps-creation-devis/content_task_step.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';

class CreationDevisScreen extends StatelessWidget {
  const CreationDevisScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = getIt<JsapBloc>();
    final stepsData = [
      {
        "label": "Client",
        "content": ContentClientStep(
          bloc: bloc,
        )
      },
      {
        "label": "Site",
        "content": ContentSiteStep(
          bloc: bloc,
        )
      },
      {
        "label": "Tâches",
        "content": ContentTaskStep(
          bloc: bloc,
        )
      },
      {
        "label": "Paiement",
        "content": ContentBillingStep(
          bloc: bloc,
        )
      },
      {
        "label": "Résumé",
        "content": ContentSummaryStep(
          bloc: bloc,
        )
      },
    ];
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
      body: BlocBuilder<JsapBloc, JsapState>(
        bloc: bloc,
        builder: (context, state) {
          int currentIndex = 0;
          if (state is CurrentStepState) {
            currentIndex = state.currentIndex;
          }
          return Stepper(
            onStepContinue: () {
              if (currentIndex < stepsData.length) {
                bloc.add(ContinueStepEvent(lastIndex: currentIndex));
              }
            },
            onStepCancel: () {
              bloc.add(CancelStepEvent(lastIndex: currentIndex));
            },
            onStepTapped: (value) {
              debugPrint('On Tap $value');
              bloc.add(TapStepEvent(index: value));
            },
            currentStep: currentIndex,
            controlsBuilder: (BuildContext context, ControlsDetails details) {
              return Row(
                children: <Widget>[
                  if (details.stepIndex != 0)
                    TextButton(
                      onPressed: details.onStepCancel,
                      child: Text(
                          'Retourner <- ${stepsData[details.stepIndex - 1]['label']}'),
                    ),
                  if (details.stepIndex < stepsData.length - 1)
                    TextButton(
                      onPressed: details.onStepContinue,
                      child: Text(
                          'Continuer -> ${stepsData[details.stepIndex + 1]['label']}'),
                    ),
                ],
              );
            },
            elevation: 0,
            physics: const BouncingScrollPhysics(),
            controller: ScrollController(),
            type: StepperType.horizontal,
            steps: List.generate(
              stepsData.length,
              (index) => Step(
                title: const SizedBox(),
                state: (currentIndex == index)
                    ? StepState.editing
                    : (currentIndex > index)
                        ? StepState.complete
                        : StepState.indexed,
                content: stepsData[index]["content"] as Widget,
                label: Text(stepsData[index]["label"] as String),
                isActive: (currentIndex == index) ? true : false,
              ),
            ),
          );
        },
      ),
    );
  }
}
