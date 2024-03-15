import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc() : super(MainInitial()) {
    on<MainInitialEvent>(mainInitialEvent);
    on<GratitudeClickedEvent>(gratitudeClickedEvent);
    on<TaskClickedEvent>(taskClickedEvent);
  }

  FutureOr<void> mainInitialEvent(
      MainInitialEvent event, Emitter<MainState> emit) {
    emit(MainInitial());
  }

  FutureOr<void> gratitudeClickedEvent(
      GratitudeClickedEvent event, Emitter<MainState> emit) {
    emit(MainNavToGratitudeState());
  }

  FutureOr<void> taskClickedEvent(
      TaskClickedEvent event, Emitter<MainState> emit) {
    emit(MainNavToTaskState());
  }
}
