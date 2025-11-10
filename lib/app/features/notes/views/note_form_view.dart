import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/notes_controller.dart';
import '../models/note_model.dart';

class NoteFormView extends StatelessWidget {
  final NotesController controller = Get.find();
  final NoteModel? note;

  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  NoteFormView({super.key, this.note}) {
    if (note != null) {
      titleController.text = note!.title;
      contentController.text = note!.content;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(note == null ? 'New Note' : 'Edit Note')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: titleController, decoration: const InputDecoration(labelText: 'Title')),
            TextField(controller: contentController, decoration: const InputDecoration(labelText: 'Content')),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final n = NoteModel(
                  id: note?.id ?? 0,
                  user: note?.user ?? 0,
                  title: titleController.text,
                  content: contentController.text,
                  createdAt: note?.createdAt ?? DateTime.now(),
                );
                if (note == null) {
                  controller.addNote(n);
                } else {
                  controller.updateNote(n);
                }
              },
              child: Text(note == null ? 'Create' : 'Update'),
            ),
          ],
        ),
      ),
    );
  }
}
