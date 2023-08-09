import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:noteme/widgets/task_card.dart';
import 'package:noteme/widgets/task_card_skeleton.dart';

import '../constant/color_constant.dart';
import '../model/task_model.dart';

class CompletedTaskView extends StatefulWidget {
  CompletedTaskView({super.key});

  @override
  State<CompletedTaskView> createState() => _CompletedTaskViewState();
}

class _CompletedTaskViewState extends State<CompletedTaskView> {
  List<Task> task = [];
  bool onLongPress = false;

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
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('task')
            .where('isDone', isEqualTo: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return taskCardSkeleton();
          }

          // Proses data dari snapshot
          final document = snapshot.data!.docs;
          return ListView.builder(
            itemCount: document.length,
            itemBuilder: ((context, index) {
              final data = document[index].data() as Map<String, dynamic>;
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
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
                        color: Colors.white,
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
