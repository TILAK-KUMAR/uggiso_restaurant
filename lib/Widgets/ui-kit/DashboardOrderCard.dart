import 'package:flutter/material.dart';
import 'package:uggiso_restaurant/Widgets/ui-kit/RoundedContainer.dart';
import 'package:uggiso_restaurant/base/common/utils/colors.dart';
import 'package:uggiso_restaurant/base/common/utils/fonts.dart';

class DashboardOrderCard extends StatefulWidget {
  const DashboardOrderCard({super.key});

  @override
  State<DashboardOrderCard> createState() => _DashboardOrderCardState();
}

class _DashboardOrderCardState extends State<DashboardOrderCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RoundedContainer(
                width: MediaQuery
                    .of(context)
                    .size
                    .width * 0.2,
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.02,
                child: Text(
                  'ID:001', style: AppFonts.smallText.copyWith(fontSize: 14),),
                cornerRadius: 20,
                color: AppColors.appPrimaryColor,)
            ],
          )
        ],
      ),
    );
  }

}
