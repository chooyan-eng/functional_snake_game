import 'package:flutter/material.dart';
import 'package:functional_snake/state/move_direction.dart';

class Controller extends StatelessWidget {
  const Controller({
    super.key,
    required this.onDirectionTapped,
  });

  final ValueChanged<MoveDirection> onDirectionTapped;

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton(
            onPressed: () => onDirectionTapped(MoveDirection.up),
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(20),
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
            ),
            child: const Icon(Icons.arrow_upward, size: 30),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => onDirectionTapped(MoveDirection.left),
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(20),
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
                child: const Icon(Icons.arrow_left, size: 30),
              ),
              const SizedBox(width: 24),
              ElevatedButton(
                onPressed: () => onDirectionTapped(MoveDirection.right),
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(20),
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
                child: const Icon(Icons.arrow_right, size: 30),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () => onDirectionTapped(MoveDirection.down),
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(20),
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
            ),
            child: const Icon(Icons.arrow_downward, size: 30),
          ),
        ],
      );
}
