import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'theme_event.dart';
part 'theme_state.dart';
part 'theme_bloc.freezed.dart';

@injectable
class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {

  ThemeBloc() : super(const ThemeState.initial()) {
    on<_SwitchToLight>(_switchToLight);
    on<_SwitchToDark>(_switchToDark);
  }

  FutureOr<void> _switchToLight(_SwitchToLight event, Emitter<ThemeState> emit) {
    emit(const ThemeState.light());
  }

  FutureOr<void> _switchToDark(_SwitchToDark event, Emitter<ThemeState> emit) {
    emit(const ThemeState.dark());
  }
}
