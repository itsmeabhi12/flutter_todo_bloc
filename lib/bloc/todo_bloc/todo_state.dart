import 'package:flutter_bloc_todo/model/todo_model.dart';

abstract class TodosState {}

class TodoLoading extends TodosState {}

class TodoLoaded extends TodosState {
  final List<Todo> todos;
  TodoLoaded({this.todos = const []});
}

class TodoError extends TodosState {
  String message;
  TodoError({required this.message});
}
