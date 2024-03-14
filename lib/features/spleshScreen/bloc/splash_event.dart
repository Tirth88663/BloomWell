part of 'splash_bloc.dart';

@immutable
sealed class SplashEvent {}

class SplashLogInEvent extends SplashEvent {}

class SplashLogOutEvent extends SplashEvent {}
