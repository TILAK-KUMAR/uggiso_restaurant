import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:uggiso_restaurant/Widgets/ui-kit/RoundedContainer.dart';
import 'package:uggiso_restaurant/Widgets/ui-kit/RoundedElevatedButton.dart';

import '../app_routes.dart';
import '../base/common/utils/colors.dart';
import '../base/common/utils/fonts.dart';
import '../base/common/utils/strings.dart';

class OnboardingPending extends StatefulWidget {
  const OnboardingPending({super.key});

  @override
  State<OnboardingPending> createState() => _OnboardingPendingState();
}

class _OnboardingPendingState extends State<OnboardingPending> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.textFieldBg,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: RoundedContainer(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.35,
              cornerRadius: 18,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Gap(16),
                  Image.asset(
                    'assets/ic_onboarding_success.png',
                    width: 80,
                    height: 80,
                  ),
                  Gap(24),
                  Text(
                    Strings.thankyou,
                    style: AppFonts.subHeader.copyWith(fontWeight: FontWeight.w600,color: AppColors.appPrimaryColor),
                  ),
                  Gap(24),
                  Text(
                    Strings.verified_success,
                    style: AppFonts.title.copyWith(fontSize: 14),
                  ),
                  Gap(24),
                  RoundedElevatedButton(
                    onPressed: () {
                      exit(0);
                      // Navigator.pop(context); // Close the bottom sheet
                    },
                    width: MediaQuery.of(context).size.width*0.2,
                    height: MediaQuery.of(context).size.height*0.04,
                    text: 'OK',
                    cornerRadius: 18,
                    buttonColor: AppColors.appPrimaryColor,
                    textStyle: AppFonts.header.copyWith(color: AppColors.white),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
