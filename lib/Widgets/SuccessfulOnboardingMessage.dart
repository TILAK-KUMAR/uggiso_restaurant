import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uggiso_restaurant/Widgets/ui-kit/RoundedContainer.dart';
import 'package:uggiso_restaurant/Widgets/ui-kit/RoundedElevatedButton.dart';
import 'package:uggiso_restaurant/base/common/utils/colors.dart';
import 'package:uggiso_restaurant/base/common/utils/fonts.dart';
import 'package:uggiso_restaurant/base/common/utils/strings.dart';

import '../app_routes.dart';

class SuccessfulOnboardingMessage extends StatefulWidget {
  const SuccessfulOnboardingMessage({super.key});

  @override
  State<SuccessfulOnboardingMessage> createState() =>
      _SuccessfulOnboardingMessageState();
}

class _SuccessfulOnboardingMessageState
    extends State<SuccessfulOnboardingMessage> {
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
                    'assets/ic_round_tick.png',
                    width: 80,
                    height: 80,
                  ),
                  Gap(24),
                  Text(
                    Strings.verified,
                    style: AppFonts.appBarText.copyWith(fontSize: 26),
                  ),
                  Gap(24),
                  Text(
                    Strings.verified_success,
                    style: AppFonts.title,
                  ),
                  Gap(24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: RoundedElevatedButton(
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: MediaQuery.of(context).size.height * 0.05,
                        text: Strings.proceed,
                        onPressed: () {
                          saveUser();
                          Navigator.popAndPushNamed(
                              context, AppRoutes.dashboard);
                        },
                        cornerRadius: 20,
                        buttonColor: AppColors.appPrimaryColor,
                        textStyle:
                            AppFonts.header.copyWith(color: AppColors.white)),
                  )
                ],
              ),
            ),
          ),
        ));
  }

  void saveUser() async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setBool('is_user_logged_in', true);
  }
}
