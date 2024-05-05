import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../base/common/utils/colors.dart';
import '../base/common/utils/fonts.dart';
import '../base/common/utils/strings.dart';

class PaymentsTab extends StatefulWidget {
  const PaymentsTab({super.key});

  @override
  State<PaymentsTab> createState() => _PaymentsTabState();
}

class _PaymentsTabState extends State<PaymentsTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appPrimaryColor,
      appBar: AppBar(
        elevation: 0,
        title: Text(Strings.payments,
          style: AppFonts.appBarText.copyWith(color: AppColors.white),),
        centerTitle: true,
        backgroundColor: AppColors.appPrimaryColor,
      ),
      body: Container(
        padding: EdgeInsets.only(top: 20),
        decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32), topRight: Radius.circular(24)),
        ),
        width: double.infinity,
        height: double.infinity,
        child:
            Center(child: Text('No Payments Received Yet',style: AppFonts.title,),),
      ),
    );
  }
}
