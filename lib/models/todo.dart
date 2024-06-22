import 'package:hive/hive.dart';

part 'todo.g.dart';

@HiveType(typeId: 0)
class Todo {
  @HiveField(0)
  int id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String content;

  @HiveField(3)
  String status;

  Todo({
    required this.id,
    required this.title,
    required this.content,
    required this.status,
  });

  // Méthode pour sauvegarder le Todo
  Future<void> save() async {
    final box = await Hive.openBox<Todo>('todos');
    await box.put(id, this);
  }

  // Méthode pour supprimer le Todo
  Future<void> delete() async {
    final box = await Hive.openBox<Todo>('todos');
    await box.delete(id);
  }
}
