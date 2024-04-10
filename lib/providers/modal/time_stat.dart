enum StatsType { TimeSpent, PlannedVsActual, Satisfaction }

class TimeStat {
  final String category;
  List<TimeStat> subCategory = [];
  double duration;

  TimeStat({required this.category, this.duration = 0});
}
