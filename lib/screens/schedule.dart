import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:todo_list_algoriza/controllers/task_controller.dart';
import 'package:todo_list_algoriza/models/task.dart';
import 'package:todo_list_algoriza/screens/add_task.dart';
import 'package:todo_list_algoriza/widgets/task_tile.dart';

class Schedule extends StatefulWidget {
  const Schedule({Key? key}) : super(key: key);

  @override
  State<Schedule> createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  DateTime selectedDate = DateTime.now();
  final taskController = Get.put(TaskController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        elevation: 0.0,
        title: const Text(
          'Schedule',
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  DateFormat.yMMMd().format(DateTime.now()),
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                ),
                Container(
                  width: 100,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                      await Get.to(() => AddTask());
                      taskController.getTasks();
                    },
                    child: const Text(
                      "+ add task",
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      onPrimary: Theme.of(context).colorScheme.onPrimary,
                      primary: Theme.of(context).colorScheme.primary,
                    ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 25, left: 20),
            child: DatePicker(
              DateTime.now(),
              initialSelectedDate: DateTime.now(),
              selectionColor: Colors.cyan,
              selectedTextColor: Colors.white,
              dateTextStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey),
              dayTextStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey),
              monthTextStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey),
              height: 95,
              width: 65,
              onDateChange: (date) {
                selectedDate = date;
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(child: Obx(() {
            return ListView.builder(
                itemCount: taskController.taskList.length,
                itemBuilder: (_, index) {
                  return AnimationConfiguration.staggeredList(
                    position: index,
                    child: SlideAnimation(
                        child: FadeInAnimation(
                      child: Row(children: [
                        GestureDetector(
                          onTap: () {
                            showBottomSheet(
                                context, taskController.taskList[index]);
                          },
                          child: TaskTile(taskController.taskList[index]),
                        ),
                      ]),
                    )),
                  );
                });
          })),
        ],
      ),
    );
  }

  showBottomSheet(BuildContext context, Task task) {
    Get.bottomSheet(Container(
      padding: const EdgeInsets.only(top: 5),
      height: task.isCompleted == 1
          ? MediaQuery.of(context).size.height * 0.22
          : MediaQuery.of(context).size.height * 0.30,
      child: Column(
        children: [
          Container(
            height: 7,
            width: 120,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          ),
          const Spacer(),
          task.isCompleted == 1
              ? Container()
              : taskFnButton(
                  label: "Completed",
                  color: Colors.green,
                  context: context,
                  onTap: () {
                    taskController.updateCompletedTask(task.id!);
                    Get.back();
                  }),
          const SizedBox(
            height: 5,
          ),
          taskFnButton(
              label: "Delete Task",
              color: Colors.red,
              context: context,
              onTap: () {
                taskController.deleteTask(task);
                Get.back();
              }),
          const SizedBox(
            height: 15,
          ),
          taskFnButton(
              label: "Close",
              color: Colors.cyan,
              isClosed: true,
              context: context,
              onTap: () {
                Get.back();
              }),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    ));
  }

  taskFnButton({
    required String label,
    required Color color,
    required Function()? onTap,
    bool isClosed = false,
    required BuildContext context,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 3),
        height: 50,
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: isClosed == true ? Colors.grey[300]! : color,
          ),
          borderRadius: BorderRadius.circular(20),
          color: isClosed == true ? Colors.transparent : color,
        ),
        child: Center(
            child: Text(label,
                style: isClosed
                    ? const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey)
                    : const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white))),
      ),
    );
  }
}
