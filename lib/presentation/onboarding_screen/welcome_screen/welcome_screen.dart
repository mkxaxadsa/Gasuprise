import 'package:flutter/material.dart';
import 'package:gifting/core/app_export.dart';
import 'package:gifting/widgets/app_bar/appbar_leading_image.dart';
import 'package:gifting/widgets/app_bar/appbar_subtitle.dart';
import 'package:gifting/widgets/app_bar/custom_app_bar.dart';
import 'package:gifting/widgets/custom_elevated_button.dart';
import 'package:gifting/widgets/custom_text_form_field.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  static Widget builder(BuildContext context) {
    return WelcomeScreen();
  }

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  List options = [
    {'title': '1-5', 'isActive': false},
    {'title': '5-10', 'isActive': false},
    {'title': '10-30', 'isActive': false},
    {'title': 'More than 30', 'isActive': false},
  ];

  bool isOptionChoose = false;

  TextEditingController _textFieldController = TextEditingController();

  bool isTextFieldFilled() {
    setState(() {});
    return _textFieldController.text.isNotEmpty;
  }

  String _textFieldValue = '';

  @override
  void initState() {
    super.initState();
    _textFieldController.addListener(_updateTextFieldValue);
  }

  void _updateTextFieldValue() {
    setState(() {
      _textFieldValue = _textFieldController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.v, horizontal: 16.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'What\'s your name?',
                style: theme.textTheme.bodyMedium,
              ),
              SizedBox(
                height: 16.v,
              ),
              CustomTextFormField(
                controller: _textFieldController,
                textStyle: theme.textTheme.bodyLarge,
              ),
              SizedBox(
                height: 16.v,
              ),
              _buildChooser(context),
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
          child: Text('Welcome!', style: theme.textTheme.headlineLarge),
        ),
      ),
    );
  }

  Widget _buildChooser(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'How many loved ones do you have, to whom do\nyou give gifts?',
            style: theme.textTheme.bodyMedium,
          ),
        ),
        SizedBox(
          height: 16.v,
        ),
        Column(
          children: options
              .map(
                (option) => Container(
                  margin: EdgeInsets.symmetric(vertical: 8.v),
                  height: 52.v,
                  //width: double.infinity,
                  decoration: customBoxDecoration(option['isActive']),
                  child: InkWell(
                    onTap: () {
                      changeState(option);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.h),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '${option['title']}',
                          textAlign: TextAlign.start,
                          style: theme.textTheme.titleMedium
                              ?.copyWith(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
        SizedBox(
          height: 16.v,
        ),
        CustomElevatedButton(
          text: 'Continue',
          isDisabled: !isOptionChoose || !isTextFieldFilled(),
          onPressed: () {
            NavigatorService.pushNamedAndRemoveUntil(AppRoutes.mainScreen);
          },
        ),
      ],
    );
  }

  changeState(option) {
    setState(() {
      for (var item in options) {
        if (item == option) {
          isOptionChoose = true;
          item['isActive'] = true;
        } else {
          item['isActive'] = false;
        }
      }
    });
  }

  customBoxDecoration(isActive) {
    return BoxDecoration(
      color: isActive ? appTheme.red100 : appTheme.gray300,
      border: isActive
          ? Border.all(color: theme.colorScheme.primary)
          : Border.all(color: appTheme.gray300),
      borderRadius: const BorderRadius.all(
        Radius.circular(8.0),
      ),
    );
  }
}
