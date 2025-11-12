import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:track_me/app/core/utils/app_colors.dart';
import '../controllers/notes_controller.dart';
import '../models/note_model.dart';

class NoteFormView extends StatelessWidget {
  final NotesController controller = Get.find();
  final NoteModel? note;

  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  NoteFormView({super.key, this.note}) {
    if (note != null) {
      titleController.text = note!.title;
      contentController.text = note!.content;
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.background,
      appBar: AppBar(
        title: Text(
          note == null ? 'Create New Note' : 'Edit Note',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isDark ? AppColors.darkText : AppColors.text,
          ),
        ),
        backgroundColor: isDark ? AppColors.darkSurface : AppColors.surface,
        elevation: 0,
        actions: [
          if (note != null)
            IconButton(
              onPressed: () => _showDeleteDialog(context),
              icon: Icon(
                Icons.delete_outline,
                color: AppColors.error,
              ),
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Header Section
              _buildHeaderSection(isDark),
              const SizedBox(height: 32),

              // Form Fields
              _buildFormFields(isDark),
              const SizedBox(height: 32),

              // Action Button
              _buildActionButton(isDark),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderSection(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
        border: Border.all(
          color: isDark ? AppColors.darkBorder : AppColors.border,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(
              Icons.note_alt_rounded,
              color: AppColors.primary,
              size: 30,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  note == null ? 'Create New Note' : 'Editing Note',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isDark ? AppColors.darkText : AppColors.text,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  note == null
                      ? 'Start writing your thoughts and ideas'
                      : 'Make changes to your existing note',
                  style: TextStyle(
                    fontSize: 14,
                    color: isDark ? AppColors.darkTextLight : AppColors.textLight,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormFields(bool isDark) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkSurface : AppColors.surface,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
          border: Border.all(
            color: isDark ? AppColors.darkBorder : AppColors.border,
            width: 1,
          ),
        ),
        child: Column(
          children: [
            // Title Field
            TextFormField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Note Title',
                labelStyle: TextStyle(
                  color: isDark ? AppColors.darkTextLight : AppColors.textLight,
                ),
                hintText: 'Enter a title for your note...',
                hintStyle: TextStyle(
                  color: isDark ? AppColors.darkTextLight : AppColors.textLight,
                ),
                prefixIcon: Icon(
                  Icons.title,
                  color: isDark ? AppColors.darkTextLight : AppColors.textLight,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: isDark ? AppColors.darkBorder : AppColors.border,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: AppColors.primary,
                    width: 2,
                  ),
                ),
                filled: true,
                fillColor: isDark ? AppColors.darkBackground.withOpacity(0.5) : AppColors.background,
              ),
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: isDark ? AppColors.darkText : AppColors.text,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a title for your note';
                }
                return null;
              },
            ),
            const SizedBox(height: 24),

            // Content Field
            Expanded(
              child: TextFormField(
                controller: contentController,
                maxLines: null,
                expands: true,
                textAlignVertical: TextAlignVertical.top,
                decoration: InputDecoration(
                  labelText: 'Note Content',
                  labelStyle: TextStyle(
                    color: isDark ? AppColors.darkTextLight : AppColors.textLight,
                  ),
                  hintText: 'Write your thoughts here...\n\nYou can write as much as you want!',
                  hintStyle: TextStyle(
                    color: isDark ? AppColors.darkTextLight : AppColors.textLight,
                  ),
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: isDark ? AppColors.darkBorder : AppColors.border,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: AppColors.primary,
                      width: 2,
                    ),
                  ),
                  filled: true,
                  fillColor: isDark ? AppColors.darkBackground.withOpacity(0.5) : AppColors.background,
                ),
                style: TextStyle(
                  fontSize: 14,
                  color: isDark ? AppColors.darkText : AppColors.text,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(bool isDark) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: () {
          if (_formKey.currentState?.validate() ?? false) {
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
            Get.back();
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          shadowColor: AppColors.primary.withOpacity(0.3),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              note == null ? Icons.add : Icons.save,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              note == null ? 'Create Note' : 'Update Note',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Delete Note',
          style: TextStyle(
            color: AppColors.text,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          'Are you sure you want to delete this note? This action cannot be undone.',
          style: TextStyle(
            color: AppColors.textLight,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'Cancel',
              style: TextStyle(color: AppColors.textLight),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back();
              controller.deleteNote(note!.id);
              Get.back();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
              foregroundColor: Colors.white,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
