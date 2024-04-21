// in add_todo_bottom_sheet.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/Repository/todo_provider.dart';
import 'package:todo/models/todo.dart';

void showAddTodoBottomSheet(BuildContext context) {
  final todoProvider = Provider.of<TodoProvider>(context, listen: false);
  final TextEditingController textEditingController = TextEditingController();

  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text('Neue Todo', style: TextStyle(fontSize: 24)),
            TextField(
              controller: textEditingController,
              decoration: const InputDecoration(hintText: 'Todo eingeben'),
            ),
            ElevatedButton(
              child: const Text('Hinzufügen'),
              onPressed: () {
                String todoText = textEditingController.text.trim();
                if (todoText.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content:
                          Text('Bitte geben Sie einen Text für die Todo ein.'),
                    ),
                  );
                } else {
                  todoProvider.addTodo(Todo(
                    title: todoText,
                    creationDate: DateTime.now(),
                  ));
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        ),
      );
    },
  );
}
