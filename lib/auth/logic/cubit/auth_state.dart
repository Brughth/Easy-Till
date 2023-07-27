part of 'auth_cubit.dart';

@immutable
class AuthState {
  final UserModel? user;
  final bool isLonginging;
  final bool successLonginging;
  final bool errorLoginging;
  final String? message;
  //
  final bool isCheckingAuthState;
  final bool successCheckingAuthState;
  final bool errorCheckingAuthState;

  AuthState({
    this.user,
    this.isLonginging = false,
    this.successLonginging = false,
    this.errorLoginging = false,
    this.message,
    //
    this.isCheckingAuthState = false,
    this.successCheckingAuthState = false,
    this.errorCheckingAuthState = false,
  });

  AuthState copyWith({
    UserModel? user,
    bool? isLonginging,
    bool? successLonginging,
    bool? errorLoginging,
    //
    String? message,
    //
    bool? isCheckingAuthState,
    bool? successCheckingAuthState,
    bool? errorCheckingAuthState,
  }) {
    return AuthState(
      user: user ?? this.user,
      isLonginging: isLonginging ?? this.isLonginging,
      successLonginging: successLonginging ?? this.successLonginging,
      errorLoginging: errorLoginging ?? this.errorLoginging,
      //
      message: message ?? this.message,
      //
      isCheckingAuthState: isCheckingAuthState ?? this.isCheckingAuthState,
      successCheckingAuthState:
          successCheckingAuthState ?? this.successCheckingAuthState,
      errorCheckingAuthState:
          errorCheckingAuthState ?? this.errorCheckingAuthState,
    );
  }
}
