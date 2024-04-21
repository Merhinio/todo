
import 'package:flutter/material.dart';
import 'package:todo/Repository/todo_storage.dart';
import 'package:todo/models/todo.dart';




class TodoProvider extends ChangeNotifier {
 List<Todo> todos = [];
 final TodoStorage todoStorage = TodoStorage();

  int get openTodosCount => todos.where((todo) => !todo.isDone).length;
  int get completedTodosCount => todos.where((todo) => todo.isDone).length;
 
  Future<void> loadTodos() async {
    todos = await todoStorage.getTodos();
    notifyListeners();
  }

  List<Todo> getOpenTodos() {
    List<Todo> openTodos = [];
    for (var todo in todos) {
      if (!todo.isDone) {
        openTodos.add(todo);
      }
    }
    return openTodos;
  }

  List<Todo> getFinishedTodos() {
    List<Todo> finishedTodos = [];
    for (var todo in todos) {
      if (todo.isDone) {
        finishedTodos.add(todo);
      }
    }
    return finishedTodos;
  }

  void addTodo(Todo todo) async {
    todos.add(todo);
    await todoStorage.saveTodos(todos);
    notifyListeners();
  }

  void removeTodo(Todo todo) async {
    todos.remove(todo);
    await todoStorage.saveTodos(todos);
    notifyListeners();
  
  }

  void finishTodo(Todo todo) async  {
    todo.isDone = true;
    await todoStorage.saveTodos(todos);
    notifyListeners();
  }
void setTodoStatus(Todo todo, bool isDone) async {
  todo.isDone = isDone;
  if (isDone) {
    todo.finishDate = DateTime.now();
  } else {
    todo.finishDate = null;
  }
  await todoStorage.saveTodos(todos);
  notifyListeners();
}
}