import 'package:flutter/material.dart';
import '../models/todo.dart';
import '../services/todo_service.dart';
import 'todo_edit_screen.dart';

class TodoDetailsScreen extends StatelessWidget {
  final Todo todo;
  final TodoService _todoService = TodoService();

  TodoDetailsScreen({required this.todo});

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
        title: Text('Détails de la tache', style: Theme.of(context).textTheme.headline1),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TodoEditScreen(todo: todo),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              _showDeleteConfirmationDialog(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              todo.title,
              style: Theme.of(context).textTheme.headline1,
            ),
            SizedBox(height: 10),
            Text(todo.content, style: Theme.of(context).textTheme.headline4),
            SizedBox(height: 20),
            Row(
              children: [
                Text('Statut : ', style: Theme.of(context).textTheme.headline3),
                Text(
                  todo.status,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: getStatusColor(todo.status),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Supprimer cette tache'),
        content: Text('Êtes-vous sûr de vouloir supprimer cette tache ?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Non'),
          ),
          TextButton(
            onPressed: () async {
              await _todoService.deleteTodo(todo.id);
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: Text('Oui'),
          ),
        ],
      ),
    );
  }
}
