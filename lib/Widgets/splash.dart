import 'dart:async';
import 'package:device_uuid/device_uuid.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../app_routes.dart';
import '../base/common/utils/colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? deviceId = '';
  String? restId = '';

  @override
  void initState() {
    super.initState();
    getDeviceId();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
          color: AppColors.appPrimaryColor,
          child:Image.asset('assets/uggiso_splash.png',width: 200,height: 200)
    );
  }
  void getDeviceId()async{
    final prefs = await SharedPreferences.getInstance();
    deviceId = await DeviceUuid().getUUID();
    prefs.setString('device_id', deviceId!);
    restId = prefs.getString('restaurant_id');
    print('this is restaurant id :$restId');
    Timer(Duration(seconds: 3),
            ()=>Navigator.popAndPushNamed(context, AppRoutes.registerUser)
    );
  }
}
