import 'package:flutterapi/features/exceeded_hours/domain/entity/exceeded_hours_entity.dart';

class ExceededHoursState {
  final bool isLoading;
  final String? error;
  final List<ExceededHours> exceededHours;

  const ExceededHoursState({
    required this.isLoading,
    required this.error,
    required this.exceededHours,
  });

  factory ExceededHoursState.initial() => const ExceededHoursState(
        isLoading: false,
        error: null,
        exceededHours: [],
      );

  ExceededHoursState copyWith({
    bool? isLoading,
    String? error,
    List<ExceededHours>? exceededHours,
  }) {
    return ExceededHoursState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      exceededHours: exceededHours ?? this.exceededHours,
    );
  }

  @override
  String toString() =>
      'ExceededHoursState(isLoading: $isLoading, error: $error)';
}
