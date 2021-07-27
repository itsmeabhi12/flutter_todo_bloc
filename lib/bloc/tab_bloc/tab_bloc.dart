import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_todo/bloc/tab_bloc/tab_event.dart';
import 'package:flutter_bloc_todo/bloc/tab_bloc/tab_state.dart';

class TabBloc extends Bloc<TabEvent, TabState> {
  TabBloc(TabState initialState) : super(initialState);

  @override
  Stream<TabState> mapEventToState(TabEvent event) async* {
    if (event is TabUpdated) {
      yield TabLoaded(tab: event.tab);
    }
  }
}
