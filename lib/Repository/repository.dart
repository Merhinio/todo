import 'package:todo/models/todo.dart';

class TodoRepository {

  List<Todo> createdTodos = [
   
  ];

  List<Todo> finishedTodos = [
    
  ];

 

  void addTodo(Todo todo) {
    createdTodos.add(todo);
  }

  void removeTodo(Todo todo) {
    createdTodos.remove(todo);
  }

  void finishTodo(Todo todo) {
    createdTodos.remove(todo);
    finishedTodos.add(todo);
  }

}