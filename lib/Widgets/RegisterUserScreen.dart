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
            // Navigate to the next screen when NavigationState is emitted
            saveUserDetails(_nameController.text, '', '',state.id);

            Navigator.popAndPushNamed(context, AppRoutes.addNewHotel);
          } else if (state is ErrorState) {
            // isInvalidCredentials = true;
          }
        },
        child: Scaffold(
          backgroundColor: AppColors.white,
          appBar: AppBar(
            leading: Container(),
            backgroundColor: AppColors.white,
            elevation: 0.0,
          ),
          body: Padding(
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
                  backgroundColor: AppColors.textFieldBg,
                  keyboardType: TextInputType.name,
                  borderColor: AppColors.textFieldBorderColor,
                  borderRadius: 6,
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
                        '$userContactNumber',
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
                              deviceId: "TilaksDevice",
                              token: "FcmTokenId"));
                        },
                        cornerRadius: 6.0,
                        buttonColor: AppColors.appPrimaryColor,
                        textStyle:
                            AppFonts.header.copyWith(color: AppColors.white)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void getUserNumber() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userContactNumber = prefs.getString('mobile_number') ?? '';
    });
  }

  void saveUserDetails(String name, String deviceId, String token,String id) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('user_name', name);
    prefs.setString('device_id', deviceId);
    prefs.setString('fcm_token', token);
    prefs.setString('user_id', id);
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }
}
