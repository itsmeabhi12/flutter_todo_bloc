import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_todo/bloc/bloc.dart';
import 'package:flutter_bloc_todo/ui/screens/details_screen.dart';
import 'package:flutter_bloc_todo/ui/widgets/DeleteTodoSnackbar.dart';
import 'package:flutter_bloc_todo/ui/widgets/todo_item.dart';

class FilteredTodos extends StatelessWidget {
  const FilteredTodos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilteredTodo, FilteredState>(builder: (context, state) {
      if (state is FilteredTodoLoading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      return ListView.builder(
          itemCount: (state as FilteredTodoLoaded).todos.length,
          itemBuilder: (context, index) {
            return TodoItem(
                onDismissed: (_) {
                  BlocProvider.of<TodoBloc>(context)
                      .add(TodoDeleted(state.todos[index]));
                  ScaffoldMessenger.of(context).showSnackBar(DeleteTodoSnackBar(
                    todo: state.todos[index],
                    onUndo: () {
                      BlocProvider.of<TodoBloc>(context)
                          .add(TodoAdded(state.todos[index]));
                    },
                  ));
                },
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          DetailsScreen(id: state.todos[index].id)));
                },
                onCheckboxChanged: (val) {
                  BlocProvider.of<TodoBloc>(context).add(TodoUpdated(state
                      .todos[index]
                      .copyWith(isCompleted: !state.todos[index].isCompleted)));
                },
                todo: state.todos[index]);
          });
    });
  }
}
