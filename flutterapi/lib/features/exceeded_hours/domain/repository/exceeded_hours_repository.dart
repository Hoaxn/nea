import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterapi/core/failure/failure.dart';
import 'package:flutterapi/features/exceeded_hours/data/repository/exceeded_hours_remote_repo_impl.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';

final exceededHoursRepositoryProvider = Provider<IExceededHoursRepository>(
  (ref) {
    return ref.read(exceededHoursRemoteRepositoryProvider);
  },
);

abstract class IExceededHoursRepository {
  Future<Either<Failure, Response>> getExceededHours({
    NepaliDateTime? startDate,
    NepaliDateTime? endDate,
  });
}
