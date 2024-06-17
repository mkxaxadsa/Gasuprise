import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gifting/core/app_export.dart';
import 'package:gifting/data/data_manager.dart';
import 'package:gifting/widgets/custom_elevated_button.dart';
import 'package:gifting/widgets/custom_icon_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import '../../data/models/personModel/person_model.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_subtitle.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_text_form_field.dart';

class AddPersonScreen extends StatefulWidget {
  const AddPersonScreen({key});

  static Widget builder(BuildContext context) {
    return AddPersonScreen();
  }

  @override
  State<AddPersonScreen> createState() => _AddPersonScreenState();
}

class _AddPersonScreenState extends State<AddPersonScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController whoisController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  int state = 0;
  File? image;

  @override
  void initState() {
    state = 0;
    nameController.addListener(() {
      setState(() {});
    });
    whoisController.addListener(() {
      setState(() {});
    });
    ageController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.v, horizontal: 16.h),
        child:
            state == 0 ? _personDataField(context) : _personPhotoFill(context),
      ),
    );
  }

  Widget _personDataField(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildTextField(context, text: 'Name', controller: nameController),
          SizedBox(
            height: 25.v,
          ),
          _buildTextField(context,
              text: 'Who is for you', controller: whoisController),
          SizedBox(
            height: 25.v,
          ),
          _buildTextField(context,
              text: 'Age',
              controller: ageController,
              type: TextInputType.number),
          SizedBox(
            height: 25.v,
          ),
          CustomElevatedButton(
            text: 'Continue',
            isDisabled: nameController.value.text.isEmpty ||
                whoisController.value.text.isEmpty ||
                ageController.value.text.isEmpty,
            onPressed: () {
              setState(() {
                state = 1;
              });
            },
          )
        ],
      ),
    );
  }

  Widget _personPhotoFill(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.h, vertical: 16.v),
            decoration: AppDecoration.fillWhiteA
                .copyWith(borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: [
                Container(
                  height: 76.v,
                  width: 101.h,
                  /*    padding:
                      EdgeInsets.symmetric(horizontal: 28.h, vertical: 16.v),*/
                  decoration: AppDecoration.fillBlueGray
                      .copyWith(borderRadius: BorderRadiusStyle.roundedBorder8),
                  child: image == null
                      ? CustomImageView(
                          imagePath: ImageConstant.imgMaterialSymbol,
                          height: 44.adaptSize,
                          width: 44.adaptSize,
                          alignment: Alignment.center)
                      : Stack(
                          alignment: Alignment.center,
                          fit: StackFit.expand,
                          children: [
                            Container(
                              child: CustomImageView(
                                radius: BorderRadius.circular(10.h),
                                imageFile: image,
                                fit: BoxFit.fitWidth,
                              ),
                              /* Image.file(
                                File(image!.path),
                                fit: BoxFit.fitWidth,
                              ),*/
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: CustomIconButton(
                                onTap: () {
                                  setState(() {
                                    image = null;
                                  });
                                },
                                height: 30,
                                width: 30,
                                child: CustomImageView(
                                  imagePath: ImageConstant.imgRemoveCloseX,
                                ),
                              ),
                            ),
                          ],
                        ),
                ),
                SizedBox(height: 10.v),
                CustomElevatedButton(
                  text: "lbl_add_new_photo".tr,
                  onPressed: () {
                    pickImage();
                  },
                )
              ],
            ),
          ),
          SizedBox(height: 20.v),
          CustomElevatedButton(
            text: 'Done',
            // isDisabled: image == null,
            onPressed: () async {
              String base64Image = '';
              if (image != null && image != '') {
                List<int>? imageBytes = image?.readAsBytesSync();
                base64Image = base64Encode(imageBytes ?? []);
              }
              Person pers = Person(
                id: Uuid().v4(),
                name: nameController.value.text,
                whoIsForYou: whoisController.value.text,
                age: int.parse(ageController.value.text),
                photo: base64Image,
                eventsIndexes: [],
              );
              await DataManager.savePerson(pers);

              NavigatorService.pushNamedAndRemoveUntil(AppRoutes.mainScreen);
            },
          )
        ],
      ),
    );
  }

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Widget _buildTextField(BuildContext context,
      {String text = '',
      TextEditingController? controller,
      TextInputType type = TextInputType.text}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          text,
          style: theme.textTheme.bodyMedium,
        ),
        SizedBox(
          height: 12.v,
        ),
        CustomTextFormField(
          controller: controller,
          textStyle: theme.textTheme.bodyLarge,
          textInputType: type,
        ),
      ],
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
          child: Text('New person', style: theme.textTheme.headlineLarge),
        ),
      ),
    );
  }
}
