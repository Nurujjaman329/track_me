import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/note_controller.dart';
import '../controllers/notes_controller.dart';

class NoteEditView extends StatefulWidget {
  final bool isCreate;
  final int? noteId;
  const NoteEditView._({this.isCreate = false, this.noteId});

  factory NoteEditView.create() => NoteEditView._(isCreate: true);

  factory NoteEditView.edit(int id) => NoteEditView._(isCreate: false, noteId: id);

  @override
  _NoteEditViewState createState() => _NoteEditViewState();
}

class _NoteEditViewState extends State<NoteEditView> {
  final titleC = TextEditingController();
  final contentC = TextEditingController();
  late final noteController = Get.put(NoteController(service: Get.find()));
  final notesController = Get.find<NotesController>();

  @override
  void initState() {
    super.initState();
    if (!widget.isCreate && widget.noteId != null) {
      noteController.loadNoteById(widget.noteId!);
      ever(noteController.note, (_) {
        final n = noteController.note.value;
        if (n != null) {
          titleC.text = n.title;
          contentC.text = n.content;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.isCreate ? 'Create Note' : 'Edit Note')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [
          TextField(controller: titleC, decoration: InputDecoration(labelText: 'Title')),
          TextField(controller: contentC, decoration: InputDecoration(labelText: 'Content'), maxLines: 6),
          const SizedBox(height: 16),
          Obx(() {
            final loading = noteController.isLoading.value;
            return ElevatedButton(
              onPressed: loading ? null : () {
                final title = titleC.text.trim();
                final content = contentC.text.trim();
                if (widget.isCreate) {
                  notesController.createNote(title, content);
                } else {
                  noteController.updateNoteById(widget.noteId!, title, content);
                }
              },
              child: loading ? CircularProgressIndicator() : Text(widget.isCreate ? 'Create' : 'Update'),
            );
          })
        ]),
      ),
    );
  }
}
