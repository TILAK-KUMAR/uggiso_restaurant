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
