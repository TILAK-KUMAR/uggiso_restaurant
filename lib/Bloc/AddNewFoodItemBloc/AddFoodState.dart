import 'package:equatable/equatable.dart';
import 'package:uggiso_restaurant/Model/AddFoodModel.dart';
import 'package:uggiso_restaurant/Model/EditMenuModel.dart';

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
class onFoodEditedState extends AddFoodState {
  final List<EditMenuPayload>? menuList;
  const onFoodEditedState(this.menuList);
}

class ErrorState extends AddFoodState {
  final String? message;
  const ErrorState(this.message);
}