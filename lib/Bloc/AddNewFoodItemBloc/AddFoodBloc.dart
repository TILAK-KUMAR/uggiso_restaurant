import 'package:bloc/bloc.dart';
import 'package:uggiso_restaurant/Model/AddFoodModel.dart';
import '../../Network/NetworkError.dart';
import '../../Network/apiRepository.dart';
import 'AddFoodEvent.dart';
import 'AddFoodState.dart';


class AddFoodBloc extends Bloc<AddFoodEvent, AddFoodState> {
  AddFoodBloc() : super(InitialState()){
    final ApiRepository _apiRepository = ApiRepository();

    on<OnSubmitButtonClicked>((event,emit) async{

      try{
        emit(LoadingState()) ;
        if(event.title.isNotEmpty) {
          var res = await _apiRepository.addFood(event.id,event.title,event.description,event.menuType,
              event.foodType,event.price,'false',event.url);
          if(res.statusCode == 201) {
            final List<Payload>? items = res.payload;
            emit(onLoadedState(items));
          } else {
            emit(ErrorState(res.message));
          }
        }
      } on NetworkError {
        emit(ErrorState('this is network error'));
      }
    });

    on<LoadMenuList>((event,emit)async{
      try{
        emit(LoadingState()) ;
          final res = await _apiRepository.getAddedMenu(event.id);
          if(res.statusCode == 201) {
            final List<Payload>? items = res.payload; // Extract the list from the response
            emit(onLoadedState(items));
          } else {
            emit(ErrorState(res.message));
          }
      }on NetworkError {
        emit(ErrorState('this is network error'));
      }
    });

    on<onDeleteMenuItem>((event,emit)async{
      try{
        emit(LoadingState()) ;
        final res = await _apiRepository.deleteFoodItem(event.id);
        if(res.statusCode == 200) {
          final loadData = await _apiRepository.getAddedMenu('51f6e514-80ab-466f-9ccc-916d80850c4d');
          final List<Payload>? items = loadData.payload; // Extract the list from the response
          emit(onLoadedState(items));
        } else {
          emit(ErrorState(res.message));
        }
      }on NetworkError {
        emit(ErrorState('this is network error'));
      }
    });
  }

}
