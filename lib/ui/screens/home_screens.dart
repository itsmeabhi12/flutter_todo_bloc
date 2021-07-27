import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_todo/bloc/bloc.dart';
import 'package:flutter_bloc_todo/bloc/tab_bloc/tab.dart';
import 'package:flutter_bloc_todo/model/tab_model.dart';
import 'package:flutter_bloc_todo/model/todo_model.dart';
import 'package:flutter_bloc_todo/ui/screens/addedit_screen.dart';
import 'package:flutter_bloc_todo/ui/widgets/ExtraActions.dart';
import 'package:flutter_bloc_todo/ui/widgets/FilterButton.dart';
import 'package:flutter_bloc_todo/ui/widgets/FilteredTodos.dart';
import 'package:flutter_bloc_todo/ui/widgets/stats.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabBloc, TabState>(builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          title: Text('ToDo App '),
          actions: [FilterButton(), ExtraActions()],
        ),
        body:
            (state as TabLoaded).tab == MyTab.todo ? FilteredTodos() : Stats(),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => AddEditPage(
                          isEditing: false,
                          todo: null,
                          onSave: (title, note) {
                            BlocProvider.of<TodoBloc>(context)
                                .add(TodoAdded(Todo(title: title, note: note)));
                          },
                        )));
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: (state as TabLoaded).tab == MyTab.todo ? 0 : 1,
          onTap: (index) {
            if (index == 0) {
              BlocProvider.of<TabBloc>(context)
                  .add(TabUpdated(tab: MyTab.todo));
            } else {
              BlocProvider.of<TabBloc>(context)
                  .add(TabUpdated(tab: MyTab.stats));
            }
          },
          items: [
            BottomNavigationBarItem(label: 'Todo', icon: Icon(Icons.cases)),
            BottomNavigationBarItem(
                label: 'stats', icon: Icon(Icons.query_stats))
          ],
        ),
      );
    });
  }
}
