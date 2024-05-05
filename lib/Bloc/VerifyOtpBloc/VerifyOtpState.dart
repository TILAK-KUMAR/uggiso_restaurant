import 'package:equatable/equatable.dart';

abstract class VerifyOtpState extends Equatable {
  const VerifyOtpState();

  @override
  List<Object?> get props => [];
}

class InitialState extends VerifyOtpState {}

class LoadingState extends VerifyOtpState {}

class onLoadedState extends VerifyOtpState {}

class ErrorState extends VerifyOtpState {
  final String? message;
  const ErrorState(this.message);
}