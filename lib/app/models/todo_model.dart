class TodoModel {
  final int? id;
  final String title;
  final bool isCompleted;

  TodoModel({
    this.id,
    required this.title,
    this.isCompleted = false,
  });

  TodoModel copyWith({int? id, String? title, bool? isCompleted}) {
    return TodoModel(
      id: id ?? this.id,
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  // Conversão para Map (usado no SQLite)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'isCompleted': isCompleted ? 1 : 0,
    };
  }

  // Conversão de Map para TodoModel
  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
      id: map['id'],
      title: map['title'],
      isCompleted: map['isCompleted'] == 1,
    );
  }
}
