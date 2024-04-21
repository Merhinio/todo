import 'package:flutter/material.dart';

class TodoCountRow extends StatelessWidget {
  final int openTodosCount;
  final int completedTodosCount;
  const TodoCountRow({
    super.key,
    required this.openTodosCount,
    required this.completedTodosCount,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            'Offen: $openTodosCount',
            style: const TextStyle(
              color: Color.fromARGB(255, 4, 4, 4),
            ),
          ),
          Text(
            'Erledigt: $completedTodosCount',
            style: const TextStyle(
              color: Color.fromARGB(255, 7, 7, 7),
            ),
          ),
        ],
      ),
    );
  }
}
