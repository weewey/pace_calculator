import 'pace.dart';

enum Unit { miles, km }

class Run {
  final double distance;
  final Duration duration;
  final Pace pace;
  final Unit unit;

  Run._(this.distance, this.duration, this.pace, this.unit);

  factory Run(
      double distance, Unit distanceUnit, Pace pace, PaceUnit paceUnit) {
    if (distanceUnit == Unit.km && paceUnit == PaceUnit.minPerKm) {
      var durationInMinutes = (distance * pace.minPerKm.inMinutes).round();
      return Run._(
          distance, Duration(minutes: durationInMinutes), pace, Unit.km);
    }
    if (distanceUnit == Unit.miles && paceUnit == PaceUnit.minPerMile) {
      var durationInMinutes = (distance * pace.minPerMile.inMinutes).round();
      return Run._(
          distance, Duration(minutes: durationInMinutes), pace, Unit.miles);
    }
    return Run._(0.0, Duration(), Pace(Duration(minutes: 5), PaceUnit.minPerKm),
        Unit.km);
  }
}
