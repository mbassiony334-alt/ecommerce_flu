part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthSucces extends AuthState {}

final class AuthFailure extends AuthState {
  final String errormessage;

  AuthFailure({required this.errormessage});
}

final class AuthLoading extends AuthState {}
final class Regsuccess extends AuthState {}
final class Regfailure extends AuthState {
final String errormessage;

  Regfailure({required this.errormessage});
}
final class ForgetPass extends AuthState {}
final class Forgetfaliure extends AuthState {final String errormessage;

  Forgetfaliure({required this.errormessage});}
final class RestPassSuccess extends AuthState {}
final class RestPassfaliure extends AuthState {final String errormessage;

  RestPassfaliure({required this.errormessage});}

