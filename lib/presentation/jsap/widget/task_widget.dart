import 'package:flutter/material.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';

class TaskWidget extends StatelessWidget {
  const TaskWidget({Key? key, required this.number, required this.description, required this.price, required this.times, required this.other}) : super(key: key);
  final int number;
  final String description;
  final String price; 
  final String times; 
  final String other; 

  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text("$number X  "),
            SizedBox(
                width: 200,
                child: Text(description)),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.0),
              child: FaIcon(FontAwesomeIcons.trash),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: FaIcon(FontAwesomeIcons.penToSquare),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 25),
          child: Text.rich(
            TextSpan(
                text: "$price€ HT",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                children: [TextSpan(text: "/ $times / $other")]),
          ),
        )
      ],
    );
  }
}
