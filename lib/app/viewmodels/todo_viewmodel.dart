import 'package:flutter/material.dart';
import '../models/todo_model.dart';
import '../services/todo_service.dart';

class TodoViewModel extends ChangeNotifier {
  final TodoService _service = TodoService();
  List<TodoModel> _todos = [];

  List<TodoModel> get todos => _todos;

  Future<void> fetchTodos() async {
    _todos = await _service.getTodos();
    notifyListeners();
  }

  Future<void> addTodo(String title) async {
    await _service.addTodo(TodoModel(title: title));
    await fetchTodos();
  }

  Future<void> toggleTodoCompletion(TodoModel todo) async {
    final updatedTodo = todo.copyWith(isCompleted: !todo.isCompleted);
    await _service.updateTodo(updatedTodo);
    await fetchTodos();
  }

  Future<void> deleteTodo(int id) async {
    await _service.deleteTodo(id);
    await fetchTodos();
  }
}
