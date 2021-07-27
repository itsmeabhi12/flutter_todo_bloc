import 'package:flutter_bloc_todo/model/todo_model.dart';

abstract class StatsEvent {}

class ShowStats extends StatsEvent {
  final List<Todo> todos;
  ShowStats({this.todos = const []});
}
