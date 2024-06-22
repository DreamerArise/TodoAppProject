import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/todo.dart';
import 'screens/todo_list_screen.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TodoAdapter());
  await Hive.openBox<Todo>('todos');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: TextTheme(
          headline1: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF333333)),
          headline2: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF333333)),
          headline3: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF4F4F4F)),
          headline4: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Color(0xFF4F4F4F)),
        ),
      ),
      home: TodoListScreen(),
    );
  }
}
