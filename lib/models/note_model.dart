class Note {
  String title;
  String content;

  Note({
    required this.title,
    required this.content,
  });

  factory Note.fromJson(Map<String, dynamic> json) => Note(
        title: json['title'],
        content: json['content'],
      );

  Map<String, dynamic> toJson() => {
        'title': title,
        'content': content,
      };
}
