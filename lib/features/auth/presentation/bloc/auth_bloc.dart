// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:screpagram/features/auth/domain/entities/person_form_model.dart';
import 'package:screpagram/features/auth/domain/repository/registration_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final RegRepo regRepo;
  AuthBloc({required this.regRepo}) : super(AuthInitial()) {
    on<SignUpEvent>(_onSignUp);
    on<SignInEvent>(_onSignIn);
  }

  Future<void> _onSignUp(SignUpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await regRepo.signUp(event.personEntity);
      emit(AuthAuthenticated());
    } catch (e) {
      emit(AuthFailure(message: e.toString()));
    }
  }

  Future<void> _onSignIn(SignInEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await regRepo.signIn(event.personEntity);
      emit(AuthAuthenticated());
    } catch (e) {
      emit(AuthFailure(message: e.toString()));
    }
  }
}
