import 'package:flutter/material.dart';
import 'package:flutterapi/features/nea_api/domain/entity/nea_api_entity.dart';

class MyTableDataSource extends DataTableSource {
  final List<AttendanceRecord> attendanceRecords;
  MyTableDataSource(this.attendanceRecords);

  @override
  DataRow? getRow(int index) {
    if (index >= attendanceRecords.length) {
      return null;
    }
    final attendanceRecord = attendanceRecords[index];
    return DataRow(
      cells: [
        DataCell(Text(attendanceRecord.attendanceDateNepali)),
        DataCell(Text(attendanceRecord.inTime ?? '')),
        DataCell(Text(attendanceRecord.outTime ?? '')),
        DataCell(Text(attendanceRecord.status)),
      ],
    );
  }

  @override
  int get rowCount => attendanceRecords.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}
