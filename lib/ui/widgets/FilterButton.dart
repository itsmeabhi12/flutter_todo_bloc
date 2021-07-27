import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_todo/bloc/bloc.dart';
import 'package:flutter_bloc_todo/bloc/filtered_todos_bloc/filtered_state.dart';
import 'package:flutter_bloc_todo/model/filter_model.dart';

class FilterButton extends StatelessWidget {
  const FilterButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilteredTodo, FilteredState>(builder: (context, state) {
      return PopupMenuButton<VisibilityFilter>(
          icon: Icon(Icons.filter_list),
          onSelected: (filter) {
            BlocProvider.of<FilteredTodo>(context)
                .add(FilteredUpdated(visibilityFilter: filter));
          },
          itemBuilder: (context) {
            return <PopupMenuItem<VisibilityFilter>>[
              PopupMenuItem(
                  value: VisibilityFilter.all,
                  enabled: (state as FilteredTodoLoaded).activeFilter !=
                      VisibilityFilter.all,
                  child: Text('All')),
              PopupMenuItem(
                  value: VisibilityFilter.active,
                  enabled: (state as FilteredTodoLoaded).activeFilter !=
                      VisibilityFilter.active,
                  child: Text('Active')),
              PopupMenuItem(
                  value: VisibilityFilter.completed,
                  enabled: (state as FilteredTodoLoaded).activeFilter !=
                      VisibilityFilter.completed,
                  child: Text('Completed'))
            ];
          });
    });
  }
}
