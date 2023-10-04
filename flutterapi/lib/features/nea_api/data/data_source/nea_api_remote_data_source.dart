import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterapi/config/constants/api_endpoint.dart';
import 'package:flutterapi/core/common/network/remote/http_service.dart';
import 'package:flutterapi/core/failure/failure.dart';
import 'package:flutterapi/core/shared_pref/user_shared_pref.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';

final neaApiRemoteDataSourceProvider = Provider<NeaApiRemoteDataSource>(
  (ref) {
    return NeaApiRemoteDataSource(
      ref.read(httpServiceProvider),
      ref.read(userSharedPrefsProvider),
    );
  },
);

class NeaApiRemoteDataSource {
  final Dio dio;
  final UserSharedPrefs userSharedPrefs;

  NeaApiRemoteDataSource(this.dio, this.userSharedPrefs);

  Future<Either<Failure, Response>> getData(
      {NepaliDateTime? startDate, NepaliDateTime? endDate}) async {
    final data = await userSharedPrefs.getEmpCode();
    final tokenData = await userSharedPrefs.getUserToken();

    String? empCode;
    String? token;

    data.fold(
      (failure) {
        // Failure Case
      },
      (empCodeValue) {
        empCode = empCodeValue;
      },
    );

    tokenData.fold(
      (failure) {
        // Failure Case
      },
      (tokenValue) {
        token = tokenValue;
      },
    );

    try {
      Response response = await dio.get(
        "${ApiEndpoints.baseUrl}/${ApiEndpoints.getData}?Token=$token&StartDateNepali=${startDate?.format('yyyy/MM/dd')}&EndDateNepali=${endDate?.format('yyyy/MM/dd')}&CurrentPage=1&ItemPerPage=1&EmpCode=$empCode",
        options: Options(
          headers: {
            "authorization": 'Bearer $token',
          },
        ),
      );
      if (response.statusCode == 200) {
        return Right(response);
      } else {
        return Left(
          Failure(
            error: response.data["message"],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0',
        ),
      );
    }
  }
}
