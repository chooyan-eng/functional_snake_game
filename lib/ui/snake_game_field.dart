import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:functional_snake/haskell_style.dart';
import 'package:functional_snake/state/field.dart';
import 'package:functional_snake/state/move_direction.dart';
import 'package:functional_snake/state/position.dart';
import 'package:functional_snake/ui/controller.dart';

class SnakeGameField extends StatefulWidget {
  const SnakeGameField({super.key});

  @override
  State<SnakeGameField> createState() => _SnakeGameFieldState();
}

class _SnakeGameFieldState extends State<SnakeGameField> {
  late List<List<FieldSquare>> _squares;
  late List<Position> _snake;
  late Position _food;
  late MoveDirection _direction;
  var _gameOver = false;

  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _initGame();
  }

  /// Initialize the game state.
  ///
  /// This is the only function that is written in an imperative style.
  void _initGame() {
    _gameOver = false;
    _snake = [(2, 3)];
    _food = (Random().nextInt(10), Random().nextInt(10));
    _direction = MoveDirection.right;
    _squares = squares(
      snake: _snake,
      food: _food,
    );

    _timer = Timer.periodic(const Duration(milliseconds: 300), (timer) {
      setState(() {
        final lastSnake = _snake;
        _snake = moveTo(_snake, _direction);
        switch (isGameOver(_snake)) {
          case true:
            _gameOver = true;
            _timer.cancel();
          case false:
            _snake = eatFood(_snake, _food, lastSnake.last);
            if (_snake.length != lastSnake.length) {
              _food = (Random().nextInt(10), Random().nextInt(10));
            }
            _squares = squares(
              snake: _snake,
              food: _food,
            );
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.lightBlueAccent, Colors.blueAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Center(
            child: Stack(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ..._squares.map(
                      (row) => Row(
                        mainAxisSize: MainAxisSize.min,
                        children: row
                            .map((square) => _Square(size: 40, square: square))
                            .toList(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Controller(
                      onDirectionTapped: (d) =>
                          _direction = updatedDirection(_direction, d),
                    ),
                  ],
                ),
                if (_gameOver)
                  Positioned.fill(
                    child: GestureDetector(
                      onTap: () => setState(() => _initGame()),
                      child: Container(
                        color: Colors.black54,
                        child: const Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Game Over',
                                style: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                'Tap to restart',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      );
}

class _Square extends StatelessWidget {
  const _Square({
    required this.size,
    required this.square,
  });

  final double size;
  final FieldSquare square;

  @override
  Widget build(BuildContext context) => let((
        color: switch (square) {
          SnakeHeadSquare() => Colors.green,
          SnakeBodySquare() => Colors.lightGreen,
          SnakeFoodSquare() => Colors.blue,
          _ => Colors.white,
        }
      )).in_(
        (b) => TweenAnimationBuilder<Color?>(
          tween: ColorTween(
            begin: Colors.white,
            end: b.color,
          ),
          duration: const Duration(milliseconds: 100),
          builder: (context, color, child) {
            return Container(
              decoration: BoxDecoration(
                color: color,
                border: Border.all(
                  color: Colors.black,
                  width: 1,
                ),
              ),
              width: size,
              height: size,
            );
          },
        ),
      );
}
