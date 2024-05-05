import 'package:equatable/equatable.dart';

abstract class AddFoodEvent extends Equatable {
  const AddFoodEvent();
}

class OnSubmitButtonClicked extends AddFoodEvent {
  final String id;
  final String title;
  final String description;
  final String price;
  final String foodType;
  final String menuType;
  final String url;

  const OnSubmitButtonClicked({required this.id,required this.title,
    required this.description, required this.menuType, required this.foodType,required this.price,
    required this.url});

  @override
  List<Object> get props => [title];

  @override
  String toString() => 'OnButtonClicked { title: $title }';
}

class LoadMenuList extends AddFoodEvent{
  final String id;

  const LoadMenuList({required this.id});

  @override
  // TODO: implement props
  List<Object> get props => [id];
}

class onDeleteMenuItem extends AddFoodEvent{
  final String id;
  const onDeleteMenuItem({required this.id});

  @override
  // TODO: implement props
  List<Object> get props => [id];
}
