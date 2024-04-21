import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:provider/provider.dart';
import 'package:todo/Repository/todo_provider.dart';
import 'package:todo/models/todo.dart';
import 'package:todo/styles/textstyle.dart';

void showAddTodoBottomSheet(BuildContext context) {
  final todoProvider = Provider.of<TodoProvider>(context, listen: false);
  final TextEditingController textEditingController = TextEditingController();
  final TextEditingController dateEditingController = TextEditingController();
  final TextEditingController timeEditingController = TextEditingController();

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.8,
            child: Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      AppBar(
                        title: const Text(
                          'Task',
                          style: headline3,
                        ),
                        leadingWidth: 100,
                        leading: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: const Icon(
                                Icons.arrow_back_ios,
                                color: Colors.blue,
                              ),
                            ),
                            const Text('Close', style: headlinesmallblue),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Padding(
                        padding: EdgeInsets.all(16),
                        child: Text(
                          'Add a task',
                          style: headline2,
                        ),
                      ),
                      Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Text('Name', style: headline3),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: TextField(
                              controller: textEditingController,
                              decoration: const InputDecoration(
                                hintText: 'Lorem Ipsum',
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Text('Datum und Uhrzeit', style: headline3),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () async {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());

                                showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext builder) {
                                    return SizedBox(
                                      height: MediaQuery.of(context)
                                              .copyWith()
                                              .size
                                              .height /
                                          3,
                                      child: CupertinoDatePicker(
                                        mode:
                                            CupertinoDatePickerMode.dateAndTime,
                                        onDateTimeChanged: (DateTime dateTime) {
                                          // Wenn ein Datum und eine Uhrzeit ausgewählt wurden, aktualisieren Sie den Text der Textfelder
                                          dateEditingController.text =
                                              DateFormat('dd.MM.yyyy')
                                                  .format(dateTime);
                                          timeEditingController.text =
                                              TimeOfDay.fromDateTime(dateTime)
                                                  .format(context);
                                        },
                                      ),
                                    );
                                  },
                                );
                              },
                              child: AbsorbPointer(
                                child: TextField(
                                  controller: dateEditingController,
                                  decoration: const InputDecoration(
                                      hintText: 'Time and Date'),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            child: const Text('Done'),
                            onPressed: () {
                              String todoText =
                                  textEditingController.text.trim();
                              if (todoText.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        'Bitte geben Sie einen Text für die Todo ein.'),
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
                        ),
                      ),
                    ]),
              ),
            ),
          ));
    },
  );
}
