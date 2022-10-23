import 'package:flutter/material.dart';
import 'package:notesappfrontend/models/note.dart';
import 'package:notesappfrontend/pages/add_note_page.dart';
import 'package:notesappfrontend/provider/note_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    NoteProvider noteProvider = Provider.of<NoteProvider>(context);

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Notes App'),
        ),
        body: !noteProvider.isLoading
            ? noteProvider.notesList.isEmpty
                ? Center(
                    child: Text('no notes added yet'),
                  )
                : SafeArea(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      itemCount: noteProvider.notesList.length,
                      itemBuilder: (BuildContext context, int index) {
                        Note currentNote = noteProvider.notesList[index];
                        return GestureDetector(
                          onTap: () {
                            // we will update the selected note.
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AddNotePage(
                                    forUpdate: true,
                                    currentNote: currentNote,
                                  ),
                                ));
                          },
                          onLongPress: () {
                            noteProvider.deleteNote(currentNote);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            margin: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border:
                                    Border.all(width: 1, color: Colors.grey)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  noteProvider.notesList[index].title!,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 7,
                                ),
                                Text(
                                  noteProvider.notesList[index].content!,
                                  maxLines: 5,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Colors.grey.withOpacity(0.8)),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  )
            : Center(child: CircularProgressIndicator()),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return AddNotePage(
                forUpdate: false,
              );
            }));
          },
          child: const Icon(Icons.add),
        ));
  }
}
