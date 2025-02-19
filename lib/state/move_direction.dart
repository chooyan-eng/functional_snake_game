/// Snake's moving direction.
enum MoveDirection {
  up,
  down,
  left,
  right;
}

/// Returns whether two directions are opposite.
bool isOpposite(MoveDirection a, MoveDirection b) =>
    (a == MoveDirection.up && b == MoveDirection.down) ||
    (a == MoveDirection.down && b == MoveDirection.up) ||
    (a == MoveDirection.left && b == MoveDirection.right) ||
    (a == MoveDirection.right && b == MoveDirection.left);

/// Returns the updated direction.
/// Because the snake can't move backward, it returns the current direction
/// if the new direction is opposite.
/// Otherwise, the new direction is returned.
MoveDirection updatedDirection(
  MoveDirection current,
  MoveDirection newDirection,
) =>
    isOpposite(current, newDirection) ? current : newDirection;
