import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:notesappfrontend/models/note.dart';
import 'package:notesappfrontend/provider/note_provider.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class AddNotePage extends StatefulWidget {
  bool forUpdate;
  Note? currentNote;
  AddNotePage({super.key, required this.forUpdate, this.currentNote});

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  FocusNode noteFocusNode = FocusNode();
  TextEditingController titleController = TextEditingController();
  TextEditingController noteController = TextEditingController();

// this method will both add and update the note.
  void addNote() {
    Note newNote = Note(
      id: Uuid().v1(),
      content: noteController.text,
      title: titleController.text,
      dateAdded: DateTime.now(),
      userId: 'waleedahmed',
    );
    NoteProvider noteProvider =
        Provider.of<NoteProvider>(context, listen: false);
    if (widget.forUpdate) {
      widget.currentNote!.title = titleController.text;
      widget.currentNote!.content = noteController.text;
      widget.currentNote!.dateAdded = DateTime.now();
      noteProvider.updateNote(widget.currentNote!);
    } else {
      noteProvider.addNote(newNote);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    titleController.text =
        widget.forUpdate ? widget.currentNote!.title.toString() : "";
    noteController.text =
        widget.forUpdate ? widget.currentNote!.content.toString() : "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              addNote();
              Navigator.pop(context);
            },
            icon: const Icon(Icons.check),
          ),
        ],
        centerTitle: true,
        title: const Text('Add Note'),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  noteFocusNode.requestFocus();
                }
              },
              autofocus: !widget.forUpdate,
              style: TextStyle(fontSize: 35),
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10),
                  hintText: 'Title',
                  hintStyle: TextStyle(fontSize: 30),
                  border: InputBorder.none),
            ),
            Expanded(
              child: TextField(
                controller: noteController,
                maxLines: null,
                focusNode: noteFocusNode,
                style: TextStyle(fontSize: 20),
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    hintText: 'Note',
                    hintStyle: TextStyle(fontSize: 30),
                    border: InputBorder.none),
              ),
            )
          ],
        ),
      )),
    );
  }
}
