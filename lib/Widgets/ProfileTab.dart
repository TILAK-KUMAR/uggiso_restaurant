import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:uggiso_restaurant/Widgets/ui-kit/ImageTitle.dart';
import 'package:uggiso_restaurant/Widgets/ui-kit/RoundedContainer.dart';

import '../base/common/utils/colors.dart';
import '../base/common/utils/fonts.dart';
import '../base/common/utils/strings.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appPrimaryColor,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          Strings.profile,
          style: AppFonts.appBarText.copyWith(color: AppColors.white),
        ),
        centerTitle: true,
        backgroundColor: AppColors.appPrimaryColor,
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 70.0),
            child: Container(
              padding: EdgeInsets.only(top: 0),
              decoration: const BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(24)),
              ),
              width: double.infinity,
              height: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(top:150.0,left: 16,right: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(width: 290,color: Colors.red,),
                    RowItem('assets/ic_bank.png',Strings.bank_account),
                    Gap(12),
                    Container(height: 1,color: AppColors.grey,),
                    RowItem('assets/ic_card.png', Strings.aadhar_card),
                    Gap(12),
                    Container(height: 1,color: AppColors.grey,),

                    RowItem('assets/ic_invite_friends.png',Strings.invite_friends),
                    Gap(12),
                    Container(height: 1,color: AppColors.grey,),

                    RowItem('assets/ic_help.png', Strings.help_support),
                    Gap(12),
                    Container(height: 1,color: AppColors.grey,),

                    RowItem('assets/ic_terms_conditions.png',Strings.terms_conditions),
                    Gap(12),
                    Container(height: 1,color: AppColors.grey,),

                    RowItem('assets/ic_logout.png', Strings.logout),
                    Gap(12),
                    Container(height: 1,color: AppColors.grey,),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                RoundedContainer(
                    color: AppColors.grey,
                    width: MediaQuery.of(context).size.width * 0.3,
                    height: MediaQuery.of(context).size.height * 0.14,
                    child: Image.asset('assets/ic_person.png',height: 100,width: 100,),
                    cornerRadius: 200),
                Gap(12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/ic_edit.png',height: 12,width: 12,),

                    Gap(8),
                    Text('Tilak',style: AppFonts.title.copyWith(color: AppColors.headerColor),)
                  ],
                ),
                Gap(12),
                Text('9964367047',style: AppFonts.title.copyWith(color: AppColors.headerColor),)

              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget RowItem(String image, String title){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(image,width: 24,height: 24,),
          SizedBox(width: 24,),
          Text(title,style: AppFonts.title,)
        ],
      ),
    );
  }
}
