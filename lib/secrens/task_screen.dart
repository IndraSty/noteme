import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../components/color_style.dart';
import '../components/screen_size.dart';
import '../service/task_service.dart';
import '../widgets/add_task.dart';
import '../widgets/task_card.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  bool onLongPress = false;
  TaskService client = TaskService();

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      length: 2,
      vsync: this,
    );
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: width * 0.7,
                height: 45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: boxColor,
                ),
                child: Center(
                  child: TextField(
                    // onChanged: (value) => runFilter(value),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.search_sharp,
                        size: 22,
                        color: Colors.grey,
                      ),
                      border: InputBorder.none,
                      hintText: 'Search..',
                      hintStyle: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: fontColor,
                    ),
                  ),
                ),
              ),
              onLongPress
                  ? GestureDetector(
                      onTap: () {
                        setState(() {
                          onLongPress = !onLongPress;
                        });
                      },
                      child: Text(
                        'Cancel',
                        style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: primaryColor,
                            fontWeight: FontWeight.w600),
                      ),
                    )
                  : GestureDetector(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const AddTask(),
                      )),
                      child: Text(
                        'New',
                        style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: primaryColor,
                            fontWeight: FontWeight.w600),
                      ),
                    )
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TabBar(
              controller: tabController,
              unselectedLabelColor: const Color(0xff6D6D6D),
              indicator: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 2,
                    color: primaryColor,
                  ),
                ),
                shape: BoxShape.rectangle,
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              labelColor: primaryColor,
              labelStyle: GoogleFonts.poppins(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
              tabs: const [
                Tab(
                  text: 'All',
                ),
                Tab(
                  text: 'Completed',
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TabBarView(
                controller: tabController,
                children: [
                  allTaskView(),
                  completeTaskView(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // void runFilter(String keyword) {
  //   List<Task> results = [];
  //   if (keyword.isEmpty) {
  //     results = todoList;
  //   } else {
  //     results = todoList
  //         .where((item) =>
  //             item.title!.toLowerCase().contains(keyword.toLowerCase()))
  //         .toList();
  //   }

  //   setState(() {
  //     foundTodo = results;
  //   });
  // }

  Widget allTaskView() {
    return FutureBuilder(
      future: client.getTask(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var task = snapshot.data!;

          return ListView.builder(
            itemCount: task.length,
            itemBuilder: (context, index) {
              var taskId = task[index]['id'];
              return InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/detailTask',
                      arguments: taskId);
                },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: TaskCard(
                    time: task[index]['time'],
                    title: task[index]['title'],
                    todoText: task[index]['todoText'],
                    category: task[index]['category'],
                    isDone: task[index]['isDone'],
                    onLongPress: onLongPress,
                    widget: Container(),
                  ),
                ),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }

        // By default, show a loading spinner.
        return const CircularProgressIndicator();
      },
    );
  }

  Widget completeTaskView() {
    return Container();
  }
}
