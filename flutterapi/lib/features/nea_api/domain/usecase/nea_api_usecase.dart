import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterapi/core/failure/failure.dart';
import 'package:flutterapi/features/nea_api/domain/repository/nea_api_repository.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';

final neaApiUseCaseProvider = Provider<NeaApiUseCase>(
  (ref) => NeaApiUseCase(
    neaApiRepository: ref.read(neaApiRepositoryProvider),
  ),
);

class NeaApiUseCase {
  final INeaApiRepository neaApiRepository;

  NeaApiUseCase({required this.neaApiRepository});

  Future<Either<Failure, Response>> getData({
    NepaliDateTime? startDate,
    NepaliDateTime? endDate,
  }) {
    return neaApiRepository.getData(startDate: startDate, endDate: endDate);
  }
}
