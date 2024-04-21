// in dialogs.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/Repository/todo_provider.dart';
import 'package:todo/models/todo.dart';

class AddTodoDialog extends StatelessWidget {
  final TextEditingController todoController;

  const AddTodoDialog({super.key, required this.todoController});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Todo'),
      content: TextField(
        controller: todoController,
        decoration: const InputDecoration(
          hintText: 'Füge eine ToDo hinzu',
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            String todoText = todoController.text.trim();
            if (todoText.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Bitte geben Sie einen Text für die Todo ein.'),
                ),
              );
            } else {
              final newTodo = Todo(
                title: todoText,
                creationDate: DateTime.now(),
              );
              Provider.of<TodoProvider>(context, listen: false)
                  .addTodo(newTodo);
              todoController.clear();
              Navigator.of(context).pop();
            }
          },
          child: const Text('Hinzufügen'),
        ),
      ],
    );
  }
}

class DeleteTodoDialog extends StatelessWidget {
  final Todo item;

  const DeleteTodoDialog({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Todo löschen'),
      content: const Text('Möchten Sie diese Todo wirklich löschen?'),
      actions: [
        TextButton(
          child: const Text('Löschen'),
          onPressed: () {
            final todoProvider =
                Provider.of<TodoProvider>(context, listen: false);
            todoProvider.removeTodo(item);
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('Todo gelöscht'),
                action: SnackBarAction(
                  label: 'Rückgängig',
                  onPressed: () {
                    todoProvider.addTodo(item);
                  },
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
