import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterapi/core/failure/failure.dart';
import 'package:flutterapi/features/nea_api/data/data_source/nea_api_remote_data_source.dart';
import 'package:flutterapi/features/nea_api/domain/repository/nea_api_repository.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';

final neaApiRemoteRepositoryProvider = Provider<INeaApiRepository>(
  (ref) => NeaApiRemoteRepositoryImpl(
    neaApiRemoteDataSource: ref.read(neaApiRemoteDataSourceProvider),
  ),
);

class NeaApiRemoteRepositoryImpl implements INeaApiRepository {
  final NeaApiRemoteDataSource neaApiRemoteDataSource;

  NeaApiRemoteRepositoryImpl({required this.neaApiRemoteDataSource});

  @override
  Future<Either<Failure, Response>> getData({
    NepaliDateTime? startDate,
    NepaliDateTime? endDate,
  }) {
    return neaApiRemoteDataSource.getData(
        startDate: startDate, endDate: endDate);
  }
}
