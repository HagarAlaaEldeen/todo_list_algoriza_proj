import 'package:flutter/material.dart';
import 'package:todo_list_algoriza/controllers/task_controller.dart';
import 'package:todo_list_algoriza/models/task.dart';
import 'package:todo_list_algoriza/widgets/input_field.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

class AddTask extends StatefulWidget {
  const AddTask({Key? key}) : super(key: key);

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  final TaskController taskController = Get.put(TaskController());

  DateTime selectedDate = DateTime.now();
  String startTime = DateFormat('hh:mm a').format(DateTime.now()).toString();
  String endTime = "11:00 PM";

  String selectedReminder = "1 day before";
  List<String> reminderList = [
    "1 day before",
    "1 hour before",
    "30 minutes before",
    "10 minutes before"
  ];

  String selectedRepeat = "None";
  List<String> repeatList = ["None", "Daily", "weakly", "Monthly"];

  int selectedTaskColor = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        elevation: 0.0,
        title: const Text(
          'Add Task',
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Add New Task",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black45),
              ),
              TaskInputField(
                  title: "Title",
                  hint: "Enter your title..",
                  controller: titleController),
              TaskInputField(
                  title: "Note",
                  hint: "Enter your note..",
                  controller: noteController),
              TaskInputField(
                title: "Date",
                hint: DateFormat.yMd().format(selectedDate),
                widget: IconButton(
                  onPressed: () {
                    getUserDateTime();
                  },
                  icon: const Icon(Icons.calendar_today_outlined),
                  color: Colors.grey,
                ),
              ),
              Row(
                children: [
                  Expanded(
                      child: TaskInputField(
                    title: "Start Time",
                    hint: startTime,
                    widget: IconButton(
                      onPressed: () {
                        getUserTime(isStartTime: true);
                      },
                      icon: const Icon(Icons.access_time),
                      color: Colors.grey,
                    ),
                  )),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                      child: TaskInputField(
                    title: "End Time",
                    hint: endTime,
                    widget: IconButton(
                      onPressed: () {
                        getUserTime(isStartTime: false);
                      },
                      icon: const Icon(Icons.access_time),
                      color: Colors.grey,
                    ),
                  )),
                ],
              ),
              TaskInputField(
                  title: "Remind",
                  hint: "$selectedReminder ",
                  widget: DropdownButton(
                    items: reminderList
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? selectedValue) {
                      setState(() {
                        selectedReminder = selectedValue!;
                      });
                    },
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.grey,
                    ),
                    iconSize: 28,
                    underline: Container(
                      height: 0,
                    ),
                  )),
              TaskInputField(
                  title: "Repeat",
                  hint: "$selectedRepeat ",
                  widget: DropdownButton(
                    items: repeatList
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: const TextStyle(color: Colors.grey),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? selectedValue) {
                      setState(() {
                        selectedRepeat = selectedValue!;
                      });
                    },
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.grey,
                    ),
                    iconSize: 28,
                    underline: Container(
                      height: 0,
                    ),
                  )),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(
                    child: Text(
                      "Task Color",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Wrap(
                      children: List<Widget>.generate(5, (int colorIndex) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedTaskColor = colorIndex;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: CircleAvatar(
                              radius: 13,
                              backgroundColor: colorIndex == 0
                                  ? Colors.yellow
                                  : colorIndex == 1
                                      ? Colors.purple
                                      : colorIndex == 2
                                          ? Colors.green
                                          : colorIndex == 3
                                              ? Colors.pink
                                              : Colors.blue,
                              child: selectedTaskColor == colorIndex
                                  ? const Icon(
                                      Icons.done,
                                      color: Colors.white,
                                      size: 13,
                                    )
                                  : Container(),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 7,
              ),
              Container(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    validTaskData();
                  },
                  child: const Text(
                    "create task",
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
      ),
    );
  }

  getUserDateTime() async {
    DateTime? pickerDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime(2030));

    if (pickerDate != null) {
      setState(() {
        selectedDate = pickerDate;
      });
    } else {
      print("something is wrong");
    }
  }

  getUserTime({required bool isStartTime}) async {
    var pickedTime = await showUserTimePicker();
    String formattedPickedTime = pickedTime.format(context);

    if (pickedTime == null) {
      print("time canceled");
    } else if (isStartTime == true) {
      setState(() {
        startTime = formattedPickedTime;
      });
    } else if (isStartTime == true) {
      setState(() {
        endTime = formattedPickedTime;
      });
    }
  }

  showUserTimePicker() {
    return showTimePicker(
      context: context,
      initialEntryMode: TimePickerEntryMode.input,
      initialTime: TimeOfDay(
          hour: int.parse(startTime.split(":")[0]),
          minute: int.parse(startTime.split(":")[1].split("")[0])),
    );
  }

  validTaskData() {
    if (titleController.text.isNotEmpty && noteController.text.isNotEmpty) {
      addTaskToDB();
      Get.back();
    } else if (titleController.text.isNotEmpty ||
        noteController.text.isNotEmpty) {
      return const SnackBar(
        content: Text(
          "All fields are required",
        ),
        backgroundColor: Colors.white,
      );
    }
  }

  addTaskToDB() async {
    await taskController.addTask(
        task: Task(
      title: titleController.text,
      note: noteController.text,
      date: DateFormat.yMd().format(selectedDate),
      startTime: startTime,
      endTime: endTime,
      remind: selectedReminder,
      repeat: selectedRepeat,
      color: selectedTaskColor,
      isCompleted: 0,
    ));
  }
}
