import 'package:flutter/material.dart';

class NoteModel {
  final int id;
  final int user;
  final String title;
  final String content;
  final DateTime createdAt;
  final List<String>? days; // e.g., ["Mon", "Wed", "Fri"]
  final TimeOfDay? time; // Scheduled time
  final String? priority;

  NoteModel({
    required this.id,
    required this.user,
    required this.title,
    required this.content,
    required this.createdAt,
    this.days,
    this.time,
    required this.priority,
  });

  factory NoteModel.fromJson(Map<String, dynamic> json) => NoteModel(
    id: json['id'],
    user: json['user'],
    title: json['title'],
    content: json['content'],
    createdAt: DateTime.parse(json['created_at']),
    days: json['days'] != null ? List<String>.from(json['days']) : null,
    time: json['time'] != null
        ? TimeOfDay(
        hour: int.parse(json['time'].split(":")[0]),
        minute: int.parse(json['time'].split(":")[1]))
        : null,
    priority: json['priority'],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "content": content,
    "days": days,
    "time": time != null ? "${time!.hour.toString().padLeft(2,'0')}:${time!.minute.toString().padLeft(2,'0')}" : null,
    "priority": priority,
  };
}
