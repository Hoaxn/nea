import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterapi/config/routers/app_route.dart';
import 'package:flutterapi/core/common/snackbar/snackbar.dart';
import 'package:flutterapi/features/auth/domain/usecase/auth_usecase.dart';
import 'package:flutterapi/features/auth/presentation/state/auth_state.dart';

final authViewModelProvider =
    StateNotifierProvider<AuthViewModel, AuthState>((ref) {
  return AuthViewModel(
    ref.read(authUseCaseProvider),
  );
});

class AuthViewModel extends StateNotifier<AuthState> {
  final AuthUseCase _authUseCase;

  AuthViewModel(this._authUseCase) : super(AuthState(isLoading: false));

  Future<bool> loginUser(BuildContext context, String user, String pass) async {
    state = state.copyWith(isLoading: true);

    bool isLogin = false;

    var data = await _authUseCase.loginUser(user, pass);

    data.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.error);
        showSnackBar(
          message: failure.error,
          context: context,
          color: Colors.red,
        );
      },
      (success) {
        state = state.copyWith(isLoading: false, error: null);
        Navigator.pushReplacementNamed(context, AppRoute.homeRoute);
        isLogin = success;
      },
    );

    return isLogin;
  }
}
