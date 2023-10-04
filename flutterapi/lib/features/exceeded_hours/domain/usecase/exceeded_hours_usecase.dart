import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterapi/core/failure/failure.dart';
import 'package:flutterapi/features/exceeded_hours/domain/repository/exceeded_hours_repository.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';

final exceededHoursUseCaseProvider = Provider<ExceededHoursUseCase>(
  (ref) => ExceededHoursUseCase(
    exceededHoursRepository: ref.read(exceededHoursRepositoryProvider),
  ),
);

class ExceededHoursUseCase {
  final IExceededHoursRepository exceededHoursRepository;

  ExceededHoursUseCase({required this.exceededHoursRepository});

  Future<Either<Failure, Response>> getExceededHours({
    NepaliDateTime? startDate,
    NepaliDateTime? endDate,
  }) {
    return exceededHoursRepository.getExceededHours(
        startDate: startDate, endDate: endDate);
  }
}
