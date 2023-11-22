import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:noteme/constant/screen_size.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import '../constant/color_constant.dart';
import '../constant/generate_id.dart';
import 'bot_navbar.dart';

class AddNewTask extends StatefulWidget {
  const AddNewTask({super.key});

  @override
  State<AddNewTask> createState() => _AddNewTaskState();
}

class _AddNewTaskState extends State<AddNewTask> {
  final _controller = ValueNotifier<bool>(false);
  bool isSwitched = false;
  bool isTapped = false;
  bool isTimeAdded = false;
  bool isDateAdded = false;
  bool isDone = false;
  final titleController = TextEditingController();
  final taskController = TextEditingController();
  final dateController = TextEditingController();
  final timeController = TextEditingController();

  TimeOfDay timeOfDay = const TimeOfDay(
    hour: 0,
    minute: 0,
  );
  DateTime date = DateTime.now();
  String category = 'Personal';

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        if (_controller.value) {
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

  void addTaskItem(String title, String task, String time, String date) async {
    final id = await generateDocumentId();
    try {
      final data = {
        'id': DateTime.now().microsecondsSinceEpoch.toString(),
        'title': title,
        'todoText': task,
        'isDone': isDone,
        'time': time,
        'date': date,
        'category': category,
      };

      await FirebaseFirestore.instance.collection('task').doc(id).set(data);

      titleController.clear();
      taskController.clear();
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const BottomNavbarScreen(selectedIndex: 1),
      ));
    } catch (e) {
      print('Error adding note: $e');
    }
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
                  controller: taskController,
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
                padding: EdgeInsets.only(left: isDateAdded ? 15 : 0),
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
                padding: EdgeInsets.only(left: isTimeAdded ? 15 : 0),
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
                    controller: _controller,
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
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    GestureDetector(
                      child: CategoryBox(
                        color: isTapped ? Colors.grey : boxColor,
                        textColor: isTapped ? Colors.white : fontColor,
                        ringColor: primaryColor,
                        text: 'Personal',
                      ),
                    ),
                    GestureDetector(
                      child: CategoryBox(
                        color: isTapped ? Colors.grey : boxColor,
                        textColor: isTapped ? Colors.white : fontColor,
                        ringColor: Colors.greenAccent,
                        text: 'Official',
                      ),
                    ),
                    GestureDetector(
                      child: CategoryBox(
                        color: isTapped ? Colors.grey : boxColor,
                        textColor: isTapped ? Colors.white : fontColor,
                        ringColor: Colors.redAccent,
                        text: 'Spiritual',
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.28,
              ),
              GestureDetector(
                onTap: () {
                  addTaskItem(
                    titleController.text.trim(),
                    taskController.text.trim(),
                    timeOfDay.format(context).toString(),
                    formattedDate,
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

class CategoryBox extends StatelessWidget {
  const CategoryBox({
    super.key,
    required this.color,
    required this.textColor,
    required this.text,
    required this.ringColor,
  });
  final Color color;
  final Color textColor;
  final String text;
  final Color ringColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Container(
        height: 50,
        width: 130,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: color,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 17,
              width: 17,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: ringColor, width: 4),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              text,
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: textColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
