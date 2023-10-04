import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterapi/core/failure/failure.dart';
import 'package:flutterapi/features/exceeded_hours/data/data_source/exceeded_hours_data_source.dart';
import 'package:flutterapi/features/exceeded_hours/domain/repository/exceeded_hours_repository.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';

final exceededHoursRemoteRepositoryProvider =
    Provider<IExceededHoursRepository>(
  (ref) => ExceededHoursRemoteRepositoryImpl(
    exceededHoursRemoteDataSource:
        ref.read(exceededHoursRemoteDataSourceProvider),
  ),
);

class ExceededHoursRemoteRepositoryImpl implements IExceededHoursRepository {
  final ExceededHoursRemoteDataSource exceededHoursRemoteDataSource;

  ExceededHoursRemoteRepositoryImpl(
      {required this.exceededHoursRemoteDataSource});

  @override
  Future<Either<Failure, Response>> getExceededHours({
    NepaliDateTime? startDate,
    NepaliDateTime? endDate,
  }) {
    return exceededHoursRemoteDataSource.getExceededHours(
        startDate: startDate, endDate: endDate);
  }
}
