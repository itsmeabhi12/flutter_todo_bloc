import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_todo/bloc/todo_bloc/todo_events.dart';
import 'package:flutter_bloc_todo/bloc/todo_bloc/todo_state.dart';
import 'package:flutter_bloc_todo/model/todo_model.dart';
import 'package:todos_repository_simple/todos_repository_simple.dart';

class TodoBloc extends Bloc<TodosEvent, TodosState> {
  TodoBloc({required this.todosRepository}) : super(TodoLoading());

  final TodosRepositoryFlutter todosRepository;

  Future _saveTodos(List<Todo> todos) {
    return todosRepository.saveTodos(
      todos.map((todo) => todo.toEntity()).toList(),
    );
  }

  @override
  Stream<TodosState> mapEventToState(TodosEvent event) async* {
    if (event is TodosLoaded) {
      yield* _mapTodoLoadedToState();
    } else if (event is TodoAdded) {
      yield* _mapTodoAddedToState(event.todo);
    } else if (event is TodoUpdated) {
      yield* _mapTodoUpdatedToState(event.todo);
    } else if (event is TodoDeleted) {
      yield* _mapTodoDeletedToState(event.todo);
    } else if (event is ClearCompleted) {
      yield* _mapTodoClearCompletedtoState();
    } else if (event is ToggleAll) {
      yield* _mapToggleAlltoState(); //yeild* is used to call stream function
    }
  }

  Stream<TodosState> _mapTodoLoadedToState() async* {
    try {
      final todosenity = await this.todosRepository.loadTodos();
      final todos = todosenity
          .map((todosentity) => Todo.fromEntity(todosentity))
          .toList();
      yield TodoLoaded(todos: todos);
    } catch (e) {
      yield TodoError(message: e.toString());
    }
  }

  Stream<TodosState> _mapTodoAddedToState(Todo todo) async* {
    if (state is TodoLoaded) {
      final List<Todo> updatedtodos = (state as TodoLoaded).todos..add(todo);
      yield TodoLoaded(todos: updatedtodos);
      _saveTodos(updatedtodos);
    }
  }

  Stream<TodosState> _mapTodoUpdatedToState(Todo updatedtodo) async* {
    if (state is TodoLoaded) {
      final List<Todo> updatedtodos = (state as TodoLoaded)
          .todos
          .map((todo) => todo.id == updatedtodo.id ? updatedtodo : todo)
          .toList();

      yield TodoLoaded(todos: updatedtodos);
      _saveTodos(updatedtodos);
    }
  }

  Stream<TodosState> _mapTodoDeletedToState(Todo todo) async* {
    if (state is TodoLoaded) {
      final List<Todo> updatedtodos = (state as TodoLoaded)
          .todos
          .where((element) => element.id == todo.id ? false : true)
          .toList();
      yield TodoLoaded(todos: updatedtodos);
      _saveTodos(updatedtodos);
    }
  }

  Stream<TodosState> _mapTodoClearCompletedtoState() async* {
    if (state is TodoLoaded) {
      final List<Todo> updatedtodos = (state as TodoLoaded)
          .todos
          .where((element) => element.isCompleted ? false : true)
          .toList();
      yield TodoLoaded(todos: updatedtodos);
      _saveTodos(updatedtodos);
    }
  }

  Stream<TodosState> _mapToggleAlltoState() async* {
    if (state is TodoLoaded) {
      final List<Todo> updatedtodos = (state as TodoLoaded)
          .todos
          .map((e) => e.copyWith(isCompleted: true))
          .toList();
      yield TodoLoaded(todos: updatedtodos);
      _saveTodos(updatedtodos);
    }
  }
}
