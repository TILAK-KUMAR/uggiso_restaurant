import 'package:equatable/equatable.dart';

abstract class RegisterHotelEvent extends Equatable {
  const RegisterHotelEvent();
}

class OnSubmitButtonClicked extends RegisterHotelEvent {
  final String id;
  final String name;
  final String phone;
  final String address;
  final String landmark;
  final String city;
  final String state;
  final String accountNumber;
  final String ifsc;
  final String upi;
  final String image;

  const OnSubmitButtonClicked({
    required this.id,
    required this.name,
    required this.phone,
    required this.address,
    required this.landmark,
    required this.city,
    required this.state,
    required this.accountNumber,
    required this.ifsc,
    required this.upi,
    required this.image,
  });

  @override
  List<Object> get props => [id];

  @override
  String toString() => 'OnButtonClicked { number: $id }';
}
