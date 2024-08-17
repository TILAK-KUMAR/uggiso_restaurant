import 'package:bloc/bloc.dart';

import '../../Network/NetworkError.dart';
import '../../Network/apiRepository.dart';
import 'RegisterUserEvent.dart';
import 'RegisterUserState.dart';


class RegisterUserBloc extends Bloc<RegisterUserEvent, RegisterUserState> {
  RegisterUserBloc() : super(InitialState()){
    final ApiRepository _apiRepository = ApiRepository();

    on<OnRegisterButtonClicked>((event,emit) async{

      try{
        emit(LoadingState()) ;
        if(event.name.isNotEmpty) {
          //String name,String number,String userType,String deviceId,String token
          var res = await _apiRepository.registerUser(event.name,event.number,
              'CUSTOMER',event.deviceId,event.token);
          if(res.statusCode==200){
            emit(onLoadedState(res.payload!.userId.toString()));

          }
          else{
            var restaurantData = await _apiRepository.getResaturantDetails(res.payload!.userId.toString());
            print('restaurant Data  :$restaurantData');
            if(restaurantData.statusCode!=200){
              emit(onUserRegisteredState(res.payload!.userId.toString(),res.payload!.name.toString(),''));

            }else{
              emit(onUserRegisteredState(res.payload!.userId.toString(),res.payload!.name.toString(),restaurantData.payload!.restaurantId.toString()));
            }
          }
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
