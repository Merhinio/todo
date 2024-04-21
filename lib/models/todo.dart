class Todo {
  String title;
  DateTime creationDate;
  bool isDone;
  DateTime? finishDate; // Hier hinzugefügt

  Todo({required this.title, required this.creationDate, this.isDone = false, this.finishDate});

  Map<String, dynamic> toJson() => {
    'title': title,
    'creationDate': creationDate.toIso8601String(),
    'isDone': isDone,
    'finishDate': finishDate?.toIso8601String(), // Hier hinzugefügt
  };

  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
    title: json['title'],
    creationDate: DateTime.parse(json['creationDate']),
    isDone: json['isDone'],
    finishDate: json['finishDate'] != null ? DateTime.parse(json['finishDate']) : null, // Hier hinzugefügt
  );
}