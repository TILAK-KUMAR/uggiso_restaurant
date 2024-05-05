import 'package:equatable/equatable.dart';

abstract class RegisterHotelEvent extends Equatable {
  const RegisterHotelEvent();
}

class OnSubmitButtonClicked extends RegisterHotelEvent {
  final String id;

  const OnSubmitButtonClicked({required this.id});

  @override
  List<Object> get props => [id];

  @override
  String toString() => 'OnButtonClicked { number: $id }';
}
