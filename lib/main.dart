import 'package:flutter/material.dart';
import 'package:todo_app/home/add_task.dart';
import 'package:todo_app/home/body_home.dart';

main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: const Icon(Icons.menu),
          title: const Text("Tasker",style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          ),
          elevation: 0,
        ),
        floatingActionButton: const AddTask(),
        body: const Home(),
      ),
    );
  }
}