import 'package:flutter/material.dart';
import 'package:functional_snake/ui/snake_game_field.dart';

void main() => runApp(const MainApp());

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) => const MaterialApp(
        home: SnakeGameField(),
      );
}
