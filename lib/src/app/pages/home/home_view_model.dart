import 'package:pace_calculator/src/app/pages/home/pace_splits_data_source.dart';
import 'package:pace_calculator/src/domain/entities/pace.dart';
import 'package:scoped_model/scoped_model.dart';

class HomeViewModel extends Model {
  String _minutes;
  String _seconds;
  PaceUnit paceUnit = PaceUnit.minPerKm;
  Pace _pace;
  PaceSplitsDataSource paceSplitsDataSource;
  
  HomeViewModel(){
    paceSplitsDataSource = PaceSplitsDataSource(Pace(Duration(minutes: 5, seconds: 0), PaceUnit.minPerKm));
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
    paceSplitsDataSource = PaceSplitsDataSource(_pace);
    notifyListeners();
    return _pace;
  }
}
