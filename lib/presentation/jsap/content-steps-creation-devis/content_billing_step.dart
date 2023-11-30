import 'package:cooking_recipe_app/application/jsap-bloc/jsap_bloc.dart';
import 'package:cooking_recipe_app/injection_container.dart';
import 'package:cooking_recipe_app/presentation/jsap/widget/demand_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContentBillingStep extends StatelessWidget {
  const ContentBillingStep({Key? key, required this.bloc}) : super(key: key);
  final JsapBloc bloc;

  @override
  Widget build(BuildContext context) {
    final bloc = getIt<JsapBloc>();
    return BlocBuilder<JsapBloc, JsapState>(
      bloc: bloc,
      builder: (context, state) {
        int billingType = 0;
        if (state is ChangeBillingState) {
          billingType = state.billing;
        }
        return Column(
          children: [
            const Text(
              "Quel type de contrat souhaitez-vous établir ?",
              style: TextStyle(fontSize: 20),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 15,),
              child: RadioListTile<int>(
                value: 1,
                groupValue: billingType,
                onChanged: (value) {
                  bloc.add(
                    ChangeBillingEvent(
                      value!,
                    ),
                  );
                },
                title: const Text("Facture classique"),
                subtitle: const Text(
                    "Votre client doit régler le montant TTC défini dans votre devis et facture"),
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: RadioListTile<int>(
                value: 2,
                groupValue: billingType,
                onChanged: (value) {
                  bloc.add(
                    ChangeBillingEvent(
                      value!,
                    ),
                  );
                },
                title: const Text("Facture/bon SAP"),
                subtitle: const Text(
                    "Votre client bénéficie de l'avance de frais de 50% et ne règle que la moitié du montant total."),
              ),
            ),
           
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: DemandButton(
                label: "VALIDER MODE DE FACTURATION",
                onTap: billingType == 0 ? null : () {
                bloc.add(ContinueStepEvent(lastIndex: 3));
                },
              ),
            )
          ],
        );
      },
    );
  }
}
