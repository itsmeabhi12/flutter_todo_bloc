import 'package:flutter_bloc_todo/model/filter_model.dart';
import 'package:flutter_bloc_todo/model/todo_model.dart';

abstract class Filteredevents {}

class FilteredUpdated extends Filteredevents {
  final VisibilityFilter visibilityFilter;
  FilteredUpdated({this.visibilityFilter = VisibilityFilter.all});
}

class TodosUpdated extends Filteredevents {
  final List<Todo> todos;
  TodosUpdated({required this.todos});
}
