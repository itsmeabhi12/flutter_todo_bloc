abstract class StatsState {}

class StatsLoading extends StatsState {}

class StatsLoaded extends StatsState {
  int active;
  int completed;
  StatsLoaded({required this.active, required this.completed});
}
