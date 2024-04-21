import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/models/todo.dart';


class TodoStorage {
  Future<List<Todo>> getTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final todoString = prefs.getString('todo');
    if (todoString == null) return [];

    final decodedJson = jsonDecode(todoString);
    if (decodedJson is List) {
      return decodedJson.map((e) => Todo.fromJson(e)).toList();
    } else if (decodedJson is Map<String, dynamic>) {
      return [Todo.fromJson(decodedJson)];
    } else {
      return [];
    }
  }

  Future<void> saveTodos(List<Todo> todos) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = todos.map((e) => e.toJson()).toList();
    final jsonString = jsonEncode(jsonList);
    await prefs.setString('todo', jsonString);
  }
}