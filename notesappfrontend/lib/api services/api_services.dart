import 'dart:convert';
import 'dart:developer';

import 'package:notesappfrontend/models/note.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static String baseURL = 'https://intense-journey-08811.herokuapp.com/notes';

  //adding note method.
  static Future<void> addNote(Note note) async {
    Uri requestURi = Uri.parse('${baseURL}/add');
    var response = await http.post(requestURi, body: note.toJson());
    var decodedResponse = jsonDecode(response.body);
    log(decodedResponse.toString());
  }

  static Future<void> deleteNote(Note note) async {
    Uri requestURi = Uri.parse('${baseURL}/delete');
    var response = await http.post(requestURi, body: note.toJson());
    var decodedResponse = jsonDecode(response.body);
    log(decodedResponse.toString());
  }

  static Future<List<Note>> fetchNotes(String userId) async {
    Uri requestURi = Uri.parse('${baseURL}/list');
    var response = await http.post(requestURi, body: {"userid": userId});
    var decodedResponse = jsonDecode(response.body);

    List<Note> notes = [];
    for (var element in decodedResponse) {
      Note currnote = Note.fromJson(element);
      notes.add(currnote);
    }
    // log(decodedResponse.toString());
    log(notes.toString());
    return notes;
  }
}
