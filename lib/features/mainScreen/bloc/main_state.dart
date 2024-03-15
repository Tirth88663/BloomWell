part of 'main_bloc.dart';

@immutable
sealed class MainState {}

abstract class MainActionState extends MainState {}

final class MainInitial extends MainState {}
