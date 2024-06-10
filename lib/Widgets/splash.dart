import 'dart:async';
import 'package:device_uuid/device_uuid.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uggiso_restaurant/Network/apiRepository.dart';
import '../app_routes.dart';
import '../base/common/utils/LocationManager.dart';
import '../base/common/utils/colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  String? deviceId = '';
  String? restId = '';
  String? fcmToken = '';

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
    LocationInfo _location = await LocationManager.getCurrentPosition();
    prefs.setDouble('user_longitude', _location.longitude);
    prefs.setDouble('user_latitude', _location.latitude);
    initFirebaseMessaging();

    restId = prefs.getString('restaurant_id');

      if(restId==null) {
        Navigator.popAndPushNamed(context, AppRoutes.signupScreen);
      }
      else{
        var res = await getRestaurantStatus(restId);
        var _isRegistered = res.restaurantStatus.toString();

        if(_isRegistered=='CREATED'){
          Navigator.popAndPushNamed(context, AppRoutes.successOnboarding);
        }
        else{
          Navigator.popAndPushNamed(context, AppRoutes.dashboard);
        }
      }
  }

  Future getRestaurantStatus(String? id) async{
    var res = await ApiRepository().getRestaurantStatus(id!);
    return res.payload;
  }

  void initFirebaseMessaging() {
    _firebaseMessaging.getToken().then((token) {
      print("FCM Token: $token");
      setState(() {
        fcmToken = token;
      });
    });
  }
}
