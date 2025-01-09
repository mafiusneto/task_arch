import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/todo_viewmodel.dart';
import 'add_todo_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final todoViewModel = context.watch<TodoViewModel>();

    return Scaffold(
      appBar: AppBar(title: Text('Lista de Tarefas')),
      body: ListView.builder(
        itemCount: todoViewModel.todos.length,
        itemBuilder: (context, index) {
          final todo = todoViewModel.todos[index];
          return ListTile(
            title: Text(todo.title),
            leading: Checkbox(
              value: todo.isCompleted,
              onChanged: (_) => todoViewModel.toggleTodoCompletion(todo),
            ),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => todoViewModel.deleteTodo(todo.id!),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AddTodoScreen()),
        ),
        child: Icon(Icons.add),
      ),
    );
  }
}
