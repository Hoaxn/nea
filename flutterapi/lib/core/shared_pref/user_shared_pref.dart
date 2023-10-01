import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterapi/core/failure/failure.dart';
import 'package:shared_preferences/shared_preferences.dart';

final userSharedPrefsProvider = Provider<UserSharedPrefs>(
  (ref) {
    return UserSharedPrefs();
  },
);

class UserSharedPrefs {
  late SharedPreferences _sharedPreferences;

  //Set User Token
  Future<Either<Failure, bool>> setUserToken(String token) async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();

      await _sharedPreferences.setString('Token', token);

      return right(true);
    } catch (e) {
      return left(
        Failure(
          error: e.toString(),
        ),
      );
    }
  }

  //Get User Token
  Future<Either<Failure, String?>> getUserToken() async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();

      final token = _sharedPreferences.getString('Token');

      return right(token);
    } catch (e) {
      return left(
        Failure(
          error: e.toString(),
        ),
      );
    }
  }

  //Remove User Token
  Future<Either<Failure, bool>> removeUserToken() async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();

      await _sharedPreferences.remove('Token');

      return right(true);
    } catch (e) {
      return left(
        Failure(
          error: e.toString(),
        ),
      );
    }
  }
}
