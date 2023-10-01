class EmployeeDetails {
  final String empCode;
  final int panNumber;
  final String? employeePersonalCode;
  final int attendanceEnrollId;
  final String employeeName;
  final String designation;
  final String employeeLevel;
  final int levelOrder;
  final String? branch;
  final String employmentType;
  final int mobileNumber;
  final String renumration;

  EmployeeDetails({
    required this.empCode,
    required this.panNumber,
    required this.employeePersonalCode,
    required this.attendanceEnrollId,
    required this.employeeName,
    required this.designation,
    required this.employeeLevel,
    required this.levelOrder,
    required this.branch,
    required this.employmentType,
    required this.mobileNumber,
    required this.renumration,
  });

  factory EmployeeDetails.fromJson(Map<String, dynamic> json) {
    return EmployeeDetails(
      empCode: json['EmpCode'],
      panNumber: json['PANNumber'],
      employeePersonalCode: json['EmployeePersonalCode'],
      attendanceEnrollId: json['AttendanceEnrollId'],
      employeeName: json['EmployeeName'],
      designation: json['Designation'],
      employeeLevel: json['EmployeeLevel'],
      levelOrder: json['LevelOrder'],
      branch: json['Branch'],
      employmentType: json['EmploymentType'],
      mobileNumber: json['MobileNumber'],
      renumration: json['Renumration'],
    );
  }
}

class AttendanceRecord {
  final String empCode;
  final String attendanceDateNepali;
  final String? inTime;
  final String? outTime;
  final String? logs;
  final double lateAfterGrace;
  final double earlyBeforeGrace;
  final double workDuration;
  final double approvedOvertime;
  final String status;
  final String monthStatus;
  final String remarks;
  final double negativeHours;

  AttendanceRecord({
    required this.empCode,
    required this.attendanceDateNepali,
    this.inTime,
    this.outTime,
    this.logs,
    required this.lateAfterGrace,
    required this.earlyBeforeGrace,
    required this.workDuration,
    required this.approvedOvertime,
    required this.status,
    required this.monthStatus,
    required this.remarks,
    required this.negativeHours,
  });

  factory AttendanceRecord.fromJson(Map<String, dynamic> json) {
    return AttendanceRecord(
      empCode: json['EmpCode'],
      attendanceDateNepali: json['AttendanceDateNepali'],
      inTime: json['InTime'],
      outTime: json['OutTime'],
      logs: json['Logs'],
      lateAfterGrace: json['LateAfterGrace'],
      earlyBeforeGrace: json['EarlyBeforeGrace'],
      workDuration: json['WorkDuration'],
      approvedOvertime: json['ApprovedOvertime'],
      status: json['Status'],
      monthStatus: json['MonthStatus'],
      remarks: json['Remarks'],
      negativeHours: json['NegativeHours'],
    );
  }
}

class ApiResponse {
  final String statusType;
  final String message;
  final Map<String, dynamic> data;

  ApiResponse({
    required this.statusType,
    required this.message,
    required this.data,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      statusType: json['StatusType'],
      message: json['Message'],
      data: json['data'],
    );
  }
}
