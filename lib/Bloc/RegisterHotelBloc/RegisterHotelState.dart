import 'package:equatable/equatable.dart';

abstract class RegisterHotelState extends Equatable {
  const RegisterHotelState();

  @override
  List<Object?> get props => [];
}

class InitialState extends RegisterHotelState {}

class LoadingState extends RegisterHotelState {}

class onLoadedState extends RegisterHotelState {
}

class ErrorState extends RegisterHotelState {
  final String? message;
  const ErrorState(this.message);
}