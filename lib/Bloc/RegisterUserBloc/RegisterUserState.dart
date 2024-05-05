import 'package:equatable/equatable.dart';

abstract class RegisterUserState extends Equatable {
  const RegisterUserState();

  @override
  List<Object?> get props => [];
}

class InitialState extends RegisterUserState {}

class LoadingState extends RegisterUserState {}

class onLoadedState extends RegisterUserState {}

class ErrorState extends RegisterUserState {
  final String? message;
  const ErrorState(this.message);
}