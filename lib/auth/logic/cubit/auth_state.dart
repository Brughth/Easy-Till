part of 'auth_cubit.dart';

@immutable
class AuthState {
  final UserModel? user;
  final bool isLonginging;
  final bool successLonginging;
  final bool errorLoginging;
  final String? message;

  AuthState({
    this.user,
    this.isLonginging = false,
    this.successLonginging = false,
    this.errorLoginging = false,
    this.message,
  });

  AuthState copyWith({
    UserModel? user,
    bool? isLonginging,
    bool? successLonginging,
    bool? errorLoginging,
    String? message,
  }) {
    return AuthState(
      user: user ?? this.user,
      isLonginging: isLonginging ?? this.isLonginging,
      successLonginging: successLonginging ?? this.successLonginging,
      errorLoginging: errorLoginging ?? this.errorLoginging,
      message: message ?? this.message,
    );
  }
}
