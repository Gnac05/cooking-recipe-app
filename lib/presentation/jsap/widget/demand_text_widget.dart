import 'package:flutter/material.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';

class DemandTextWidget extends StatelessWidget {
  const DemandTextWidget({Key? key, required this.isNewDemand})
      : super(key: key);
  final bool isNewDemand;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: FaIcon(
            FontAwesomeIcons.solidCircle,
            color: isNewDemand ? Colors.black : Colors.grey,
            size: 15,
          ),
        ),
        Text(
          isNewDemand ? "Nouvelle demande" : "Demande en cours",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
        )
      ],
    );
  }
}
