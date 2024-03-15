part of 'signup_bloc.dart';

@immutable
sealed class SignupEvent {}

class SignupInitialEvent extends SignupEvent {}

class SignupButtonClickedEvent extends SignupEvent {}
