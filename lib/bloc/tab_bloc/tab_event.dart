import 'package:flutter_bloc_todo/model/tab_model.dart';

abstract class TabEvent {}

class TabUpdated extends TabEvent {
  MyTab tab;
  TabUpdated({required this.tab});
}
