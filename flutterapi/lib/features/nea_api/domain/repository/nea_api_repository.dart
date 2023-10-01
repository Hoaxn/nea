import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterapi/core/failure/failure.dart';
import 'package:flutterapi/features/nea_api/data/repository/nea_api_remote_repo_impl.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';

final neaApiRepositoryProvider = Provider<INeaApiRepository>(
  (ref) {
    return ref.read(neaApiRemoteRepositoryProvider);
  },
);

abstract class INeaApiRepository {
  Future<Either<Failure, Response>> getData({
    NepaliDateTime? startDate,
    NepaliDateTime? endDate,
  });
}
