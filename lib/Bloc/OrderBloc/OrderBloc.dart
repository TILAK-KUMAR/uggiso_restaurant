import 'package:bloc/bloc.dart';
import 'package:uggiso_restaurant/Bloc/OrderBloc/OrderEvent.dart';
import 'package:uggiso_restaurant/Bloc/OrderBloc/OrderState.dart';
import '../../Network/NetworkError.dart';
import '../../Network/apiRepository.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(InitialState()) {
    final ApiRepository _apiRepository = ApiRepository();

    on<OnOrderReceived>((event, emit) async {
      try {
        emit(LoadingState());
        if (event.id.isNotEmpty) {
          var res = await _apiRepository.getRestaurantOrder(
              event.id);
          print('this is res : ${res}');
          if(res.statusCode==200){
            emit(onLoadedState(res));
          }
          else{
            emit(ErrorState(res.message));

          }
        } else {
          emit(ErrorState('Error Occured, Please Try After Sometime'));
        }
      } on NetworkError {
        print('this is network error');
      }
    });
  }
}
