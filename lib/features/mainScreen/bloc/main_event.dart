part of 'main_bloc.dart';

@immutable
sealed class MainEvent {}

class MainInitialEvent extends MainEvent {}

class GratitudeClickedEvent extends MainEvent {}

class TaskClickedEvent extends MainEvent {}
