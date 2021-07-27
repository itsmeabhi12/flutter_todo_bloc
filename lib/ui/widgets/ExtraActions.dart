import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_todo/bloc/todo_bloc/todos.dart';
import 'package:flutter_bloc_todo/model/todo_model.dart';

enum ExtraAction { toggleAllComplete, clearCompleted }

class ExtraActions extends StatelessWidget {
  const ExtraActions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<ExtraAction>(onSelected: (val) {
      if (val == ExtraAction.clearCompleted) {
        BlocProvider.of<TodoBloc>(context).add(ClearCompleted());
      } else {
        BlocProvider.of<TodoBloc>(context).add(ToggleAll());
      }
    }, itemBuilder: (context) {
      return [
        PopupMenuItem(
            value: ExtraAction.clearCompleted, child: Text('ClearCompleted')),
        PopupMenuItem(
            value: ExtraAction.toggleAllComplete,
            child: Text('Markall Completed'))
      ];
    });
  }
}
