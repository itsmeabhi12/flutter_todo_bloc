//@dart=2.9

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_todo/model/tab_model.dart';
import 'package:flutter_bloc_todo/simple_bloc_observer.dart';
import 'package:flutter_bloc_todo/ui/screens/home_screens.dart';
import 'package:todos_repository_simple/todos_repository_simple.dart';
import 'package:path_provider/path_provider.dart';

import 'bloc/bloc.dart';

void main() {
  // Bloc.observer = SimpleBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(BlocProvider(
      create: (context) {
        return TodoBloc(
          todosRepository: const TodosRepositoryFlutter(
            fileStorage: const FileStorage(
              '__flutter_bloc_app__',
              getApplicationDocumentsDirectory,
            ),
          ),
        )..add(TodosLoaded());
      },
      child: TodosApp()));
}

class TodosApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiBlocProvider(providers: [
        BlocProvider<TabBloc>(
          create: (context) => TabBloc(TabLoaded(tab: MyTab.todo)),
        ),
        BlocProvider<FilteredTodo>(
          create: (context) => FilteredTodo(
            BlocProvider.of<TodoBloc>(context),
          ),
        ),
        BlocProvider<StatsBLoc>(
          create: (context) => StatsBLoc(
            BlocProvider.of<TodoBloc>(context),
          ),
        )
      ], child: HomePage()),
    );
  }
}
