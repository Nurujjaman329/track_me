import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:track_me/app/core/storage/token_storage.dart';
import 'package:track_me/app/routes/app_routes.dart';
import '../controllers/notes_controller.dart';
import 'note_form_view.dart';

class NotesListView extends StatefulWidget {

  const NotesListView({super.key});

  @override
  State<NotesListView> createState() => _NotesListViewState();
}

class _NotesListViewState extends State<NotesListView> {
  final NotesController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    controller.fetchNotes();

    return Scaffold(
      appBar: AppBar(title: Text('Notes'),
         actions: [IconButton(onPressed: (){
           logout();
         }, icon: Icon(Icons.logout))],
      ),
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


  Future<void> logout() async {
    await TokenStorage.clear();

    /// Navigate to login and re-bind auth dependencies
    Get.offAllNamed(AppRoutes.login);
  }
}
