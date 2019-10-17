import 'package:pace_calculator/src/domain/entities/constants.dart';

enum PaceUnit {
  minPerKm,
  minPerMile,
  kmPerHour,
  milePerHour,
}

class Pace {
  final Duration minPerKm;
  final Duration minPerMile;
  final double kmPerHr;
  final double milesPerHr;

  Pace._(this.minPerKm, this.minPerMile, this.kmPerHr, this.milesPerHr);

  factory Pace(dynamic pace, PaceUnit paceUnit) {
    switch (paceUnit) {
      case PaceUnit.minPerKm:
        return _initPaceFromMinPerKm(pace);
      case PaceUnit.minPerMile:
        return _initPaceFromMinPerMile(pace);
      case PaceUnit.kmPerHour:
        return _initPaceFromKmPerHour(pace);
      case PaceUnit.milePerHour:
        return _initPaceFromMilePerHour(pace);
      default:
        return Pace._(Duration(), Duration(), 0.0, 0.0);
    }
  }

  static Pace _initPaceFromMilePerHour(pace) {
    final minPerMile =
        Duration(minutes: (Duration(hours: 1).inMinutes / pace).round());
    return Pace._(
        _mileToKmPerMin(minPerMile),
        minPerMile,
        _perMinToPerHr(_mileToKmPerMin(minPerMile)),
        _perMinToPerHr(minPerMile));
  }

  static Pace _initPaceFromKmPerHour(pace) {
    final minPerKm =
        Duration(minutes: (Duration(hours: 1).inMinutes / pace).round());
    return Pace._(minPerKm, _kmToMilePerMin(minPerKm), _perMinToPerHr(minPerKm),
        _perMinToPerHr(_kmToMilePerMin(minPerKm)));
  }

  static Pace _initPaceFromMinPerMile(pace) {
    final minPerMile = pace as Duration;
    final minPerKm = _mileToKmPerMin(minPerMile);
    return Pace._(minPerKm, minPerMile, _perMinToPerHr(minPerKm),
        _perMinToPerHr(minPerMile));
  }

  static Pace _initPaceFromMinPerKm(pace) {
    final minPerKm = pace as Duration;
    final minPerMile = _kmToMilePerMin(minPerKm);
    return Pace._(minPerKm, minPerMile, _perMinToPerHr(minPerKm),
        _perMinToPerHr(minPerMile));
  }

  static Duration _kmToMilePerMin(Duration minPerKm) {
    final paceInSeconds = minPerKm.inSeconds * kmPerMiles;
    return Duration(seconds: paceInSeconds.round());
  }

  static Duration _mileToKmPerMin(Duration minPerMile) {
    final paceInSeconds = minPerMile.inSeconds / kmPerMiles;
    return Duration(seconds: paceInSeconds.round());
  }

  static double _perMinToPerHr(Duration speed) {
    return Duration(hours: 1).inSeconds / speed.inSeconds;
  }
}
