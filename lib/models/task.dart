class Task {
  final String id;
  String title;
  bool completed;

  Task({
    required this.id,
    required this.title,
    this.completed = false,
  });

  void toggle() {
    completed = !completed;
  }

  Task copyWith({String? title, bool? completed}) {
    return Task(
      id: id,
      title: title ?? this.title,
      completed: completed ?? this.completed,
    );
  }
}
