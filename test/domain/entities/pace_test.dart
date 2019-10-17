import 'package:pace_calculator/src/domain/entities/pace.dart';
import 'package:test/test.dart';

void main(){
  group("Factory", (){
    final minPerKm = Duration(minutes: 5, seconds: 0);
    final minPerMile = Duration(minutes: 8, seconds: 03);
    final double kmPerHour = 12;
    final milesPerHour = 7.5;

    test("initializing from minPerKm",(){
      final pace = Pace(minPerKm, PaceUnit.minPerKm);
      expect(pace.minPerKm, minPerKm);
      expect(pace.minPerMile, minPerMile);
      expect(pace.kmPerHr, kmPerHour);
      expect(pace.milesPerHr, 7.453416149068323);
    });

    test("initializing from milePerMin",(){
      final pace = Pace(minPerMile, PaceUnit.minPerMile);
      expect(pace.minPerKm, minPerKm);
      expect(pace.minPerMile, minPerMile);
      expect(pace.kmPerHr, kmPerHour);
      expect(pace.milesPerHr, 7.453416149068323);
    });

    test("initializing from kmPerHour",(){
      final pace = Pace(kmPerHour, PaceUnit.kmPerHour);
      expect(pace.minPerKm, minPerKm);
      expect(pace.minPerMile, minPerMile);
      expect(pace.kmPerHr, kmPerHour);
      expect(pace.milesPerHr, 7.453416149068323);
    });

    test("initializing from milePerHour",(){
      final pace = Pace(milesPerHour, PaceUnit.milePerHour);
      expect(pace.minPerKm, Duration(minutes: 4, seconds: 58));
      expect(pace.minPerMile, Duration(minutes: 8));
      expect(pace.kmPerHr, 12.080536912751677);
      expect(pace.milesPerHr, milesPerHour);
    });
  });
}