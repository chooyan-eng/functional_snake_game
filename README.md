# functional_snake

Functional Snake is a Flutter app that experimentally implements the game app with the idea of functional programming, especially Haskell. 

# Coding Style

## Clear separation between imperative and functional

In this project, the methods and functions are implemented in a way of functional programming as much as possible, and clearly separated from the imperative code.

All the "functional" methods and functions are implemented with arrow notation like below:

```dart
/// Returns the updated snake after moving in the given direction.
List<Position> moveTo(List<Position> snake, MoveDirection direction) =>
    switch (direction) {
      MoveDirection.up => [snake.first + (0, -1), ...snake].init,
      MoveDirection.down => [snake.first + (0, 1), ...snake].init,
      MoveDirection.left => [snake.first + (-1, 0), ...snake].init,
      MoveDirection.right => [snake.first + (1, 0), ...snake].init,
    };
```

They are implemented with a rule of:

- consisting of only one expression
- "pure", meaning they don't introduce any side effects, not depending on any external state

`build()` method of `StatelessWidget` and `State` class are also implemented with arrow notation.

## Haskell-like syntax

`lib/haskell_style.dart` enables us to use some Haskell-like syntax in Dart.

For example, it introduces `let` function to imitate Haskell's `let` expression like below.

```dart
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
...
```

Also, functions can be "curried" with `.curried` getter introduced by `CurryExtension2` on `Function` type like below.

```dart
SnakeHeadSquare? maybeHeadAt(List<Position> snake, Position position) =>
    snake.first == position ? SnakeHeadSquare() : null;

final cMaybeHeadAt = maybeHeadAt.curried;
final result = cMaybeHeadAt(snake)(position);
```

Moreover, function composition, such as `f + g`, list operations of `head`, `tail` and `init`, or `where` clause are also introduced by importing `haskell_style.dart`.

## Prefer record over class

In this project, I prefer to use `Record` over `Class` to represent the state of the game. 

With record, we can easily define immutable data structures, which also collaborates nicely with pattern matching. 

# It's just an investigation purpose

Note that this style is just my personal investigation purpose to find any ideas to enhance our Flutter coding, and it's not recommended to use this style directly in a real project.

As this toy project is so tiny that you can easily take a glance at all the code, I believe you may also find something interesting. 