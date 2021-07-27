import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_todo/bloc/bloc.dart';

class Stats extends StatelessWidget {
  const Stats({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatsBLoc, StatsState>(builder: (context, state) {
      if (state is StatsLoading) {
        return Center(child: CircularProgressIndicator());
      }
      return SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Active :"),
            Text((state as StatsLoaded).active.toString()),
            Text("Completed :"),
            Text(state.completed.toString())
          ],
        ),
      ));
    });
  }
}
