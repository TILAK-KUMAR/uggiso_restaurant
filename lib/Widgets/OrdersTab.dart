import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:uggiso_restaurant/Widgets/ui-kit/RoundedContainer.dart';

import '../base/common/utils/colors.dart';
import '../base/common/utils/fonts.dart';
import '../base/common/utils/strings.dart';

class OrdersTab extends StatefulWidget {
  const OrdersTab({super.key});

  @override
  State<OrdersTab> createState() => _OrdersTabState();
}

class _OrdersTabState extends State<OrdersTab> {
  final String _title = Strings.total_orders;
  final int _totalOrderPreparing = 0;
  final int _totalOrderReady = 0;
  final int _totalOrderCompleted= 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          _title,
          style: AppFonts.appBarText.copyWith(color: AppColors.white),
        ),
        centerTitle: true,
        backgroundColor: AppColors.appPrimaryColor,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Image.asset(
              'assets/ic_notification.png',
              width: 20,
              height: 20,
            ),
          )
        ],
      ),
      body: Column(
        children: [HeaderWidget()],
      ),
    );
  }

  Widget HeaderWidget() => Container(
        height: MediaQuery.of(context).size.height * 0.15,
        decoration: const BoxDecoration(
          color: AppColors.appPrimaryColor,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(32),
              bottomRight: Radius.circular(24)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            RoundedContainer(
              color: AppColors.white,
                width: MediaQuery.of(context).size.width * 0.3,
                height: MediaQuery.of(context).size.height * 0.1,
                cornerRadius: 24,
                child: Column(
                  children: [
                    Text(Strings.preparing,style: AppFonts.title.copyWith(color: AppColors.appPrimaryColor)),
                    Gap(12),
                    Text(_totalOrderPreparing.toString(),style: AppFonts.subHeader.copyWith(color: AppColors.appPrimaryColor)),
                  ],
                )),
            RoundedContainer(
              color: AppColors.white,
                width: MediaQuery.of(context).size.width * 0.3,
                height: MediaQuery.of(context).size.height * 0.1,
                cornerRadius: 24,
                child: Column(
                  children: [
                    Text(Strings.ready,style: AppFonts.title.copyWith(color: AppColors.appPrimaryColor)),
                    Gap(12),
                    Text(_totalOrderReady.toString(),style: AppFonts.subHeader.copyWith(color: AppColors.appPrimaryColor)),
                  ],
                )),
            RoundedContainer(
              color: AppColors.white,
                width: MediaQuery.of(context).size.width * 0.3,
                height: MediaQuery.of(context).size.height * 0.1,
                cornerRadius: 24,
                child:  Column(
                  children: [
                    Text(Strings.completed,style: AppFonts.title.copyWith(color: AppColors.appPrimaryColor)),
                    Gap(12),
                    Text(_totalOrderCompleted.toString(),style: AppFonts.subHeader.copyWith(color: AppColors.appPrimaryColor)),
                  ],
                ))
          ],
        ),
      );
}
