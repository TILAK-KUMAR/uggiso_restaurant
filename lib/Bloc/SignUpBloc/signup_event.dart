import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();
}

class OnButtonClicked extends SignUpEvent {
  final String number;

  const OnButtonClicked({required this.number});

  @override
  List<Object> get props => [number];

  @override
  String toString() => 'OnButtonClicked { number: $number }';
}
