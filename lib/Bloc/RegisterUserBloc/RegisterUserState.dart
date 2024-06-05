import 'package:equatable/equatable.dart';

abstract class RegisterUserState extends Equatable {
  const RegisterUserState();

  @override
  List<Object?> get props => [];
}

class InitialState extends RegisterUserState {}

class LoadingState extends RegisterUserState {}

class onLoadedState extends RegisterUserState {
  final String id;
  const onLoadedState(this.id);
}
class onUserRegisteredState extends RegisterUserState {
  final String id;
  final String name;
  final String restId;
  const onUserRegisteredState(this.id,this.name,this.restId);
}

class ErrorState extends RegisterUserState {
  final String? message;
  const ErrorState(this.message);
}