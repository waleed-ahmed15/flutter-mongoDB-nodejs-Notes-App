import 'package:flutter/cupertino.dart';
import 'package:notesappfrontend/api%20services/api_services.dart';
import 'package:notesappfrontend/models/note.dart';

class NoteProvider with ChangeNotifier {
  List<Note> notesList = [];
  bool isLoading = true;
  NoteProvider() {
    fetchNotes();
  }

  sortNotes() {
    notesList.sort(
      (a, b) => b.dateAdded!.compareTo(a.dateAdded!),
    );
  }

  // noew make 3 methoods for add update and delete note
  // add note
  void addNote(Note note) {
    notesList.add(note);
    sortNotes();
    notifyListeners();
    ApiService.addNote(note);
  }

  void updateNote(Note note) {
    int noteIndex = notesList
        .indexOf(notesList.firstWhere((element) => element.id == note.id));
    notesList[noteIndex] = note;
    sortNotes();
    notifyListeners();
    ApiService.addNote(note);
  }

  deleteNote(Note note) {
    int indexofNote = notesList
        .indexOf(notesList.firstWhere((element) => element.id == note.id));
    notesList.removeAt(indexofNote);
    sortNotes();
    notifyListeners();
    ApiService.deleteNote(note);
  }

  fetchNotes() async {
    notesList = await ApiService.fetchNotes('waleedahmed');
    isLoading = false;
    sortNotes();
    notifyListeners();
  }
}
