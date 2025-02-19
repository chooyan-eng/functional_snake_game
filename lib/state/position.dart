/// Position on the game field.
/// (0, 0) is the top-left corner.
typedef Position = (int, int);

extension PositionExtension on Position {
  /// Returns the sum of two positions.
  Position operator +(Position other) =>
      (this.$1 + other.$1, this.$2 + other.$2);
}
