import 'package:flutter/material.dart';


  // ignore: non_constant_identifier_names
  DropdownMenuItem<Object> DropdownMenuItemDelay<Object>({required String label, Object? value}) {
    return DropdownMenuItem(
      value: value,
      child: SizedBox(
        height: 25,
        width: 125,
        child: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(label),
        ),
      ),
    );
  }
