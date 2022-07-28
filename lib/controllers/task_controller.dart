import 'package:get/get.dart';
import 'package:todo_list_algoriza/db/db_helper.dart';
import 'package:todo_list_algoriza/models/task.dart';

class TaskController extends GetxController {
  @override
  void onReady() {
    getTasks();
    super.onReady();
  }

  var taskList = <Task>[].obs;

  Future<int> addTask({Task? task}) async {
    return await DBHelper.insert(task);
  }

  void getTasks() async {
    List<Map<String, dynamic>> tasks = await DBHelper.query();
    taskList.assignAll(tasks.map((data) => new Task.fromJson(data)).toList());
  }

  void deleteTask(Task task) {
    DBHelper.deleteTask(task);
    getTasks();
  }

  void updateCompletedTask(int id) async {
    await DBHelper.updateTask(id);
    getTasks();
  }
}
