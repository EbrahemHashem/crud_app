import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_app/services/firestore.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // text controller
  final TextEditingController textController = TextEditingController();
  // firestore
  final FirestoreService firestoreService = FirestoreService();
// open dialog box
  void openNoteBox({String? docId}) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: TextField(
                controller: textController,
              ),
              actions: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  onPressed: () {
                    if (docId == null) {
                      firestoreService.addNote(textController.text);
                    }
                    // update existing note
                    else {
                      firestoreService.updateNote(docId, textController.text);
                    }

                    //       // clear text controller
                    textController.clear();
                    // close the dialog
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Add',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: openNoteBox,
        child: const Icon(Icons.add),
      ),
      backgroundColor: const Color.fromARGB(255, 146, 214, 245),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue,
        title: const Center(
            child: Text(
          'Notes',
          style: TextStyle(
            fontSize: 32,
            color: Colors.white,
          ),
        )),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: firestoreService.getNotesStream(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List notesList = snapshot.data!.docs;
              // display as a list
              return ListView.builder(
                itemCount: notesList.length,
                itemBuilder: (context, index) {
                  // get each individual doc
                  DocumentSnapshot document = notesList[index];
                  String docId = document.id;

                  // get note from each doc
                  Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                  String noteText = data['note'];

                  // display a a list tile
                  return ListTile(
                    title: Text(noteText),
                    trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                      // update note
                      IconButton(
                        onPressed: () => openNoteBox(docId: docId),
                        icon: const Icon(Icons.settings),
                      ),
                      // delete note
                      IconButton(
                        onPressed: () => firestoreService.deleteNote(docId),
                        icon: const Icon(Icons.delete),
                      ),
                    ]),
                  );
                },
              );
            } else {
              return const Text('No notes ..');
            }
          }),
    );
  }
}
