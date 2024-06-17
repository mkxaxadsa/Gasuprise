import 'package:flutter/material.dart';
import 'package:gifting/core/app_export.dart';
import 'package:gifting/widgets/custom_elevated_button.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({Key? key})
      : super(
          key: key,
        );

  static Widget builder(BuildContext context) {
    return OnboardingScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        padding: EdgeInsets.symmetric(horizontal: 16.h),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 100.v),
              CustomImageView(
                imagePath: ImageConstant.imgImage1,
                height: 266.v,
                width: 303.h,
              ),
              SizedBox(height: 30.v),
              Container(
                width: 317.h,
                margin: EdgeInsets.only(
                  left: 13.h,
                  right: 12.h,
                ),
                child: Text(
                  'Congratulate your\nloved ones',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.displaySmall!.copyWith(
                    height: 1.11,
                  ),
                ),
              ),
              SizedBox(height: 54.v),
              Container(
                width: 328.h,
                margin: EdgeInsets.only(
                  left: 6.h,
                  right: 7.h,
                ),
                child: Text(
                  'Write down the dates of birth of your loved\nones so as not to forget to congratulate',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: CustomTextStyles.titleMediumOnPrimary.copyWith(
                    height: 1.25,
                  ),
                ),
              ),
              SizedBox(height: 28.v),
              CustomElevatedButton(
                text: 'Continue',
                onPressed: () {
                  NavigatorService.pushNamed(AppRoutes.welcomeScreen);
                },
              ),
              // SizedBox(height: 5.v),
            ],
          ),
        ),
      ),
    );
  }
}
