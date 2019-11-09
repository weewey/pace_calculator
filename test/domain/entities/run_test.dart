import 'package:pace_calculator/src/domain/entities/pace.dart';
import 'package:pace_calculator/src/domain/entities/run.dart';
import 'package:test/test.dart';

void main(){
  group("Run Factory", (){
    final fiveMinPerKmPace = Pace(Duration(minutes: 5), PaceUnit.minPerKm);
    final fiveMinPerMilePace = Pace(Duration(minutes: 5), PaceUnit.minPerMile);
    final distance = 12.0;

    test("initialize Run with distance in Km and Pace in minPerKm",(){
      final run = Run(distance, Unit.km, fiveMinPerKmPace, PaceUnit.minPerKm);
      expect(run.duration, Duration(hours: 1));
      expect(run.unit, Unit.km);
    });

    test("initialize Run with distance in Miles and Pace in minPerMile", (){
      final run = Run(distance, Unit.miles, fiveMinPerMilePace, PaceUnit.minPerMile);
      expect(run.duration, Duration(hours: 1));
      expect(run.unit, Unit.miles);
    });

  });
}