import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/notes_controller.dart';
import 'note_form_view.dart';

class NotesListView extends StatelessWidget {
  final NotesController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    controller.fetchNotes();

    return Scaffold(
      appBar: AppBar(title: Text('Notes')),
      body: Obx(() => controller.isLoading.value
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: controller.notesList.length,
              itemBuilder: (_, index) {
                final note = controller.notesList[index];
                return ListTile(
                  title: Text(note.title),
                  subtitle: Text(note.content),
                  onTap: () => Get.to(() => NoteFormView(note: note)),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => controller.deleteNote(note.id),
                  ),
                );
              },
            )),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => NoteFormView()),
        child: Icon(Icons.add),
      ),
    );
  }
}
