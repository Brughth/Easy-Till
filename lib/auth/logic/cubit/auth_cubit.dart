import 'package:bloc/bloc.dart';
import 'package:easy_till/auth/data/models/user_model.dart';
import 'package:easy_till/auth/data/repositories/auth_repositiry.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository authRepository;
  AuthCubit({
    required this.authRepository,
  }) : super(AuthState());

  login({
    required String email,
    required String password,
  }) async {
    try {
      emit(
        state.copyWith(
          isLonginging: true,
          successLonginging: false,
          errorLoginging: false,
        ),
      );
      var user = await authRepository.login(
        email: email,
        password: password,
      );

      emit(
        state.copyWith(
          user: user,
          isLonginging: false,
          successLonginging: true,
          errorLoginging: false,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
            isLonginging: false,
            successLonginging: false,
            errorLoginging: true,
            message: e.toString()),
      );
      print(e);
    }
  }
}
