import 'pace.dart';

enum Unit { miles, km }

class Run {
  final double distance;
  final Duration duration;
  final Pace pace;

  Run._(this.distance, this.duration, this.pace);

  factory Run(double distance, Unit distanceUnit, Pace pace) {
    if (distanceUnit == Unit.km) {
      return Run._(distance, _calculateDuration(distance, pace.minPerKm.inSeconds), pace);
    } else {
      return Run._(distance, _calculateDuration(distance, pace.minPerMile.inSeconds), pace);
    }
  }

  static Duration _calculateDuration(double distance, int paceInSeconds){
    final double paceInMinutes = paceInSeconds / 60;
    final double durationInMinutes = (distance * paceInMinutes);
    final int remainingSeconds = ((durationInMinutes - durationInMinutes.floor()) * 60).round();
    return Duration(minutes: durationInMinutes.floor(), seconds: remainingSeconds);
  }
}
