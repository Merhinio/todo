import 'package:flutter/material.dart';
import 'package:todo/models/todo.dart';



class TodoProvider extends ChangeNotifier {
  List<Todo> createdTodos = [];
  List<Todo> finishedTodos = [];

  void addTodo(Todo todo) {
    createdTodos.add(todo);
    notifyListeners();
  }

  void removeTodo(Todo todo) {
    createdTodos.remove(todo);
    notifyListeners();
  }

  void finishTodo(Todo todo) {
    createdTodos.remove(todo);
    finishedTodos.add(todo);
    notifyListeners();
  }
}