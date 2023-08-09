import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:noteme/model/notes_model.dart';
import 'package:noteme/screens/add_new_notes.dart';

import '../constant/color_constant.dart';
import '../constant/screen_size.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  List<Notes> notes = [];
  bool isDeleteVisibility = false;
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
                width: isDeleteVisibility ? width * 0.7 : width * 0.81,
                height: 45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: boxColor,
                ),
                child: Center(
                  child: TextField(
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
              isDeleteVisibility
                  ? GestureDetector(
                      onTap: () {
                        setState(() {
                          isDeleteVisibility = !isDeleteVisibility;
                        });
                      },
                      child: Text(
                        'Cancel',
                        style: GoogleFonts.poppins(
                            fontSize: 10,
                            color: primaryColor,
                            fontWeight: FontWeight.w600),
                      ),
                    )
                  : SizedBox()
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('notes')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    // Proses data dari snapshot
                    final document = snapshot.data!.docs;
                    notes = document
                        .map((doc) => Notes(
                              id: doc.id,
                              title: doc['title'],
                              notesText: doc['notesText'],
                            ))
                        .toList();
                    return MasonryGridView.builder(
                      itemCount: document.length,
                      gridDelegate:
                          const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2),
                      itemBuilder: (context, index) {
                        final data =
                            document[index].data() as Map<String, dynamic>;
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 5),
                          child: GestureDetector(
                            onLongPress: () {
                              setState(() {
                                isDeleteVisibility = !isDeleteVisibility;
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 15),
                              decoration: BoxDecoration(
                                  color: boxColor,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data['title'],
                                    style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      color: fontColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    maxLines: 2,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    data['notesText'],
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      color: fontColor,
                                    ),
                                    maxLines: 10,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        DateFormat('MMM dd')
                                            .format(DateTime.now()),
                                        style: GoogleFonts.poppins(
                                          fontSize: 12,
                                          color: fontColor,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      isDeleteVisibility
                                          ? IconButton(
                                              onPressed: () => deleteNotesItem(
                                                  notes[index].id!),
                                              icon: const Icon(
                                                Icons.delete,
                                                color: Colors.redAccent,
                                                size: 20,
                                              ))
                                          : Container()
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }),
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
        height: 55,
        width: 55,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: primaryColor,
        ),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const AddNewNotes()));
          },
          shape: const CircleBorder(),
          elevation: 0.5,
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Future<void> deleteNotesItem(String docId) async {
    try {
      final CollectionReference notesCollection =
          FirebaseFirestore.instance.collection('notes');

      await notesCollection.doc(docId).delete();
    } catch (e) {
      print('Error deleting note: $e');
    }
  }
}
