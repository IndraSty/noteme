import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:noteme/constant/color_constant.dart';
import 'package:noteme/constant/screen_size.dart';
import 'package:noteme/screens/add_new_task.dart';
import 'package:noteme/widgets/task_card_skeleton.dart';

import '../model/task_model.dart';
import '../widgets/completed_taskk_view.dart';
import '../widgets/task_card.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  List<Task> task = [];
  bool onLongPress = false;

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

  Future<void> deleteTaskItem(String? docId) async {
    try {
      final CollectionReference notesCollection =
          FirebaseFirestore.instance.collection('task');

      await notesCollection.doc(docId).delete();
    } catch (e) {
      print('Error deleting note: $e');
    }
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
                        builder: (context) => const AddNewTask(),
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
                  CompletedTaskView(),
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
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('task').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return taskCardSkeleton();
          }

          // Proses data dari snapshot
          final document = snapshot.data!.docs;
          task = document
              .map((doc) => Task(
                    id: doc.id,
                    title: doc['title'],
                    todoText: doc['todoText'],
                    category: doc['category'],
                    time: doc['time'],
                    isDone: doc['isDone'],
                  ))
              .toList();
          return ListView.builder(
            itemCount: document.length,
            itemBuilder: ((context, index) {
              final data = document[index].data() as Map<String, dynamic>;
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: GestureDetector(
                  onDoubleTap: () {
                    setState(() {
                      final taskReference = FirebaseFirestore.instance
                          .collection('task')
                          .doc(task[index].id);
                      taskReference.update({'isDone': !data['isDone']});
                    });
                  },
                  child: GestureDetector(
                    onLongPress: () {
                      setState(() {
                        onLongPress = !onLongPress;
                      });
                    },
                    child: TaskCard(
                      time: data['time'],
                      title: data['title'],
                      todoText: data['todoText'],
                      category: data['category'],
                      isDone: data['isDone'],
                      onLongPress: onLongPress,
                      widget: IconButton(
                        onPressed: () => deleteTaskItem(task[index].id),
                        icon: const Icon(
                          Icons.delete,
                          size: 20,
                          color: Colors.redAccent,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
          );
        });
  }
}
