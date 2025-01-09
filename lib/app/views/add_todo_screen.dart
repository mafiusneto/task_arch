import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/todo_viewmodel.dart';

class AddTodoScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Adicionar Tarefa')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: 'Título da Tarefa'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final title = _controller.text.trim();
                if (title.isNotEmpty) {
                  context.read<TodoViewModel>().addTodo(title);
                  Navigator.pop(context);
                }
              },
              child: Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }
}
