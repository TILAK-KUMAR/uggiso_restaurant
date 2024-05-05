import 'package:flutter/material.dart';

import '../../base/common/utils/colors.dart';
import '../../base/common/utils/fonts.dart';
import '../../base/common/utils/strings.dart';
import 'RoundedContainer.dart';


class ProfileHeader extends StatelessWidget {
  final String imageUrl;
  final String userName;
  final String mail;
  final String address;

  const ProfileHeader({
    Key? key,
    this.imageUrl = 'assets/ic_person.png',
    required this.userName,
    this.mail = '',
    this.address = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        height: MediaQuery.of(context).size.height*0.25,
        decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
            topRight: Radius.circular(30),
            topLeft: Radius.circular(30),
          ),
      ),
        padding: EdgeInsets.symmetric(horizontal: 18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            ProfileRow(context, imageUrl, userName, mail),
            SizedBox(height: 20),
            Text(
              Strings.saved_address,
              style: AppFonts.title.copyWith(color: AppColors.headerColor),
            ),
            SizedBox(height: 10),
            Text(
              address,
              style: AppFonts.subHeader.copyWith(color: AppColors.headerColor),
            ),
          ],
        ),
      ),
    );
  }

  Widget ProfileRow(BuildContext context, String imageUrl, String userName,
          String mail) =>
      Row(
        children: [
          RoundedContainer(
              width: MediaQuery.of(context).size.width * 0.25,
              height: MediaQuery.of(context).size.height * 0.11,
              cornerRadius: 100,
              color: AppColors.textFieldBorderColor,
              child: Image.asset(
                imageUrl,
                height: 30,
                width: 30,
              )),
          SizedBox(
            width: 30,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userName,
                style: AppFonts.title.copyWith(color: AppColors.textColor),
              ),
              Text(
                mail,
                style: AppFonts.title.copyWith(color: AppColors.textColor),
              )
            ],
          ),
        ],
      );
}
