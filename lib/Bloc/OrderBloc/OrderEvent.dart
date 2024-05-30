import 'package:equatable/equatable.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();
}

class OnOrderReceived extends OrderEvent {
  final String id;

  const OnOrderReceived({
    required this.id
  });

  @override
  List<Object> get props => [id];

  @override
  String toString() => 'OnButtonClicked { number: $id }';
}
