part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();
  
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthSuccess extends AuthState {
  final String? displayName;
  final String uid;
  const AuthSuccess({required this.uid, this.displayName});

  @override
  List<Object?> get props => [displayName];
}

class AuthFailure extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthError extends AuthState {
  final String? errorMessage;
  const AuthError({this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}