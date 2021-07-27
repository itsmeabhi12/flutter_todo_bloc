import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_todo/bloc/todo_bloc/todos.dart';
import 'package:flutter_bloc_todo/ui/screens/addedit_screen.dart';

class DetailsScreen extends StatelessWidget {
  final String id;
  const DetailsScreen({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoBloc, TodosState>(
      builder: (context, state) {
        final todo = (state as TodoLoaded)
            .todos
            .firstWhere((element) => element.id == id);

        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                  onPressed: () {
                    BlocProvider.of<TodoBloc>(context).add(TodoDeleted(todo));
                    Navigator.pop(context, todo);
                  },
                  icon: Icon(Icons.delete))
            ],
          ),
          body: ListView(
            children: [
              Row(
                children: [
                  Checkbox(
                    value: todo.isCompleted,
                    onChanged: (value) {
                      BlocProvider.of<TodoBloc>(context)
                          .add(TodoUpdated(todo.copyWith(isCompleted: value)));
                    },
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        todo.title,
                        textScaleFactor: 1.4,
                      ),
                      Text(todo.note)
                    ],
                  )
                ],
              )
            ],
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.edit),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => AddEditPage(
                      isEditing: true,
                      todo: todo,
                      onSave: (title, note) {
                        BlocProvider.of<TodoBloc>(context).add(TodoUpdated(
                            todo.copyWith(title: title, note: note)));
                      })));
            },
          ),
        );
      },
    );
  }
}
