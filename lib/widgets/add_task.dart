import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:noteme/service/task_service.dart';

import '../components/color_style.dart';
import '../components/screen_size.dart';
import 'category_box.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  TaskService client = TaskService();

  final controller = ValueNotifier<bool>(false);
  bool isSwitched = false;
  bool isTapped = false;
  bool isTimeAdded = false;
  bool isDateAdded = false;
  bool isDone = false;
  String activeCategory = '';
  final titleController = TextEditingController();
  final todoController = TextEditingController();
  final dateController = TextEditingController();
  final timeController = TextEditingController();

  TimeOfDay timeOfDay = const TimeOfDay(
    hour: 0,
    minute: 0,
  );
  DateTime date = DateTime.now();

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      setState(() {
        if (controller.value) {
          isSwitched = true;
        } else {
          isSwitched = false;
        }
      });
    });
  }

  void timePicker() {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((value) {
      setState(() {
        if (value != null) {
          timeOfDay = value;
          isTimeAdded = true;
        }
      });
    });
  }

  void datePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2060),
    ).then((value) {
      setState(() {
        if (value != null) {
          date = value;
          isDateAdded = true;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('yyyy-MM-dd').format(date);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Task',
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: fontColor,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 50,
                width: width,
                child: TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                    hintText: 'Task Title',
                    hintStyle: GoogleFonts.poppins(
                      fontSize: 26,
                      fontWeight: FontWeight.w600,
                      color: fontColor,
                    ),
                    border: InputBorder.none,
                  ),
                  style: GoogleFonts.poppins(
                    fontSize: 26,
                    fontWeight: FontWeight.w600,
                    color: fontColor,
                  ),
                  keyboardType: TextInputType.text,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 80,
                width: width,
                child: TextField(
                  controller: todoController,
                  decoration: InputDecoration(
                    hintText: 'Type the task description here...',
                    hintStyle: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: fontColor,
                    ),
                    border: InputBorder.none,
                  ),
                  maxLines: null,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: fontColor,
                  ),
                  keyboardType: TextInputType.multiline,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                'Date',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: fontColor,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                height: 40,
                width: width,
                padding: EdgeInsets.only(left: isDateAdded ? 10 : 0),
                decoration: BoxDecoration(
                  color: boxColor,
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Center(
                  child: TextField(
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                    onTap: datePicker,
                    controller: dateController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: isDateAdded
                          ? null
                          : IconButton(
                              onPressed: datePicker,
                              icon: const Icon(
                                Icons.calendar_month_outlined,
                                color: Colors.grey,
                                size: 22,
                              ),
                            ),
                      suffixIcon: isDateAdded
                          ? IconButton(
                              onPressed: datePicker,
                              icon: const Icon(
                                Icons.calendar_month_outlined,
                                color: Colors.grey,
                                size: 22,
                              ),
                            )
                          : null,
                      hintStyle: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                      ),
                      hintText: isDateAdded ? formattedDate : '',
                    ),
                    readOnly: true,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Time',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: fontColor,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                height: 40,
                width: width,
                padding: EdgeInsets.only(left: isTimeAdded ? 10 : 0),
                decoration: BoxDecoration(
                  color: boxColor,
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Center(
                  child: TextField(
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                    onTap: timePicker,
                    controller: timeController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: isTimeAdded
                          ? null
                          : IconButton(
                              onPressed: timePicker,
                              icon: const Icon(
                                Icons.watch_later_outlined,
                                color: Colors.grey,
                                size: 22,
                              ),
                            ),
                      suffixIcon: isTimeAdded
                          ? IconButton(
                              onPressed: timePicker,
                              icon: const Icon(
                                Icons.watch_later_outlined,
                                color: Colors.grey,
                                size: 22,
                              ),
                            )
                          : null,
                      hintStyle: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                      ),
                      hintText: isTimeAdded
                          ? timeOfDay.format(context).toString()
                          : '',
                    ),
                    readOnly: true,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Remind Me',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: fontColor,
                    ),
                  ),
                  AdvancedSwitch(
                    controller: controller,
                    activeColor: primaryColor,
                    height: 20,
                    width: 37,
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Select Category',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: fontColor,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    child: CategoryBox(
                      color: activeCategory == 'Personal'
                          ? primaryColor
                          : boxColor,
                      textColor: activeCategory == 'Personal'
                          ? Colors.white
                          : Colors.black,
                      ringColor: activeCategory == 'Personal'
                          ? Colors.white
                          : primaryColor,
                      text: 'Personal',
                      isActive: activeCategory == 'Personal',
                      onTap: () {
                        setState(() {
                          activeCategory = 'Personal';
                        });
                      },
                    ),
                  ),
                  GestureDetector(
                    child: CategoryBox(
                      color: activeCategory == 'Official'
                          ? primaryColor
                          : boxColor,
                      textColor: activeCategory == 'Official'
                          ? Colors.white
                          : Colors.black,
                      ringColor: activeCategory == 'Official'
                          ? Colors.white
                          : Colors.green,
                      text: 'Official',
                      isActive: activeCategory == 'Official',
                      onTap: () {
                        setState(() {
                          activeCategory = 'Official';
                        });
                      },
                    ),
                  ),
                  GestureDetector(
                    child: CategoryBox(
                      color: activeCategory == 'Spiritual'
                          ? primaryColor
                          : boxColor,
                      textColor: activeCategory == 'Spiritual'
                          ? Colors.white
                          : Colors.black,
                      ringColor: activeCategory == 'Spiritual'
                          ? Colors.white
                          : Colors.redAccent,
                      text: 'Spiritual',
                      isActive: activeCategory == 'Spiritual',
                      onTap: () {
                        setState(() {
                          activeCategory = 'Spiritual';
                        });
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.28,
              ),
              GestureDetector(
                onTap: () {
                  print(timeOfDay.format(context).toString());
                  print(activeCategory);
                  print(titleController.text);
                  print(todoController.text);
                  client.addTask(
                    context,
                    titleController.text.trim(),
                    todoController.text.trim(),
                    timeOfDay.format(context).toString(),
                    activeCategory,
                  );
                },
                child: Container(
                  width: width,
                  height: 50,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                      child: Text(
                    'Create Task',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
