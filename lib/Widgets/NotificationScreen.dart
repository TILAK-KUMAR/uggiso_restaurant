import 'package:flutter/material.dart';
import 'package:uggiso_restaurant/base/common/utils/strings.dart';

import '../base/common/utils/colors.dart';
import '../base/common/utils/fonts.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        elevation: 0,
        title: Text(Strings.notifications,
          style: AppFonts.appBarText.copyWith(color: AppColors.white),),
        centerTitle: true,
        backgroundColor: AppColors.appPrimaryColor,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Image.asset('assets/ic_notification.png',width: 20,height: 20,),
          )
        ],
      ),
    );
  }
}
