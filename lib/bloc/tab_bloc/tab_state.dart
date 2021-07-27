import 'package:flutter_bloc_todo/model/tab_model.dart';

abstract class TabState {}

class TabLoading extends TabState {}

class TabLoaded extends TabState {
  final MyTab tab;
  TabLoaded({required this.tab});
}
