import 'package:equatable/equatable.dart';

abstract class MenuEvent extends Equatable {
  const MenuEvent();
}

class OnSubmitButtonClicked extends MenuEvent {
  final String id;


  const OnSubmitButtonClicked({required this.id});

  @override
  List<Object> get props => [id];

  @override
  String toString() => 'OnButtonClicked { number: $id }';
}
