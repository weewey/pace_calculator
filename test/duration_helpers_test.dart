import 'package:pace_calculator/src/duration_helpers.dart';
import 'package:test/test.dart';

void main(){
  group("DurationHelpers", (){

    test("#getReadableString with 5mins",(){
      final duration = Duration(minutes: 5, seconds: 0);
      final result = DurationHelpers.getReadableString(duration);
      expect(result, "5mins 0sec");
    });

    test("#getReadableString with 3mins30seconds",(){
      final duration = Duration(minutes: 3, seconds: 30);
      final result = DurationHelpers.getReadableString(duration);
      expect(result, "3mins 30sec");
    });

    test("#getReadableString with 4mins00seconds",(){
      final duration = Duration(minutes: 4, seconds: 00);
      final result = DurationHelpers.getReadableString(duration);
      expect(result, "4mins 0sec");
    });

    test("#getReadableString with 1hour4mins00seconds",(){
      final duration = Duration(hours: 1, minutes: 4, seconds: 40);
      final result = DurationHelpers.getReadableString(duration);
      expect(result, "1hour 4mins 40sec");
    });

    test("#getReadableString with 2hour50mins00seconds",(){
      final duration = Duration(hours: 2, minutes: 50, seconds: 40);
      final result = DurationHelpers.getReadableString(duration);
      expect(result, "2hour 50mins 40sec");
    });
  });
}