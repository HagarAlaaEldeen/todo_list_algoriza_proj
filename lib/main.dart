import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_list_algoriza/db/db_helper.dart';
import 'package:todo_list_algoriza/screens/add_task.dart';
import 'package:todo_list_algoriza/screens/board.dart';
import 'package:todo_list_algoriza/screens/schedule.dart';

Future<void> main() async {
  await DBHelper.initDB();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo List',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => const Board(),
        "/schedule": (context) => const Schedule(),
        "/addTask": (context) => const AddTask(),
      },
    );
  }
}
