import 'package:equatable/equatable.dart';
import 'package:uggiso_restaurant/Model/AddFoodModel.dart';

abstract class AddFoodState extends Equatable {
  const AddFoodState();

  @override
  List<Object?> get props => [];
}

class InitialState extends AddFoodState {}

class LoadingState extends AddFoodState {}

class onLoadedState extends AddFoodState {
  final List<Payload>? menuList;
  const onLoadedState(this.menuList);
}

class ErrorState extends AddFoodState {
  final String? message;
  const ErrorState(this.message);
}