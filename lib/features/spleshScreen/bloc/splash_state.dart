part of 'splash_bloc.dart';

@immutable
sealed class SplashState {}

sealed class SplashActionState extends SplashState {}

class SplashInitial extends SplashState {}

class SplashWaitingActionState extends SplashState {}

class SplashNavToLoginScreenState extends SplashActionState {}

class SplashNavToMainScreenState extends SplashActionState {}
