import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:track_me/app/core/utils/app_colors.dart';
import '../controllers/notes_controller.dart';
import '../models/note_model.dart';

class NoteFormView extends StatefulWidget {
  final NoteModel? note;

  const NoteFormView({super.key, this.note});


  @override
  State<NoteFormView> createState() => _NoteFormViewState();
}

class _NoteFormViewState extends State<NoteFormView> {
  final NotesController controller = Get.find();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final List<String> priorities = ['Urgent', 'Medium', 'Basic'];
  RxString selectedPriority = 'Basic'.obs;

  final List<String> weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  RxList<String> selectedDays = <String>[].obs;
  TimeOfDay? selectedTime;

  // 1️⃣ Add this at the top of your state
  DateTime? selectedDate; // replaces selectedDays
  final List<String> weekDays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

  @override
  void initState() {
    super.initState();
    if (widget.note != null) {
      selectedPriority.value = widget.note!.priority ?? 'Basic';
      titleController.text = widget.note!.title;
      contentController.text = widget.note!.content;
      selectedDate = widget.note!.date;
      selectedTime = widget.note!.time;
    }
  }


  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.background,
      appBar: AppBar(
        title: Text(
          widget.note == null ? 'Create New Note' : 'Edit Note',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isDark ? AppColors.darkText : AppColors.text,
          ),
        ),
        backgroundColor: isDark ? AppColors.darkSurface : AppColors.surface,
        elevation: 0,
        actions: [
          if (widget.note != null)
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
              _buildHeaderSection(isDark),
              const SizedBox(height: 32),
              _buildFormFields(isDark),
              const SizedBox(height: 16),
              _buildPrioritySelector(isDark),
              const SizedBox(height: 16),

              // New: Days selection
              _buildDatePicker(isDark),
              const SizedBox(height: 16),

              // New: Time picker
              _buildTimePicker(isDark),
              const SizedBox(height: 32),

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
                  widget.note == null ? 'Create New Note' : 'Editing Note',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isDark ? AppColors.darkText : AppColors.text,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  widget.note == null
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
            TextFormField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Note Title',
                prefixIcon: Icon(Icons.title, color: isDark ? AppColors.darkTextLight : AppColors.textLight),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: AppColors.primary, width: 2),
                ),
              ),
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: isDark ? AppColors.darkText : AppColors.text,
              ),
              validator: (value) => value == null || value.isEmpty ? 'Please enter a title' : null,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: TextFormField(
                controller: contentController,
                maxLines: null,
                expands: true,
                textAlignVertical: TextAlignVertical.top,
                decoration: InputDecoration(
                  labelText: 'Note Content',
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: AppColors.primary, width: 2),
                  ),
                ),
                style: TextStyle(fontSize: 14, color: isDark ? AppColors.darkText : AppColors.text),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDatePicker(bool isDark) {
    return Row(
      children: [
        const Icon(Icons.calendar_today),
        const SizedBox(width: 16),
        TextButton(
          onPressed: () async {
            final picked = await showDatePicker(
              context: context,
              initialDate: selectedDate ?? DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
            );
            if (picked != null) {
              setState(() {
                selectedDate = picked;
              });
            }
          },
          child: Text(
            selectedDate != null
                ? "${selectedDate!.year}-${selectedDate!.month.toString().padLeft(2, '0')}-${selectedDate!.day.toString().padLeft(2, '0')} (${weekDays[selectedDate!.weekday - 1]})"
                : 'Select Date',
            style: TextStyle(color: isDark ? AppColors.darkText : AppColors.text),
          ),
        ),
      ],
    );
  }


  // ---------------- Time picker ----------------
  Widget _buildTimePicker(bool isDark) {
    return Row(
      children: [
        const Icon(Icons.access_time),
        const SizedBox(width: 16),
        TextButton(
          onPressed: () async {
            final picked = await showTimePicker(
              context: Get.context!,
              initialTime: selectedTime ?? TimeOfDay.now(),
            );
            if (picked != null) selectedTime = picked;
          },
          child: Text(
            selectedTime != null
                ? "${selectedTime!.hour.toString().padLeft(2, '0')}:${selectedTime!.minute.toString().padLeft(2, '0')}"
                : 'Select Time (Optional)',
            style: TextStyle(color: isDark ? AppColors.darkText : AppColors.text),
          ),
        )
      ],
    );
  }

  // ---------------- Action Button ----------------
  Widget _buildActionButton(bool isDark) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: () {
          if (_formKey.currentState?.validate() ?? false) {
            final n = NoteModel(
              id: widget.note?.id ?? 0,
              user: widget.note?.user ?? 0,
              title: titleController.text,
              content: contentController.text,
              createdAt: widget.note?.createdAt ?? DateTime.now(),
              date: selectedDate,
              time: selectedTime,
              priority: selectedPriority.value,
            );
            if (widget.note == null) {
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
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          shadowColor: AppColors.primary.withOpacity(0.3),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(widget.note == null ? Icons.add : Icons.save, size: 20),
            const SizedBox(width: 8),
            Text(
              widget.note == null ? 'Create Note' : 'Update Note',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPrioritySelector(bool isDark) {
    return Obx(() => Row(
      children: priorities.map((p) {
        final isSelected = selectedPriority.value == p;
        return Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: ChoiceChip(
            label: Text(p),
            selected: isSelected,
            onSelected: (_) => selectedPriority.value = p,
            selectedColor: AppColors.primary,
            backgroundColor: isDark ? AppColors.darkSurface : AppColors.surface,
            labelStyle: TextStyle(
              color: isSelected ? Colors.white : (isDark ? AppColors.darkText : AppColors.text),
            ),
          ),
        );
      }).toList(),
    ));
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Note', style: TextStyle(color: AppColors.text, fontWeight: FontWeight.bold)),
        content: Text('Are you sure you want to delete this note? This action cannot be undone.',
            style: TextStyle(color: AppColors.textLight)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        actions: [
          TextButton(onPressed: () => Get.back(), child: Text('Cancel', style: TextStyle(color: AppColors.textLight))),
          ElevatedButton(
            onPressed: () {
              Get.back();
              controller.deleteNote(widget.note!.id);
              Get.back();
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.error, foregroundColor: Colors.white),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
