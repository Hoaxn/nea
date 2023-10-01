import 'package:flutterapi/features/nea_api/domain/entity/nea_api_entity.dart';

class NeaApiState {
  final bool isLoading;
  final String? error;
  final List<EmployeeDetails> employeeDetails;
  final List<AttendanceRecord> attendanceRecords;

  const NeaApiState({
    required this.isLoading,
    required this.error,
    required this.employeeDetails,
    required this.attendanceRecords,
  });

  factory NeaApiState.initial() => const NeaApiState(
        isLoading: false,
        error: null,
        employeeDetails: [],
        attendanceRecords: [],
      );

  NeaApiState copyWith({
    bool? isLoading,
    String? error,
    List<EmployeeDetails>? employeeDetails,
    List<AttendanceRecord>? attendanceRecords,
  }) {
    return NeaApiState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      employeeDetails: employeeDetails ?? this.employeeDetails,
      attendanceRecords: attendanceRecords ?? this.attendanceRecords,
    );
  }

  @override
  String toString() => 'NeaApiState(isLoading: $isLoading, error: $error)';
}
