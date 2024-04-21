
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo/Repository/todo_provider.dart';
import 'package:todo/models/todo.dart';

class CreatedTodosList extends StatelessWidget {
  final List<Todo> createdTodos;

  const CreatedTodosList({super.key, required this.createdTodos});

  @override
  Widget build(BuildContext context) {
    final todoProvider = Provider.of<TodoProvider>(context);
    return ListView.builder(
      itemCount: createdTodos.length,
      itemBuilder: (context, index) {
        final item = createdTodos[index];
        return ListTile(
          title: Text(item.title),
          subtitle: Text(
            item.finishDate != null
                ? 'Erledigt am: ${(item.finishDate!)} ${(item.finishDate!)}'
                : 'Noch nicht erledigt',
          ),
          trailing: Checkbox(
            value: item.isDone,
            onChanged: (value) {
              todoProvider.setTodoStatus(item, value!);
            },
          ),
        );
      },
    );
  }
}

class FinishedTodosList extends StatelessWidget {
  final List<Todo> finishedTodos;
  final Function(Todo) onTodoLongPress;

  const FinishedTodosList(
      {super.key, required this.finishedTodos, required this.onTodoLongPress});

  @override
  Widget build(BuildContext context) {
    final todoProvider = Provider.of<TodoProvider>(context);
    return ListView.builder(
      itemCount: finishedTodos.length,
      itemBuilder: (context, index) {
        final item = finishedTodos[index];
        String formattedDate =
            DateFormat('yyyy-MM-dd – kk:mm').format(item.creationDate);
        return ListTile(
          onLongPress: () => onTodoLongPress(item),
          title: Text(item.title),
          subtitle: Text('Erledigt am: $formattedDate'),
          trailing: Checkbox(
            value: item.isDone,
            onChanged: (value) {
              todoProvider.setTodoStatus(item, value!);
            },
          ),
        );
      },
    );
  }
}
