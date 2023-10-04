import 'package:hive_flutter/adapters.dart';
import 'package:todo/models/todo_model.dart';

class TodoDb{

  TodoDb.internal();

  static TodoDb instance = TodoDb.internal();

  factory TodoDb(){
    return instance;
  }

  Future<void> addTask(Todo todo)async{
    final db = await Hive.openBox<Todo>("user");
    db.put(todo.id, todo);
  }

  Future<List<Todo>> getTask()async{
    final db = await Hive.openBox<Todo>("user");
    return db.values.toList();
  }

  Future<void> deleteTask(Todo todo)async{
    final db = await Hive.openBox<Todo>("user");
    db.delete(todo.id);
  }
}