import 'package:flutter_test/flutter_test.dart';
import 'package:functional_snake/state/field.dart';
import 'package:functional_snake/state/move_direction.dart';

void main() {
  group('FieldSquare Tests', () {
    test('maybeHeadAt returns SnakeHeadSquare if head is at position', () {
      final snake = [(0, 0)];
      const position = (0, 0);
      expect(maybeHeadAt(snake, position), isA<SnakeHeadSquare>());
    });

    test('maybeHeadAt returns null if head is not at position', () {
      final snake = [(0, 0)];
      const position = (1, 0);
      expect(maybeHeadAt(snake, position), isNull);
    });

    test('maybeBodyAt returns SnakeBodySquare if body is at position', () {
      final snake = [(0, 0), (1, 0)];
      const position = (1, 0);
      expect(maybeBodyAt(snake, position), isA<SnakeBodySquare>());
    });

    test('maybeBodyAt returns null if body is not at position', () {
      final snake = [(0, 0), (0, 1)];
      const position = (1, 0);
      expect(maybeBodyAt(snake, position), isNull);
    });

    test('maybeFoodAt returns SnakeFoodSquare if food is at position', () {
      const food = (0, 0);
      const position = (0, 0);
      expect(maybeFoodAt(food, position), isA<SnakeFoodSquare>());
    });

    test('maybeFoodAt returns null if food is not at position', () {
      const food = (0, 0);
      const position = (1, 0);
      expect(maybeFoodAt(food, position), isNull);
    });

    test('squares generates correct field layout', () {
      final snake = [(0, 0), (1, 0)];
      const food = (2, 0);
      final field = squares(snake: snake, food: food);
      expect(field[0][0], isA<SnakeHeadSquare>());
      expect(field[0][1], isA<SnakeBodySquare>());
      expect(field[0][2], isA<SnakeFoodSquare>());
      expect(field[2][1], isA<EmptySquare>());
    });
  });

  group('Snake behavior tests', () {
    test('eatFood extends snake if head is on food', () {
      final snake = [(1, 1)];
      const food = (1, 1);
      const lastTale = (1, 0); // meaning the snake moved from (1, 0) to (1, 1)
      final newSnake = eatFood(snake, food, lastTale);
      expect(newSnake.length, 2);
      expect(newSnake.last, lastTale);
    });

    test('eatFood does not extend snake if head is not on food', () {
      final snake = [(0, 0)];
      const food = (1, 0);
      const lastTale = (1, 0); // meaning the snake moved from (1, 0) to (0, 0)
      final newSnake = eatFood(snake, food, lastTale);
      expect(newSnake.length, 1);
    });

    test('moveTo updates snake position correctly', () {
      final snake = [(0, 0)];
      final movedSnake = moveTo(snake, MoveDirection.right);
      expect(movedSnake.first, (1, 0));
    });

    test('isGameOver returns true if snake crashes into itself', () {
      final snake = [(0, 0), (1, 0), (2, 0), (2, 1), (1, 1), (0, 1), (0, 2)];
      final movedSnake = moveTo(snake, MoveDirection.down);
      expect(isGameOver(movedSnake), isTrue);
    });

    test('isGameOver returns true if snake crashes into border', () {
      final snake = [(0, 0)];
      final movedSnake = moveTo(snake, MoveDirection.left);
      expect(isGameOver(movedSnake), isTrue);
    });

    test('isGameOver returns false if game is not over', () {
      final snake = [(0, 0), (1, 0)];
      final movedSnake = moveTo(snake, MoveDirection.right);
      expect(isGameOver(movedSnake), isFalse);
    });
  });
}
