class ExceededHours {
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
  final String? exceededHours;

  ExceededHours({
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
    this.exceededHours,
  });

  factory ExceededHours.fromJson(Map<String, dynamic> json) {
    return ExceededHours(
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
      exceededHours: json['ExceededHours'],
    );
  }
}

class ExceededHoursApiResponse {
  final String statusType;
  final String message;
  final Map<String, dynamic> data;

  ExceededHoursApiResponse({
    required this.statusType,
    required this.message,
    required this.data,
  });

  factory ExceededHoursApiResponse.fromJson(Map<String, dynamic> json) {
    return ExceededHoursApiResponse(
      statusType: json['StatusType'],
      message: json['Message'],
      data: json['data'],
    );
  }
}
