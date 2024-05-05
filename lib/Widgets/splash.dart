import 'dart:async';
import 'package:flutter/material.dart';
import '../app_routes.dart';
import '../base/common/utils/colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3),
            ()=>Navigator.popAndPushNamed(context, AppRoutes.addNewHotel)
    );
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
}
