  import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, {required String massage}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(massage),
      ),
    );
  }