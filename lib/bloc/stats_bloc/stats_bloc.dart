import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_todo/bloc/stats_bloc/stats_event.dart';
import 'package:flutter_bloc_todo/bloc/stats_bloc/stats_state.dart';
import 'package:flutter_bloc_todo/bloc/todo_bloc/todo_bloc.dart';
import 'package:flutter_bloc_todo/bloc/todo_bloc/todo_state.dart';

class StatsBLoc extends Bloc<StatsEvent, StatsState> {
  final TodoBloc todoBloc;
  StreamSubscription? streamSubscription;
  StatsBLoc(this.todoBloc)
      : super(todoBloc.state is TodoLoaded
            ? StatsLoaded(
                active: (todoBloc.state as TodoLoaded)
                    .todos
                    .where((element) => !element.isCompleted)
                    .toList()
                    .length,
                completed: (todoBloc.state as TodoLoaded)
                    .todos
                    .where((element) => element.isCompleted)
                    .toList()
                    .length)
            : StatsLoading()) {
    streamSubscription = todoBloc.stream.listen((event) {
      add(ShowStats(todos: (todoBloc.state as TodoLoaded).todos));
    });
  }

  @override
  Stream<StatsState> mapEventToState(StatsEvent event) async* {
    if (event is ShowStats) {
      yield StatsLoaded(
          active: event.todos
              .where((element) => !element.isCompleted)
              .toList()
              .length,
          completed: event.todos
              .where((element) => element.isCompleted)
              .toList()
              .length);
    }
  }

  @override
  Future<void> close() {
    streamSubscription!.cancel();
    return super.close();
  }
}
