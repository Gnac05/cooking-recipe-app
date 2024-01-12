import 'package:cooking_recipe_app/application/jsap-bloc/jsap_bloc.dart';
import 'package:cooking_recipe_app/injection_container.dart';
import 'package:cooking_recipe_app/presentation/jsap/content-steps-creation-devis/content_billing_step.dart';
import 'package:cooking_recipe_app/presentation/jsap/content-steps-creation-devis/content_client_step.dart';
import 'package:cooking_recipe_app/presentation/jsap/content-steps-creation-devis/content_site_step.dart';
import 'package:cooking_recipe_app/presentation/jsap/content-steps-creation-devis/content_summary_step.dart';
import 'package:cooking_recipe_app/presentation/jsap/content-steps-creation-devis/content_task_step.dart';
import 'package:easy_stepper/easy_stepper.dart';
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
          return Column(
            children: [
            const Padding(
              padding: EdgeInsets.only(bottom:  8.0, top: 10),
              child: Text(
              "Nouveau devis (1234-1234-1234)",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, ), textAlign: TextAlign.start,
                          ),
            ),
            Expanded(
              child: EasyStepper(
                padding: const EdgeInsets.all(0),
                lineStyle: const LineStyle(
                    lineLength: 40,
                    lineSpace: 0,
                    lineType: LineType.normal,
                    defaultLineColor: Colors.grey,
                    finishedLineColor: Colors.grey,
                    activeLineColor: Colors.black,
                    lineThickness: 0.5),
                activeStepTextColor: Colors.black,
          
                finishedStepTextColor: Colors.grey,
          
                internalPadding: 8,
                showLoadingAnimation: false,
                stepRadius: 10,
                showStepBorder: false,
          
                // connectorColor: MaterialStatePropertyAll(Colors.black),
                //     bloc.add(ContinueStepEvent(lastIndex: currentIndex));
                //   }
                // },
                // onStepCancel: () {
                //   bloc.add(CancelStepEvent(lastIndex: currentIndex));
                // },
          
                // onStepTapped: (value) {
                //   debugPrint('On Tap $value');
                //   bloc.add(TapStepEvent(index: value));
                // },
                onStepReached: (value) {
                  debugPrint('On Tap $value');
                  bloc.add(TapStepEvent(index: value));
                },
                activeStep: currentIndex,
                // currentStep: currentIndex,
                // controlsBuilder: (BuildContext context, ControlsDetails details) {
                //   // return Row(
                //   //   children: <Widget>[
                //   //     if (details.stepIndex != 0)
                //   //       TextButton(
                //   //         onPressed: details.onStepCancel,
                //   //         child: Text(
                //   //             'Retourner <- ${stepsData[details.stepIndex - 1]['label']}'),
                //   //       ),
                //   //     if (details.stepIndex < stepsData.length - 1)
                //   //       TextButton(
                //   //         onPressed: details.onStepContinue,
                //   //         child: Text(
                //   //             'Continuer -> ${stepsData[details.stepIndex + 1]['label']}'),
                //   //       ),
                //   //   ],
                //   // );
                //   return const SizedBox();
                // },
                // elevation: 0,
                // physics: const BouncingScrollPhysics(),
                // type: StepperType.vertical,
                steps: List.generate(
                  stepsData.length,
                  (index) => EasyStep(
                      customStep: CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.transparent,
                        child: CircleAvatar(
                          radius: currentIndex >= index ? 30 : 5,
                          backgroundColor: currentIndex == index
                              ? Colors.green :
                              currentIndex > index? const Color(0xffAB5F1C)
                              : Colors.grey,
                          child: currentIndex < index
                              ? null
                              : FaIcon(
                                  currentIndex >= index
                                      ? FontAwesomeIcons.check
                                      : null,
                                  size:currentIndex == index? 15 : 10,
                                  color: Colors.white,
                                ),
                        ),
                      ),
                      finishIcon: const Icon(
                        FontAwesomeIcons.check,
                        color: Colors.white,
                        size: 15,
                      ),
                      customTitle: Text(
                        stepsData[index]["label"] as String,
                        style: TextStyle(
                          fontWeight: currentIndex == index
                              ? FontWeight.bold
                              : FontWeight.normal,
                          fontSize: currentIndex == index ? 14 : 12,
                          color: currentIndex == index
                              ? Colors.black
                              : Colors.grey,
                        ),
                        textAlign: TextAlign.center,
                      )
                      // state: (currentIndex == index)
                      //     ? StepState.editing
                      //     : (currentIndex > index)
                      //         ? StepState.complete
                      //         : StepState.indexed,
                      // content: stepsData[index]["content"] as Widget,
          
                      // label: Text(stepsData[index]["label"] as String),
                      // isActive: (currentIndex == index) ? true : false,
                      ),
                ),
              ),
            ),
            Expanded(
              flex: 8,
              child: stepsData[currentIndex]["content"] as Widget,
            )
          ]);
        },
      ),
    );
  }
}
