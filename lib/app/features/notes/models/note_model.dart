import 'package:flutter/material.dart';

class NoteModel {
  final int id;
  final int user;
  final String title;
  final String content;
  final DateTime createdAt;
  final DateTime? date; // new
  final TimeOfDay? time;
  final String? priority;

  NoteModel({
    required this.id,
    required this.user,
    required this.title,
    required this.content,
    required this.createdAt,
    this.date,
    this.time,
    required this.priority,
  });

  factory NoteModel.fromJson(Map<String, dynamic> json) => NoteModel(
    id: json['id'],
    user: json['user'],
    title: json['title'],
    content: json['content'],
    createdAt: DateTime.parse(json['created_at']),
    date: json['date'] != null ? DateTime.parse(json['date']) : null,
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
    "date": date != null ? date!.toIso8601String().split('T')[0] : null,
    "time": time != null
        ? "${time!.hour.toString().padLeft(2, '0')}:${time!.minute.toString().padLeft(2, '0')}"
        : null,
    "priority": priority,
  };

  // Helper: get day of week string
  String get dayOfWeek {
    if (date == null) return '';
    const weekDays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return weekDays[date!.weekday - 1];
  }
}

