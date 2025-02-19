import 'package:flutter_test/flutter_test.dart';
import 'package:functional_snake/state/position.dart';

void main() {
  test('Position(1, 2) + Position(3, 4) = Position(4, 6)', () {
    expect((1, 2) + (3, 4), (4, 6));
  });
}
