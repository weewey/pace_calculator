import 'package:pace_calculator/src/domain/entities/pace.dart';
import 'package:scoped_model/scoped_model.dart';

class HomeViewModel extends Model {
  String _minutes;
  String _seconds;
  PaceUnit paceUnit = PaceUnit.minPerKm;
  Pace _pace;

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
    notifyListeners();
    return _pace;
  }

  String displaySplits(){
    if (_pace != null){
      return _pace.kmPerHr.toString();
    } else {
      return "testing";
    }
  }
}
