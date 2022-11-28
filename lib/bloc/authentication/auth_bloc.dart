import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../models/user_model.dart';
import '../../repositories/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepo;

  AuthBloc(this._authRepo) : super(AuthInitial()) {
    on<AuthStarted>((event, emit) async {
      await _authStarted(emit);
    });

    on<AuthSignedOut>((event, emit) async {
      await _authLogOut(emit);
    });
  }

  Future<void> _authStarted(Emitter<AuthState> emit) async {
    try {
      UserModel user = await _authRepo.getCurrentUser().first;
      if (user.uid != "uid") {
        String? displayName = await _authRepo.retrieveUserName(user);
        emit(AuthSuccess(displayName: displayName));
      } else {
        emit(AuthFailure());
      }
    } on Exception catch (err) {
      emit(AuthError(errorMessage: err.toString()));
    }
  }

  Future<void> _authLogOut(Emitter<AuthState> emit) async {
    await _authRepo.logOut();
    emit(AuthInitial());
  }
}
