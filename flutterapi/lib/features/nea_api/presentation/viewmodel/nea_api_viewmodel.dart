import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterapi/features/nea_api/domain/entity/nea_api_entity.dart';
import 'package:flutterapi/features/nea_api/domain/usecase/nea_api_usecase.dart';
import 'package:flutterapi/features/nea_api/presentation/state/nea_api_state.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart'; // Import your entity classes

final neaApiViewModelProvider =
    StateNotifierProvider<NeaApiViewModel, NeaApiState>(
  (ref) => NeaApiViewModel(
    neaApiUseCase: ref.read(neaApiUseCaseProvider),
  ),
);

class NeaApiViewModel extends StateNotifier<NeaApiState> {
  final NeaApiUseCase neaApiUseCase;

  NeaApiViewModel({required this.neaApiUseCase})
      : super(NeaApiState.initial()) {
    getData();
  }

  Future<void> getData(
      {NepaliDateTime? startDate, NepaliDateTime? endDate}) async {
    state = state.copyWith(isLoading: true);

    try {
      final neaApiData = await neaApiUseCase.getData(
        startDate: startDate,
        endDate: endDate,
      );

      neaApiData.fold(
        (failure) {
          state = state.copyWith(
            isLoading: false,
            error: failure.error,
          );
        },
        (success) {
          final ApiResponse apiResponse = ApiResponse.fromJson(success.data);

          final List<EmployeeDetails> employeeDetails =
              (apiResponse.data['EmployeeDetails'] as List<dynamic>)
                  .map((json) => EmployeeDetails.fromJson(json))
                  .toList();

          final List<AttendanceRecord> attendanceRecords =
              (apiResponse.data['AttendanceRecords'] as List<dynamic>)
                  .map((json) => AttendanceRecord.fromJson(json))
                  .toList();

          state = state.copyWith(
            isLoading: false,
            error: null,
            employeeDetails: employeeDetails,
            attendanceRecords: attendanceRecords,
          );
        },
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'An error occurred while fetching data',
      );
    }
  }
}
