import 'package:get/get.dart';
import 'package:track_me/features/auth/views/login_view.dart';
import 'package:track_me/features/auth/views/register_view.dart';
import 'package:track_me/features/notes/views/note_detail_view.dart';
import 'package:track_me/features/notes/views/note_edit_view.dart';
import 'package:track_me/features/notes/views/notes_list_view.dart';
import '../bindings/initial_binding.dart';
import 'package:flutter/material.dart';


class AppPages {
  static final pages = [
    GetPage(name: '/', page: () => LoginView(), binding: InitialBinding()),
    GetPage(name: '/login', page: () => LoginView(), binding: InitialBinding()),
    GetPage(name: '/register', page: () => RegisterView(), binding: InitialBinding()),
    GetPage(name: '/notes', page: () => NotesListView(), binding: InitialBinding()),
    GetPage(name: '/notes/:id', page: () => NoteDetailView(), binding: InitialBinding()),
    GetPage(
      name: '/notes/:id/edit',
      page: () {
        final id = int.tryParse(Get.parameters['id'] ?? '');
        if (id != null) {
          return NoteEditView.edit(id);
        } else {
          return Scaffold(
            body: Center(child: Text('Invalid note ID')),
          );
        }
      },
      binding: InitialBinding(),
    ),

  ];
}
