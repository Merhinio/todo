class Todo {
  String title;
  DateTime creationDate; 
  DateTime? finishDate; 
  bool isDone;

  Todo({
    required this.title,
    required this.creationDate,
   this.finishDate,
    this.isDone = false,
  });

}