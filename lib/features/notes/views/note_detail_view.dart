import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/note_controller.dart';
import '../models/note_model.dart';

class NoteDetailView extends StatelessWidget {
  final noteController = Get.put(NoteController(service: Get.find()));
  int get id => int.parse(Get.parameters['id'] ?? '0');

  @override
  Widget build(BuildContext context) {
    noteController.loadNoteById(id);
    return Scaffold(
      appBar: AppBar(
        title: Text('Note'),
        actions: [
          IconButton(icon: Icon(Icons.edit), onPressed: () => Get.toNamed('/notes/$id/edit')),
        ],
      ),
      body: Obx(() {
        if (noteController.isLoading.value) return Center(child: CircularProgressIndicator());
        final note = noteController.note.value;
        if (note == null) return Center(child: Text('Note not found'));
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(note.title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text(note.content),
            Spacer(),
            Text('Created: ${note.createdAt.toLocal()}'),
          ]),
        );
      }),
    );
  }
}
