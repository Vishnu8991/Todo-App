import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo/home.dart';
import 'package:todo/models/todo_model.dart';

void main() async{
  WidgetsFlutterBinding();
  await Hive.initFlutter();
  Hive.registerAdapter(TodoAdapter());
  await Hive.openBox<Todo>("user");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: Home()
    );
  }
}

