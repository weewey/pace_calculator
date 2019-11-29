import 'package:pace_calculator/src/domain/entities/pace.dart';
import 'package:pace_calculator/src/domain/entities/run.dart';
import 'package:test/test.dart';

void main(){
  group("Run Factory", (){
    final fiveMinPerKmPace = Pace(Duration(minutes: 5), PaceUnit.minPerKm);
    final fiveMinPerMilePace = Pace(Duration(minutes: 5), PaceUnit.minPerMile);
    var distance = 12.0;

    test("initialize Run with distance in Km and Pace in minPerKm",(){
      final run = Run(distance, Unit.km, fiveMinPerKmPace);
      expect(run.duration, Duration(hours: 1));
    });

    test("initialize Run with distance in Miles and Pace in minPerMile", (){
      final run = Run(distance, Unit.miles, fiveMinPerMilePace);
      expect(run.duration, Duration(hours: 1));
    });

    test("when the distance is 0.4km and pace is 5:00, calculates the right duration", (){
      distance = 0.4;
      final run = Run(distance, Unit.km, fiveMinPerKmPace);
      expect(run.duration, Duration(minutes: 2, seconds: 0));
    });

    test("when the distance is 0.4km and pace is 3:45, calculates the right duration", (){
      distance = 0.4;
      final run = Run(distance, Unit.km, Pace(Duration(minutes: 3, seconds: 45), PaceUnit.minPerKm));
      expect(run.duration, Duration(minutes: 1, seconds: 30));
    });




  });
}