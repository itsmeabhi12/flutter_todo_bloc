import 'package:todos_app_core/todos_app_core.dart';
import 'package:todos_repository_core/todos_repository_core.dart';

class Todo {
  final String id;
  final String title;
  final String note;
  final isCompleted;

  Todo({
    required this.title,
    this.isCompleted = false,
    this.note = '',
    String? id,
  }) : this.id = id ?? Uuid().generateV4();

  Todo copyWith({String? title, String? note, bool? isCompleted, String? id}) {
    return Todo(
        title: title ?? this.title,
        isCompleted: isCompleted ?? this.isCompleted,
        note: note ?? this.note,
        id: id ?? this.id);
  }

  TodoEntity toEntity() {
    return TodoEntity(this.title, this.id, this.note, this.isCompleted);
  }

  static Todo fromEntity(TodoEntity entity) {
    return Todo(
      title: entity.task,
      isCompleted: entity.complete ?? false,
      note: entity.note,
      id: entity.id ?? Uuid().generateV4(),
    );
  }
}
