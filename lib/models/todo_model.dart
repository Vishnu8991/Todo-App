import 'package:hive_flutter/adapters.dart';
import 'package:hive/hive.dart';
part 'todo_model.g.dart';


@HiveType(typeId: 1)
class Todo{

  @HiveField(0)
  final String titles;

  @HiveField(1)
  final String subtitles;

  @HiveField(2)
  String? id;

  Todo({required this.titles, required this.subtitles}){
    id = DateTime.now().microsecondsSinceEpoch.toString();
  }
  
}