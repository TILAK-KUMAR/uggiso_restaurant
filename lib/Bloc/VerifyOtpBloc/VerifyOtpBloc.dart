import 'package:bloc/bloc.dart';

import '../../Network/NetworkError.dart';
import '../../Network/apiRepository.dart';
import 'VerifyOtpEvent.dart';
import 'VerifyOtpState.dart';


class VerifyOtpBloc extends Bloc<VerifyOtpEvent, VerifyOtpState> {
  VerifyOtpBloc() : super(InitialState()){
    final ApiRepository _apiRepository = ApiRepository();

    on<OnButtonClicked>((event,emit) async{

      try{

        emit(LoadingState()) ;
        await _apiRepository.verifyOtp(event.number,event.otp);
        emit(onLoadedState());

      } on NetworkError {
        print('this is network error');
      }
    });
  }
}
