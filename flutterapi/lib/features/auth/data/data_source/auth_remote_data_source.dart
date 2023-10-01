import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterapi/config/constants/api_endpoint.dart';
import 'package:flutterapi/core/common/network/remote/http_service.dart';
import 'package:flutterapi/core/failure/failure.dart';
import 'package:flutterapi/core/shared_pref/user_shared_pref.dart';

final authRemoteDataSourceProvider = Provider(
  (ref) => AuthRemoteDataSource(
    dio: ref.read(httpServiceProvider),
    userSharedPrefs: ref.read(userSharedPrefsProvider),
  ),
);

class AuthRemoteDataSource {
  final Dio dio;
  final UserSharedPrefs userSharedPrefs;

  AuthRemoteDataSource({required this.userSharedPrefs, required this.dio});

  Future<Either<Failure, bool>> loginUser(
    String user,
    String pass,
  ) async {
    try {
      Response response = await dio.post(
        ApiEndpoints.login,
        data: {
          "User": user,
          "Pass": pass,
        },
      );
      if (response.statusCode == 200) {
        // retrieve token
        String token = response.data["data"]["Token"];

        await userSharedPrefs.setUserToken(token);

        return const Right(true);
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
