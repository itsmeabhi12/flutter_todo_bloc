import 'package:flutter_bloc_todo/model/todo_model.dart';

abstract class TodosEvent {}

class TodosLoaded extends TodosEvent {}

class TodoAdded extends TodosEvent {
  final Todo todo;
  TodoAdded(this.todo);
}

class TodoUpdated extends TodosEvent {
  final Todo todo;
  TodoUpdated(this.todo);
}

class TodoDeleted extends TodosEvent {
  final Todo todo;
  TodoDeleted(this.todo);
}

class ClearCompleted extends TodosEvent {}

class ToggleAll extends TodosEvent {}
