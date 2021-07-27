import 'package:flutter/material.dart'
    show SnackBar, SnackBarAction, Text, VoidCallback;
import 'package:flutter_bloc_todo/model/todo_model.dart';

class DeleteTodoSnackBar extends SnackBar {
  DeleteTodoSnackBar({required Todo todo, required VoidCallback onUndo})
      : super(
          content: Text(todo.title),
          duration: Duration(seconds: 2),
          action: SnackBarAction(
            label: "Undo",
            onPressed: onUndo,
          ),
        );
}
