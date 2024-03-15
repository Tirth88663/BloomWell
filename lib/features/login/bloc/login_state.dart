part of 'login_bloc.dart';

@immutable
sealed class LoginState {}

abstract class LoginActionState extends LoginState {}

final class LoginInitial extends LoginState {}

class LoginNavToSignupState extends LoginActionState {}

class LoginNavToMainState extends LoginActionState {}