import 'package:bloc/bloc.dart';
import 'package:uggiso_restaurant/Bloc/RegisterHotelBloc/RegisterHotelEvent.dart';
import 'package:uggiso_restaurant/Bloc/RegisterHotelBloc/RegisterHotelState.dart';

import '../../Network/NetworkError.dart';
import '../../Network/apiRepository.dart';

class RegisterHotelBloc extends Bloc<RegisterHotelEvent, RegisterHotelState> {
  RegisterHotelBloc() : super(InitialState()) {
    final ApiRepository _apiRepository = ApiRepository();

    on<OnSubmitButtonClicked>((event, emit) async {
      try {
        emit(LoadingState());
        if (event.name.isNotEmpty) {
          var res = await _apiRepository.registerRestaurant(
              event.id,
              event.name,
              event.phone,
              event.restaurantMenuType,
              event.address,
              event.landmark,
              event.city,
              event.state,
              event.accountNumber,
              event.ifsc,
              event.upi,
              event.image,
              event.gstNumber,
              event.gstPercent,
              event.lat,
              event.lng);
          print('this is res : ${res.payload?.restaurantId}');
          emit(onLoadedState(res.payload!.restaurantId));
        } else {
          emit(ErrorState(''));
        }
      } on NetworkError {
        print('this is network error');
      }
    });
  }
}
