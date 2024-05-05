import 'package:bloc/bloc.dart';
import 'package:uggiso_restaurant/Bloc/RegisterHotelBloc/RegisterHotelEvent.dart';
import 'package:uggiso_restaurant/Bloc/RegisterHotelBloc/RegisterHotelState.dart';

import '../../Network/NetworkError.dart';
import '../../Network/apiRepository.dart';

class RegisterHotelBloc extends Bloc<RegisterHotelEvent, RegisterHotelState> {
  RegisterHotelBloc() : super(InitialState()){
    final ApiRepository _apiRepository = ApiRepository();

    on<OnSubmitButtonClicked>((event,emit) async{

      try{
        emit(LoadingState()) ;
        if(event.name.isNotEmpty) {
          await _apiRepository.registerUser(event.name,event.number,
              'RESTAURANT',event.deviceId,event.token);
          emit(onLoadedState());
        }
        else{
          emit(ErrorState(''));
        }

      } on NetworkError {
        print('this is network error');
      }
    });
  }

}
