import 'package:flutter/material.dart';
import '../models/todo.dart';
import '../services/todo_service.dart';

class TodoEditScreen extends StatefulWidget {
  final Todo? todo;

  TodoEditScreen({this.todo});

  @override
  _TodoEditScreenState createState() => _TodoEditScreenState();
}

class _TodoEditScreenState extends State<TodoEditScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  String _status = 'Todo';
  final TodoService _todoService = TodoService();

  @override
  void initState() {
    super.initState();
    if (widget.todo != null) {
      _titleController.text = widget.todo!.title;
      _contentController.text = widget.todo!.content;
      _status = widget.todo!.status;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.todo == null ? 'Add a task' : 'Modify the task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Titre'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un titre';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _contentController,
                decoration: InputDecoration(labelText: 'Contenu'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Decrivez la tache';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                value: _status,
                onChanged: (String? newValue) {
                  setState(() {
                    _status = newValue!;
                  });
                },
                items: <String>['Todo', 'InProgress', 'Done', 'Bug']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                decoration: InputDecoration(labelText: 'Statut'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final newTodo = Todo(
                      id: widget.todo?.id ?? 0,
                      title: _titleController.text,
                      content: _contentController.text,
                      status: _status,
                    );
                    if (widget.todo == null) {
                      _todoService.addTodo(newTodo);
                    } else {
                      _todoService.updateTodo(newTodo);
                    }
                    Navigator.pop(context);
                  }
                },
                child: Text(widget.todo == null ? 'Add' : 'Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
