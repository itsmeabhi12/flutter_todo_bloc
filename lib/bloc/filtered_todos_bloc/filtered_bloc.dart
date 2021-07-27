import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc_todo/bloc/filtered_todos_bloc/filtered_event.dart';
import 'package:flutter_bloc_todo/bloc/filtered_todos_bloc/filtered_state.dart';
import 'package:flutter_bloc_todo/bloc/todo_bloc/todo_bloc.dart';
import 'package:flutter_bloc_todo/bloc/todo_bloc/todo_state.dart';
import 'package:flutter_bloc_todo/model/filter_model.dart';
import 'package:flutter_bloc_todo/model/todo_model.dart';

class FilteredTodo extends Bloc<Filteredevents, FilteredState> {
  final TodoBloc todoBloc;
  StreamSubscription? todosSubscription;
  FilteredTodo(this.todoBloc)
      : super(todoBloc.state is TodoLoaded
            ? FilteredTodoLoaded(
                todos: (todoBloc.state as TodoLoaded).todos,
                activeFilter: VisibilityFilter.all)
            : FilteredTodoLoading()) {
    todosSubscription = todoBloc.stream.listen((event) {
      if (todoBloc.state is TodoLoaded) {
        add(TodosUpdated(todos: (todoBloc.state as TodoLoaded).todos));
      }
    });
  }

  @override
  Stream<FilteredState> mapEventToState(Filteredevents event) async* {
    if (event is FilteredUpdated) {
      yield* _mapFilteredUpdatedToState(event);
    } else if (event is TodosUpdated) {
      yield* _mapTodoUpdatedToState(event);
    }
  }

  @override
  Future<void> close() async {
    todosSubscription!.cancel();
    return super.close();
  }

  Stream<FilteredState> _mapFilteredUpdatedToState(
      Filteredevents event) async* {
    final updateevent = (event as FilteredUpdated);
    yield FilteredTodoLoaded(
        todos: _mapTodoToFilteredTodo(
            (todoBloc.state as TodoLoaded).todos, updateevent.visibilityFilter),
        activeFilter: updateevent.visibilityFilter);
  }

  Stream<FilteredState> _mapTodoUpdatedToState(TodosUpdated event) async* {
    final visibilityFilter = state is FilteredTodoLoaded
        ? (state as FilteredTodoLoaded).activeFilter
        : VisibilityFilter.all;
    yield FilteredTodoLoaded(
        todos: _mapTodoToFilteredTodo(
            (todoBloc.state as TodoLoaded).todos, visibilityFilter),
        activeFilter: visibilityFilter);
  }

  List<Todo> _mapTodoToFilteredTodo(
      List<Todo> todos, VisibilityFilter visibilityFilter) {
    return todos.where((element) {
      if (visibilityFilter == VisibilityFilter.active) {
        return !element.isCompleted;
      } else if (visibilityFilter == VisibilityFilter.completed) {
        return element.isCompleted;
      } else
        return true;
    }).toList();
  }
}
