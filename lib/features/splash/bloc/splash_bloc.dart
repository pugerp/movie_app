import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'splash_event.dart';
part 'splash_state.dart';
part 'splash_bloc.freezed.dart';

@injectable
class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(const SplashState.initial()) {
    on<_Started>(_start);
  }

  FutureOr<void> _start(event, Emitter<SplashState> emit) async {
    emit(const SplashState.loading());

    await Future.delayed(const Duration(seconds: 5));

    emit(const SplashState.success());
  }
}
