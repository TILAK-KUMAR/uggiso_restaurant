import 'package:equatable/equatable.dart';

abstract class MenuState extends Equatable {
  const MenuState();

  @override
  List<Object?> get props => [];
}

class InitialState extends MenuState {}

class LoadingState extends MenuState {}

class onLoadedState extends MenuState {
  final List? data;
  const onLoadedState(this.data);
}

class ErrorState extends MenuState {
  final String? message;
  const ErrorState(this.message);
}