import 'package:flutter/material.dart';
import 'package:mandir/pages/selection.dart';
import 'package:mandir/pages/generation.dart';
import 'package:mandir/pages/start.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    onGenerateRoute: (settings) {
      if (settings.name == '/gen') {
        final String index = settings.arguments as String;
        return MaterialPageRoute(
          builder: (context) => Generation(index),
        );
      } else if (settings.name == '/select') {
        return MaterialPageRoute(builder: (context) => const selection());
      } else {
        return MaterialPageRoute(builder: (context) => const start());
      }
    },
  ));
}