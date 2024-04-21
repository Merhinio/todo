import 'package:flutter/material.dart';

import 'package:todo/Repository/todo_provider.dart';
import 'package:todo/models/todo.dart';
import 'package:todo/styles/customstyle.dart';

import 'package:provider/provider.dart';

import 'package:todo/styles/textstyle.dart';
import 'package:todo/widgets/add_todo_bottom_sheet.dart';
import 'package:todo/widgets/custom_divider.dart';
import 'package:todo/widgets/dialogs.dart';
import 'package:todo/widgets/todo_count.dart';
import 'package:todo/widgets/todo_lists.dart';

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Provider.of<TodoProvider>(context, listen: false).loadTodos();
  }

  void alertDialogdelete(BuildContext context, Todo item) {
    showDialog(
      context: context,
      builder: (BuildContext context) => DeleteTodoDialog(item: item),
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
                onPressed: () => showAddTodoBottomSheet(context),
              ),
            ],
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
              const CustomDivider(),
              Expanded(
                child: CreatedTodosList(createdTodos: createdTodos),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Text(
                  'Finished Todos',
                  style: headline1,
                ),
              ),
              const CustomDivider(),
              Expanded(
                child: FinishedTodosList(
                  finishedTodos: finishedTodos,
                  onTodoLongPress: (todo) => alertDialogdelete(context, todo),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
