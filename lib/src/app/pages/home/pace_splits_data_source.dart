import 'package:flutter/material.dart';
import 'package:pace_calculator/src/domain/entities/constants.dart';
import 'package:pace_calculator/src/domain/entities/pace.dart';
import 'package:pace_calculator/src/domain/entities/run.dart';
import 'package:pace_calculator/src/duration_helpers.dart';

class PaceSplitsDataSource extends DataTableSource {
  Pace pace;
  List<Run> runs;

  PaceSplitsDataSource(Pace pace){
    this.pace = pace;
    _initRuns(pace);
  }

  _initRuns(Pace pace) {
    this.runs = SupportedDistancesInMetres.map( (supportedDistance) => Run(supportedDistance.toDouble() / oneKmInMetres, Unit.km, pace)).toList();
  }

  @override
  DataRow getRow(int index) {
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text(this.runs[index].distance.toString())),
        DataCell(Text(DurationHelpers.getReadableString(this.runs[index].duration))),
      ],
    );;
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => runs.length;

  @override
  int get selectedRowCount => 0;

}