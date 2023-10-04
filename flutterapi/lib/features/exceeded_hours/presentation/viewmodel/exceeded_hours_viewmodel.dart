import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterapi/features/exceeded_hours/domain/entity/exceeded_hours_entity.dart';
import 'package:flutterapi/features/exceeded_hours/domain/usecase/exceeded_hours_usecase.dart';
import 'package:flutterapi/features/exceeded_hours/presentation/state/exceeded_hours_state.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart'; // Import your entity classes

final exceededHoursViewModelProvider =
    StateNotifierProvider<ExceededHoursViewModel, ExceededHoursState>(
  (ref) => ExceededHoursViewModel(
    exceededHoursUseCase: ref.read(exceededHoursUseCaseProvider),
  ),
);

class ExceededHoursViewModel extends StateNotifier<ExceededHoursState> {
  final ExceededHoursUseCase exceededHoursUseCase;

  ExceededHoursViewModel({required this.exceededHoursUseCase})
      : super(ExceededHoursState.initial()) {
    getExceededHours();
  }

  Future<void> getExceededHours(
      {NepaliDateTime? startDate, NepaliDateTime? endDate}) async {
    state = state.copyWith(isLoading: true);

    try {
      final exceededHoursData = await exceededHoursUseCase.getExceededHours(
        startDate: startDate,
        endDate: endDate,
      );

      exceededHoursData.fold(
        (failure) {
          state = state.copyWith(
            isLoading: false,
            error: failure.error,
          );
        },
        (success) {
          final ExceededHoursApiResponse apiResponse =
              ExceededHoursApiResponse.fromJson(success.data);

          final List<ExceededHours> exceededHours =
              (apiResponse.data['ExceededHours'] as List<dynamic>)
                  .map((json) => ExceededHours.fromJson(json))
                  .toList();

          state = state.copyWith(
            isLoading: false,
            error: null,
            exceededHours: exceededHours,
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
