import 'package:equatable/equatable.dart';
import 'package:uggiso_restaurant/Model/RestaurantOrderModel.dart';

abstract class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object?> get props => [];
}

class InitialState extends OrderState {}

class LoadingState extends OrderState {}

class onLoadedState extends OrderState {
  final RestaurantOrderModel? data;
  const onLoadedState(this.data);
}

class ErrorState extends OrderState {
  final String? message;
  const ErrorState(this.message);
}