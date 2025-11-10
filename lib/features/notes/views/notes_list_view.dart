import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:track_me/features/notes/views/note_edit_view.dart';
import '../controllers/notes_controller.dart';
import '../models/note_model.dart';

class NotesListView extends StatelessWidget {
  final controller = Get.find<NotesController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
        actions: [
          IconButton(icon: Icon(Icons.refresh), onPressed: controller.loadNotes),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) return Center(child: CircularProgressIndicator());
        if (controller.notes.isEmpty) return Center(child: Text('No notes yet'));
        return ListView.builder(
          itemCount: controller.notes.length,
          itemBuilder: (_, i) {
            final NoteModel n = controller.notes[i];
            return ListTile(
              title: Text(n.title),
              subtitle: Text(n.content, maxLines: 1, overflow: TextOverflow.ellipsis),
              onTap: () => Get.toNamed('/notes/${n.id}'),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () => controller.deleteNote(n.id),
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => NoteEditView.create()),
        child: Icon(Icons.add),
      ),
    );
  }
}
