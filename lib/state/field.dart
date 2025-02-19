import 'package:functional_snake/haskell_style.dart';
import 'package:functional_snake/state/move_direction.dart';
import 'package:functional_snake/state/position.dart';

const bottomRight = (9, 11);

/// One square state of the game field.
sealed class FieldSquare {}

/// Nothing is on this square.
class EmptySquare extends FieldSquare {}

/// Snake's head is on this square.
class SnakeHeadSquare extends FieldSquare {}

/// Snake body is on this square.
class SnakeBodySquare extends FieldSquare {
  final int bodyType;

  SnakeBodySquare({required this.bodyType});
}

/// Food is on this square.
class SnakeFoodSquare extends FieldSquare {
  final int foodType;

  SnakeFoodSquare({required this.foodType});
}

/// Returns `SnakeHeadSquare` if snake's head is on the position, otherwise `null`.
SnakeHeadSquare? maybeHeadAt(List<Position> snake, Position position) =>
    snake.first == position ? SnakeHeadSquare() : null;

/// Returns `SnakeBodySquare` if snake's body is on the position, otherwise `null`.
SnakeBodySquare? maybeBodyAt(List<Position> snake, Position position) =>
    snake.skip(1).contains(position) ? SnakeBodySquare(bodyType: 0) : null;

/// Returns `SnakeFoodSquare` if food is on the position, otherwise `null`.
SnakeFoodSquare? maybeFoodAt(Position foodAt, Position position) =>
    foodAt == position ? SnakeFoodSquare(foodType: 0) : null;

/// Curried version of mayBe*At functions above.
final cMaybeHeadAt = maybeHeadAt.curried;
final cMaybeBodyAt = maybeBodyAt.curried;
final cMaybeFoodAt = maybeFoodAt.curried;

/// Returns a list of lists of [FieldSquare]s generated from the given snake and food positions.
List<List<FieldSquare>> squares({
  required List<Position> snake,
  required Position food,
}) =>
    let((
      maybeHeadAt: cMaybeHeadAt(snake),
      maybeBodyAt: cMaybeBodyAt(snake),
      maybeFoodAt: cMaybeFoodAt(food),
    )).in_(
      (b) => List.generate(
        bottomRight.$2 + 1,
        (i) => List.generate(
          bottomRight.$1 + 1,
          (j) =>
              b.maybeHeadAt((j, i)) ??
              b.maybeBodyAt((j, i)) ??
              b.maybeFoodAt((j, i)) ??
              EmptySquare(),
        ),
      ),
    );

/// Returns a new snake after eating food.
/// If the snake's head is not on the food, the snake is not changed.
List<Position> eatFood(
        List<Position> snake, Position food, Position lastTale) =>
    snake.first == food ? [...snake, lastTale] : snake;

/// Returns the updated snake after moving in the given direction.
List<Position> moveTo(List<Position> snake, MoveDirection direction) =>
    switch (direction) {
      MoveDirection.up => [snake.first + (0, -1), ...snake].init,
      MoveDirection.down => [snake.first + (0, 1), ...snake].init,
      MoveDirection.left => [snake.first + (-1, 0), ...snake].init,
      MoveDirection.right => [snake.first + (1, 0), ...snake].init,
    };

/// Returns whether snake crashes into itself or the field border.
bool isGameOver(List<Position> snake) =>
    snake.skip(1).contains(snake.first) ||
    snake.first.$1 < 0 ||
    snake.first.$1 > bottomRight.$1 ||
    snake.first.$2 < 0 ||
    snake.first.$2 > bottomRight.$2;
