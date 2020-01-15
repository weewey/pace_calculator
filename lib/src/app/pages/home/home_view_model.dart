import 'package:pace_calculator/src/domain/entities/constants.dart';
import 'package:pace_calculator/src/domain/entities/pace.dart';
import 'package:pace_calculator/src/domain/entities/run.dart';
import 'package:scoped_model/scoped_model.dart';

class HomeViewModel extends Model {
  String _minutes;
  String _seconds;
  PaceUnit paceUnit = PaceUnit.minPerKm;
  Pace _pace;
  List<Run> runs;

  HomeViewModel(){
    runs = SupportedDistancesInMetres.map((distance) {
      return Run(distance / 1000,  Unit.km, Pace(Duration(minutes: 5, seconds: 0), PaceUnit.minPerKm));
    }).toList();
  }

  void setMinutes(String minutes) {
    _minutes = minutes;
  }

  void setSeconds(String seconds) {
    _seconds = seconds;
  }

  Pace save() {
    _pace = Pace(
        Duration(minutes: int.parse(_minutes), seconds: int.parse(_seconds)),
        paceUnit);
    runs = SupportedDistancesInMetres.map((distance) => Run(distance / 1000,  Unit.km, _pace)).toList();
    notifyListeners();
    return _pace;
  }
}
