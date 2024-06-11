import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uggiso_restaurant/Widgets/ui-kit/RoundedContainer.dart';
import 'package:uggiso_restaurant/Widgets/ui-kit/RoundedElevatedButton.dart';
import 'package:uggiso_restaurant/Widgets/ui-kit/TextFieldCurvedEdges.dart';
import '../Bloc/RegisterUserBloc/RegisterUserBloc.dart';
import '../Bloc/RegisterUserBloc/RegisterUserEvent.dart';
import '../Bloc/RegisterUserBloc/RegisterUserState.dart';
import '../app_routes.dart';
import '../base/common/utils/colors.dart';
import '../base/common/utils/fonts.dart';
import '../base/common/utils/strings.dart';

class RegisterUserScreen extends StatefulWidget {
  const RegisterUserScreen({super.key});

  @override
  State<RegisterUserScreen> createState() => _RegisterUserScreenState();
}

class _RegisterUserScreenState extends State<RegisterUserScreen> {
  final TextEditingController _nameController = TextEditingController();
  final RegisterUserBloc _registerUserBloc = RegisterUserBloc();
  String userContactNumber = '';
  String userDeviceId = '';
  String fcmToken = '';

  @override
  void initState() {
    getUserNumber();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _registerUserBloc,
      child: BlocListener<RegisterUserBloc, RegisterUserState>(
        listener: (BuildContext context, RegisterUserState state) {
          if (state is onLoadedState) {
            saveUserDetails(_nameController.text,fcmToken,state.id,'');

            Navigator.popAndPushNamed(context, AppRoutes.addNewHotel);
          } else if (state is ErrorState) {
            // isInvalidCredentials = true;
          }
          else if(state is onUserRegisteredState){
            if(state.restId==''){
              saveUserDetails(_nameController.text,fcmToken,state.id,'');
              Navigator.popAndPushNamed(context, AppRoutes.addNewHotel);
            }
            else{
              saveUserDetails(state.name,fcmToken,state.id,state.restId);
              Navigator.popAndPushNamed(context, AppRoutes.dashboard);
            }
          }
        },
        child: Scaffold(
          backgroundColor: AppColors.white,
          appBar: AppBar(
            leading: Container(),
            backgroundColor: AppColors.white,
            elevation: 0.0,
          ),
          body: BlocBuilder<RegisterUserBloc,RegisterUserState>(
            builder: (context,state) {
              if(state is LoadingState){
                return Center(child: CircularProgressIndicator(color: AppColors.appPrimaryColor,),);
              }
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(Strings.welcome,
                        style: AppFonts.header1
                            .copyWith(color: AppColors.appPrimaryColor)),
                    const SizedBox(height: 20.0),
                    Text(Strings.world_of_flavor,
                        style: AppFonts.subHeader
                            .copyWith(color: AppColors.textColor)),
                    const SizedBox(height: 30.0),
                    Text(Strings.enter_your_name,
                        style: AppFonts.title.copyWith(color: AppColors.textColor)),
                    const SizedBox(height: 20.0),
                    TextFieldCurvedEdges(
                      controller: _nameController,
                      backgroundColor: AppColors.white,
                      keyboardType: TextInputType.name,
                      borderColor: AppColors.borderColor,
                      borderRadius: 10,
                    ),
                    const SizedBox(height: 20.0),
                    Text(Strings.phone_number,
                        style: AppFonts.title.copyWith(color: AppColors.textColor)),
                    const SizedBox(height: 10.0),
                    RoundedContainer(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.06,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            userContactNumber,
                            style:
                                AppFonts.title.copyWith(color: AppColors.borderColor,fontSize: 18),
                          ),
                        ),
                        cornerRadius: 10),
                    Expanded(
                      child: Container(
                        alignment: Alignment.bottomCenter,
                        padding: const EdgeInsets.only(bottom: 30),
                        child: RoundedElevatedButton(
                            width: MediaQuery.of(context).size.width,
                            height: 40.0,
                            text: Strings.submit,
                            onPressed: () {
                              /*Navigator.popAndPushNamed(
                                  context, AppRoutes.homeScreen);*/
                              _registerUserBloc.add(OnRegisterButtonClicked(
                                  name: _nameController.text,
                                  number: userContactNumber,
                                  deviceId: userDeviceId,
                                  token: fcmToken));
                            },
                            cornerRadius: 6.0,
                            buttonColor: AppColors.appPrimaryColor,
                            textStyle:
                                AppFonts.header.copyWith(color: AppColors.white)),
                      ),
                    ),
                  ],
                ),
              );
            }
          ),
        ),
      ),
    );
  }

  void getUserNumber() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userContactNumber = prefs.getString('mobile_number') ?? '';
      userDeviceId = prefs.getString('device_id') ?? '';
      fcmToken = prefs.getString('fcm_token')??'';
    });
    print('this is fcm token : $fcmToken');
  }

  void saveUserDetails(String name,String token,String id,String restId) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('user_name', name);
    prefs.setString('device_id', userDeviceId);
    prefs.setString('fcm_token', token);
    prefs.setString('user_id', id);
    if(restId.isNotEmpty){
      prefs.setString('restaurant_id', restId);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }
}
