import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterapi/features/auth/domain/repository/auth_repository.dart';

import '../../../../core/failure/failure.dart';

final authUseCaseProvider = Provider(
  (ref) {
    return AuthUseCase(
      ref.read(authRepositoryProvider),
    );
  },
);

class AuthUseCase {
  final IAuthRepository _authRepository;

  AuthUseCase(this._authRepository);

  Future<Either<Failure, bool>> loginUser(String user, String pass) async {
    return await _authRepository.loginUser(user, pass);
  }
}
