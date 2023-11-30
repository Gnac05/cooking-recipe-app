import 'package:flutter/material.dart';


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
