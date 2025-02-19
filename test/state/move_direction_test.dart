import 'package:flutter_test/flutter_test.dart';
import 'package:functional_snake/state/move_direction.dart';

void main() {
  group('Update direction from .up', () {
    test(
        'updatedDirection returns .right if the direction changes from .up to .right',
        () {
      final direction = updatedDirection(MoveDirection.up, MoveDirection.right);
      expect(direction, MoveDirection.right);
    });

    test(
        'updatedDirection returns .left if the direction changes from .up to .left',
        () {
      final direction = updatedDirection(MoveDirection.up, MoveDirection.left);
      expect(direction, MoveDirection.left);
    });

    test(
        'updatedDirection returns .up if the direction changes from .up to .up',
        () {
      final direction = updatedDirection(MoveDirection.up, MoveDirection.up);
      expect(direction, MoveDirection.up);
    });
  });

  group('Update direction from .down', () {
    test(
        'updatedDirection returns .right if the direction changes from .down to .right',
        () {
      final direction =
          updatedDirection(MoveDirection.down, MoveDirection.right);
      expect(direction, MoveDirection.right);
    });

    test(
        'updatedDirection returns .left if the direction changes from .down to .left',
        () {
      final direction =
          updatedDirection(MoveDirection.down, MoveDirection.left);
      expect(direction, MoveDirection.left);
    });

    test(
        'updatedDirection returns .down if the direction changes from .down to .down',
        () {
      final direction =
          updatedDirection(MoveDirection.down, MoveDirection.down);
      expect(direction, MoveDirection.down);
    });
  });

  group('Update direction from .left', () {
    test(
        'updatedDirection returns .up if the direction changes from .left to .up',
        () {
      final direction = updatedDirection(MoveDirection.left, MoveDirection.up);
      expect(direction, MoveDirection.up);
    });

    test(
        'updatedDirection returns .down if the direction changes from .left to .down',
        () {
      final direction =
          updatedDirection(MoveDirection.left, MoveDirection.down);
      expect(direction, MoveDirection.down);
    });

    test(
        'updatedDirection returns .left if the direction changes from .left to .left',
        () {
      final direction =
          updatedDirection(MoveDirection.left, MoveDirection.left);
      expect(direction, MoveDirection.left);
    });
  });

  group('Update direction from .right', () {
    test(
        'updatedDirection returns .up if the direction changes from .right to .up',
        () {
      final direction = updatedDirection(MoveDirection.right, MoveDirection.up);
      expect(direction, MoveDirection.up);
    });

    test(
        'updatedDirection returns .down if the direction changes from .right to .down',
        () {
      final direction =
          updatedDirection(MoveDirection.right, MoveDirection.down);
      expect(direction, MoveDirection.down);
    });

    test(
        'updatedDirection returns .right if the direction changes from .right to .right',
        () {
      final direction =
          updatedDirection(MoveDirection.right, MoveDirection.right);
      expect(direction, MoveDirection.right);
    });
  });
}
