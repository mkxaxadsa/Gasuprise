import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:gifting/core/app_export.dart';
import 'package:gifting/widgets/app_bar/custom_app_bar.dart';
import 'package:in_app_review/in_app_review.dart';

import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_subtitle.dart';
import '../../widgets/custom_elevated_button.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({key});

  static Widget builder(BuildContext context) {
    return SettingsScreen();
  }

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: Padding(
        padding: EdgeInsets.all(20.h),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.h, vertical: 16.v),
              decoration: AppDecoration.surface
                  .copyWith(borderRadius: BorderRadiusStyle.roundedBorder8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomImageView(
                      imagePath: ImageConstant.imgImage2,
                      height: 201.adaptSize,
                      width: 201.adaptSize),
                  SizedBox(height: 32.v),
                  Text('Your opinion is important!',
                      style: theme.textTheme.headlineSmall),
                  SizedBox(height: 10.v),
                  Text('We need your feedback to get better',
                      style: CustomTextStyles.titleMediumGray700),
                  SizedBox(height: 29.v),
                  CustomElevatedButton(
                    text: 'Rate app',
                    onPressed: () {
                      InAppReview.instance
                          .openStoreListing(appStoreId: '6504483229');
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.v),
            _buildButton(context,
                imagePath: ImageConstant.imgPaper,
                text: 'Terms of use', onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                    builder: (BuildContext context) => const ViewProfile(
                          url:
                              'https://docs.google.com/document/d/1DCu5M5Rvh4fesBpul6JNt8E6KrjEpq6043YItIAaHlk/edit?usp=sharing',
                        )),
              );
            }),
            SizedBox(height: 16.v),
            _buildButton(context,
                imagePath: ImageConstant.imgPrivacy,
                text: 'Privacy Policy', onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                    builder: (BuildContext context) => const ViewProfile(
                          url:
                              'https://docs.google.com/document/d/1U1f4JsrBuPrg8kgc1LoIBmgPsjSuGQt5q0HY_Q8xTYM/edit?usp=sharing',
                        )),
              );
            }),
            SizedBox(height: 16.v),
            _buildButton(context,
                imagePath: ImageConstant.imgNotes, text: 'Support', onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                    builder: (BuildContext context) => const ViewProfile(
                          url: 'https://forms.gle/QiUEP7wa7dvpFRrx5',
                        )),
              );
            })
          ],
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context,
      {String imagePath = '', String text = '', VoidCallback? onTap}) {
    return Container(
      height: 60,
      child: ElevatedButton(
        style: CustomButtonStyles.fillGray,
        onPressed: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CustomImageView(
                    imagePath: imagePath,
                  ),
                  SizedBox(
                    width: 8.h,
                  ),
                  Text(
                    text,
                    style: CustomTextStyles.titleMediumBluegray900,
                  ),
                ],
              ),
              CustomImageView(
                imagePath: ImageConstant.imgArrowRight,
                color: Colors.black,
              )
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 40.h,
      height: 90,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgArrowLeft,
        margin: EdgeInsets.only(left: 16.h),
        onTap: () {
          NavigatorService.goBack();
        },
      ),
      title: AppbarSubtitle(
        text: 'Back',
        margin: EdgeInsets.only(left: 8.h),
        onTap: () {
          NavigatorService.goBack();
        },
      ),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(30.0),
        child: Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text('Settings', style: theme.textTheme.headlineLarge),
        ),
      ),
    );
  }
}

class ViewProfile extends StatelessWidget {
  final String url;

  const ViewProfile({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
      ),
      body: SafeArea(
        bottom: false,
        child: InAppWebView(
          initialUrlRequest: URLRequest(url: Uri.parse(url)),
        ),
      ),
    );
  }
}
