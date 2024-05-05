import 'package:flutter/material.dart';
import 'package:uggiso_restaurant/base/common/utils/colors.dart';

class AppBarBackIcon extends StatelessWidget {
  const AppBarBackIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset('assets/ic_back.png',width: 16,height: 16,color: AppColors.white,);
  }
}
