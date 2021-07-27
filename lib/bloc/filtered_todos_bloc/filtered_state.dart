import 'package:flutter_bloc_todo/model/filter_model.dart';
import 'package:flutter_bloc_todo/model/todo_model.dart';

abstract class FilteredState {}

class FilteredTodoLoading extends FilteredState {}

class FilteredTodoLoaded extends FilteredState {
  final VisibilityFilter activeFilter;
  final List<Todo> todos;
  FilteredTodoLoaded(
      {this.todos = const [], this.activeFilter = VisibilityFilter.all});
}
