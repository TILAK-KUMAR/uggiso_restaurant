import 'package:bloc/bloc.dart';
import 'package:uggiso_restaurant/Bloc/SignUpBloc/signup_event.dart';
import 'package:uggiso_restaurant/Bloc/SignUpBloc/signup_state.dart';

import '../../Network/NetworkError.dart';
import '../../Network/apiRepository.dart';


class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(InitialState()){
    final ApiRepository _apiRepository = ApiRepository();

    on<OnButtonClicked>((event,emit) async{
    try{
    emit(LoadingState()) ;
    if(event.number.isNotEmpty && event.number.length == 10) {
      await _apiRepository.getOtp(event.number);
      emit(onLoadedState());
    }
    else{
      print('this is error');
      emit(ErrorState());
    }

    } on NetworkError {
      print('this is network error');
    }
    });
  }

}
