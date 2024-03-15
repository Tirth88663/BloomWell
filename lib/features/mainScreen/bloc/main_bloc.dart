import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc() : super(MainInitial()) {
    on<MainInitialEvent>(mainInitialEvent);
  }

  FutureOr<void> mainInitialEvent(
      MainInitialEvent event, Emitter<MainState> emit) {
    emit(MainInitial());
  }
}
