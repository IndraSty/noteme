import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:noteme/model/notes_model.dart';
import 'package:noteme/screens/bot_navbar.dart';

import '../constant/color_constant.dart';
import '../constant/screen_size.dart';

class AddNewNotes extends StatefulWidget {
  const AddNewNotes({super.key});

  @override
  State<AddNewNotes> createState() => _AddNewNotesState();
}

class _AddNewNotesState extends State<AddNewNotes> {
  final notes = Notes.noteList();
  final notesDeskription = TextEditingController();
  final titleController = TextEditingController();
  @override
  Widget build(BuildContext context) {
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
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: width,
              child: TextField(
                controller: titleController,
                decoration: InputDecoration(
                  hintText: 'Notes Title',
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
              height: 5,
            ),
            Text(
              DateFormat('MMM dd hh:mm').format(DateTime.now()),
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: fontColor,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            SizedBox(
              width: width,
              child: TextField(
                controller: notesDeskription,
                decoration: InputDecoration(
                  hintText: 'Write your needs & thoughs',
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
          ]),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: GestureDetector(
            onTap: () {
              addNotesItem(
                titleController.text.trim(),
                notesDeskription.text.trim(),
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
                'Create Notes',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              )),
            ),
          ),
        ));
  }

  void addNotesItem(String title, String note) async {
    try {
      final CollectionReference notesCollection =
          FirebaseFirestore.instance.collection('notes');

      await notesCollection.add({
        'id': DateTime.now().microsecondsSinceEpoch.toString(),
        'title': title,
        'notesText': note,
      });

      titleController.clear();
      notesDeskription.clear();
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const BottomNavbarScreen(selectedIndex: 2),
      ));
    } catch (e) {
      print('Error adding note: $e');
    }
  }
}
