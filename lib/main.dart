import 'package:flutter/material.dart';
import 'package:cards/view/cards_view.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contatos',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
      ),
      home: const Cartoes(),
    );
  }
}

