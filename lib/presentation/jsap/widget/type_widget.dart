import 'package:flutter/material.dart';

class TypeWidget extends StatelessWidget {
  const TypeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(15),
      ),
      child: const Padding(
        padding: EdgeInsets.all(5.0),
        child: Center(
          child: Text(
            "PONCTUEL",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
