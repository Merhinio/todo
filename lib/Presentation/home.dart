import 'package:flutter/material.dart';

import 'package:todo/Repository/todo_provider.dart';
import 'package:todo/models/todo.dart';
import 'package:todo/styles/customstyle.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:todo/styles/textstyle.dart';
import 'package:todo/widgets/todo_count.dart';

class MyHome extends StatefulWidget {
  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  final TextEditingController todoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Provider.of<TodoProvider>(context, listen: false).loadTodos();
  }

  void alertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Add Todo'),
        content: TextField(
          onTapOutside: (PointerDownEvent event) {
            FocusScope.of(context).unfocus();
          },
          controller: todoController,
          decoration: const InputDecoration(
            hintText: 'Füge eine ToDo hinzu',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Schließen'),
          ),
          TextButton(
            onPressed: () {
              final newTodo = Todo(
                title: todoController.text,
                creationDate: DateTime.now(),
              );
              Provider.of<TodoProvider>(context, listen: false)
                  .addTodo(newTodo);
              todoController.clear();
              Navigator.of(context).pop();
            },
            child: const Text('Hinzufügen'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final todoProvider = Provider.of<TodoProvider>(context);
    final createdTodos =
        todoProvider.todos.where((todo) => !todo.isDone).toList();
    final finishedTodos =
        todoProvider.todos.where((todo) => todo.isDone).toList();
    int openTodosCount = todoProvider.openTodosCount;
    int completedTodosCount = todoProvider.completedTodosCount;

    return Stack(
      children: [
        Container(
          decoration: customBackground,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            actions: [
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () => alertDialog(context),
              ),
            ],
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: SearchBar(
                  hintText: 'Search...',
                  leading: Icon(Icons.search),
                ),
              ),
              TodoCountRow(
                openTodosCount: openTodosCount,
                completedTodosCount: completedTodosCount,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Text(
                  'All Todos',
                  style: headline1,
                ),
              ),
              const Divider(
                color: Colors.black,
                thickness: 0.09,
                endIndent: 20,
                indent: 10,
              ),
              Expanded(
                child: ListView.builder(
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
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Text(
                  'Finished Todos',
                  style: headline1,
                ),
              ),
              const Divider(
                color: Colors.black,
                thickness: 0.09,
                endIndent: 20,
                indent: 10,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: finishedTodos.length,
                  itemBuilder: (context, index) {
                    final item = finishedTodos[index];
                    String formattedDate = DateFormat('yyyy-MM-dd – kk:mm')
                        .format(item.creationDate);
                    return ListTile(
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
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
