class Task {
<<<<<<< HEAD
  final int id;
  final String title;
  final String todoText;
  final String time;
  final String category;
  final bool isDone;
  final String userId;
  final DateTime createdAt;
  final DateTime updatedAt;
=======
  String? id;
  String? title;
  String? todoText;
  String? time;
  String? category;
  bool? isDone;
>>>>>>> 75d05f9b86c7e77e973131dbd695befd4b9b6428

  Task({
    required this.id,
    required this.title,
    required this.todoText,
    required this.time,
    required this.category,
    required this.isDone,
<<<<<<< HEAD
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      title: json['title'],
      todoText: json['todoText'],
      time: json['time'],
      category: json['category'],
      isDone: json['isDone'],
      userId: json['userId'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
=======
  });
>>>>>>> 75d05f9b86c7e77e973131dbd695befd4b9b6428
}
