class NoteModel {
  final int id;
  final int user;
  final String title;
  final String content;
  final DateTime createdAt;

  NoteModel({
    required this.id,
    required this.user,
    required this.title,
    required this.content,
    required this.createdAt,
  });

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      id: json['id'],
      user: json['user'],
      title: json['title'],
      content: json['content'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'content': content,
      };
}
