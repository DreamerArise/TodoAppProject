import 'package:hive/hive.dart';
import '../models/todo.dart';

class TodoService {
  Future<void> addTodo(Todo todo) async {
    final box = await Hive.openBox<Todo>('todos');
    await box.put(todo.id, todo);
  }

  Future<void> updateTodo(Todo todo) async {
    final box = await Hive.openBox<Todo>('todos');
    await box.put(todo.id, todo);
  }

  Future<void> deleteTodo(int id) async {
    final box = await Hive.openBox<Todo>('todos');
    await box.delete(id);
  }
}
