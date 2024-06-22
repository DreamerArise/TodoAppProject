import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/todo.dart';
import '../services/todo_service.dart';
import 'todo_edit_screen.dart';
import 'todo_details_screen.dart';

class TodoListScreen extends StatefulWidget {
  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  final TodoService _todoService = TodoService();
  String filterStatus = "Status";

  Color getStatusColor(String status) {
    switch (status) {
      case 'Done':
        return Color(0xFF27AE60);
      case 'InProgress':
        return Color(0xFF56CCF2);
      case 'Bug':
        return Color(0xFFEB5757);
      case 'Todo':
      default:
        return Color(0xFF4F4F4F);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo App', style: Theme.of(context).textTheme.headline1),
        actions: [
          DropdownButton<String>(
            value: filterStatus,
            onChanged: (String? newValue) {
              setState(() {
                filterStatus = newValue!;
              });
            },
            items: <String>['Status', 'Todo', 'InProgress', 'Done', 'Bug']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<Todo>('todos').listenable(),
        builder: (context, Box<Todo> box, _) {
          List<Todo> todos = box.values.toList();
          if (filterStatus != "Status") {
            todos = todos.where((todo) => todo.status == filterStatus).toList();
          }
          return ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) {
              final todo = todos[index];
              return ListTile(
                title: Text(todo.title, style: Theme.of(context).textTheme.headline2),
                subtitle: Text(todo.content, style: Theme.of(context).textTheme.headline4),
                trailing: Icon(Icons.circle, color: getStatusColor(todo.status)),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TodoDetailsScreen(todo: todo)),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TodoEditScreen()),
        ),
        child: Icon(Icons.add),
      ),
    );
  }
}
