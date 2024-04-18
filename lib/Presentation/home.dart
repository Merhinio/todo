import 'package:flutter/material.dart';
import 'package:todo/Repository/repository.dart';
import 'package:todo/models/todo.dart';
import 'package:todo/styles/customstyle.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';



import 'package:todo/styles/textstyle.dart';

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();

}


class _MyHomeState extends State<MyHome> {
  TextEditingController todoController = TextEditingController();


 



  @override
  void dispose() {
    todoController.dispose();
    super.dispose();
  }

  void alertDialog() {
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
                      setState(() {
                        final newTodo = Todo(
                          title: todoController.text,
                          creationDate: DateTime.now(),
                        );
                        context.read<TodoProvider>().addTodo(newTodo);
                        todoController.clear();
                        Navigator.of(context).pop();
                      });
                    },
                    child: const Text('Hinzufügen'))
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    final todoProvider = context.watch<TodoProvider>();

    return Stack(children: [
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
              onPressed: alertDialog,
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
            Consumer<TodoProvider>(
              builder: (context, todoProvider, child) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: todoProvider.createdTodos.length,
                    itemBuilder: (context, index) {
                      final item = todoProvider.createdTodos[index];
                      String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(item.creationDate);
                      return ListTile(
                        title: Text(item.title),
                        subtitle: Text('Erstellt am: $formattedDate'),
                        trailing: Checkbox(
                          value: item.isDone,
                          onChanged: (value) {
                            setState(() {
                              item.isDone = value!;
                              if (item.isDone) {
                                todoProvider.finishTodo(item);
                              }
                            });
                          },
                        ),
                      );
                    },
                  ),
                );
              },
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
            Consumer<TodoProvider>(
              builder: (context, todoProvider, child) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: todoProvider.finishedTodos.length,
                    itemBuilder: (context, index) {
                      final item = todoProvider.finishedTodos[index];
                      String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(item.creationDate);
                      return ListTile(
                        title: Text(item.title),
                        subtitle: Text('Erstellt am: $formattedDate'),
                        trailing: Checkbox(
                          value: item.isDone,
                          onChanged: (value) {
                            setState(() {
                              item.isDone = value!;
                              if (!item.isDone) {
                                todoProvider.addTodo(item);
                              }
                            });
                          },
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    ]);
  }
}
