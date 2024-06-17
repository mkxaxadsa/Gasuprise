import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gifting/core/app_export.dart';
import 'package:gifting/data/data_manager.dart';
import 'package:gifting/data/models/eventModel/event_model.dart';
import 'package:gifting/data/models/eventModel/gift_model/gift_model.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '../../data/models/personModel/person_model.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_subtitle.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_text_form_field.dart';

class AddEventScreen extends StatefulWidget {
  final List<Person> personList;

  const AddEventScreen({key, required this.personList});

  static Widget builder(BuildContext context, List<Person> personList) {
    return AddEventScreen(
      personList: personList,
    );
  }

  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  int screenState = 0;
  int selectedPersonIndex = -1;
  int willThereIndex = -1;
  double costAmount = 0;

  TextEditingController nameController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  List<Gift> giftsList = [Gift(giftName: '', price: 0)];

  @override
  void initState() {
    screenState = 0;
    selectedPersonIndex = -1;
    willThereIndex = -1;
    nameController.addListener(() {
      setState(() {});
    });
    dateController.addListener(() {
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
        child: SingleChildScrollView(
          child: _buildStates(context),
        ),
      ),
    );
  }

  Widget _buildStates(BuildContext context) {
    if (screenState == 0)
      return _personChooseState(context);
    else if (screenState == 1) {
      return _eventDataFillState(context);
    } else {
      return _buildGiftState(context);
    }
  }

//1 state
  Widget _personChooseState(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Choose whom to congratulate',
          style: theme.textTheme.bodyMedium,
        ),
        SizedBox(
          height: 20.v,
        ),
        Column(
          children: widget.personList.asMap().entries.map((entry) {
            int index = entry.key;
            Person person = entry.value;
            return Container(
              margin: EdgeInsets.symmetric(vertical: 8.v),
              height: 80.h,
              child: CustomElevatedButton(
                buttonStyle: CustomButtonStyles.fillGray,
                decoration: AppDecoration.surface.copyWith(
                  borderRadius: BorderRadius.circular(8.h),
                ),
                text: '',
                onPressed: () => setState(() {
                  if (selectedPersonIndex == index) {
                    selectedPersonIndex = -1;
                  } else
                    selectedPersonIndex = index ?? -1;
                }),
                leftIcon: Expanded(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 10.v, horizontal: 2.h),
                    child: Row(
                      //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Transform.scale(
                          scale: 1.3,
                          //height: 80,
                          child: Checkbox(
                            fillColor:
                                MaterialStateProperty.all(Colors.transparent),
                            side: MaterialStateBorderSide.resolveWith((states) {
                              return BorderSide(
                                color: theme.colorScheme.primary,
                              );
                            }),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(2),
                            ),
                            checkColor: theme.colorScheme.primary,
                            activeColor: theme.colorScheme.primary,
                            value: selectedPersonIndex == index,
                            onChanged: (bool? value) => {
                              setState(() {
                                if (selectedPersonIndex == index) {
                                  selectedPersonIndex = -1;
                                } else
                                  selectedPersonIndex = index ?? -1;
                              })
                            },
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                          ),
                        ),
                        Container(
                          width: 60.h,
                          height: 60.v,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.h),
                            child: person.photo != null && person.photo != ''
                                ? Image.memory(
                                    base64Decode(person.photo ?? ''),
                                    fit: BoxFit.fitWidth,
                                  )
                                : Container(
                                    padding: EdgeInsets.all(15),
                                    decoration: AppDecoration.fillBlueGray,
                                    child: CustomImageView(
                                      imagePath:
                                          ImageConstant.imgMaterialSymbol,
                                    ),
                                  ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 11.h),
                          //width: 106.h,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Text(
                                  person.name,
                                  style: theme.textTheme.headlineSmall,
                                ),
                              ),
                              Row(
                                children: [
                                  Container(
                                    child: Text(
                                      person.whoIsForYou,
                                      style: theme.textTheme.titleMedium,
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      '  |  ${person.age} y.o.',
                                      style: theme.textTheme.titleMedium
                                          ?.copyWith(color: appTheme.gray700),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        SizedBox(height: 15.v),
        CustomElevatedButton(
          text: 'Continue',
          isDisabled: selectedPersonIndex <= -1,
          onPressed: () {
            setState(() {
              screenState++;
            });
          },
        )
      ],
    );
  }

//2 State
  Widget _eventDataFillState(BuildContext context) {
    return Column(
      children: [
        _buildTextField(context,
            text: 'Name of the holiday', controller: nameController),
        SizedBox(
          height: 16.v,
        ),
        _buildTextField(
          context,
          text: 'Date of the holiday',
          type: TextInputType.datetime,
          controller: dateController,
          readOnly: true,
          onTap: () {
            onTapFunction(context);
          },
        ),
        SizedBox(
          height: 16.v,
        ),
        Container(
          width: double.infinity,
          child: Text(
            'Will there be an celebration?',
            style: theme.textTheme.bodyMedium,
          ),
        ),
        SizedBox(
          height: 12.v,
        ),
        Row(
          children: [
            Expanded(child: _customSwitch(context, label: 'Yes', index: 0)),
            SizedBox(
              width: 12.v,
            ),
            Expanded(child: _customSwitch(context, label: 'No', index: 1)),
          ],
        ),
        SizedBox(
          height: 12.v,
        ),
        CustomElevatedButton(
          text: 'Continue',
          isDisabled: willThereIndex == -1 ||
              nameController.value.text.isEmpty ||
              dateController.value.text.isEmpty,
          onPressed: () {
            setState(() {
              screenState++;
            });
          },
        )
      ],
    );
  }

  Widget _buildTextField(
    BuildContext context, {
    String text = '',
    TextEditingController? controller,
    TextInputType type = TextInputType.text,
    bool readOnly = false,
    Function? onTap,
  }) {
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
          readOnly: readOnly,
          controller: controller,
          textStyle: theme.textTheme.bodyLarge,
          textInputType: type,
          onTap: () {
            onTap?.call();
          },
        ),
      ],
    );
  }

  Widget _customSwitch(BuildContext context,
      {String label = '', int index = -1, Function? onTap}) {
    return InkWell(
      onTap: () {
        setState(() {
          willThereIndex = index;
        });
      },
      child: Material(
        type: MaterialType.transparency,
        child: Container(
          height: 52.h,
          decoration: customBoxDecoration(index == willThereIndex),
          child: Center(
            child: Text(
              label,
              style: theme.textTheme.titleMedium?.copyWith(color: Colors.black),
            ),
          ),
        ),
      ),
    );
  }

  bool areAllFieldsFilled() {
    for (var gift in giftsList) {
      if (gift.giftName.isEmpty || gift.price == 0.0) {
        return false;
      }
    }
    return true;
  }

  String _price = '';

  //3 state
  Widget _buildGiftState(BuildContext context) {
    double total = giftsList.fold(
        0, (previousValue, element) => previousValue + element.price);

    return Column(
      children: [
        Container(
          height: 30.v,
          decoration: AppDecoration.accent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Center(
                child: Text(
                  'Cost amount',
                  style: CustomTextStyles.titleMediumGray700,
                ),
              ),
              Center(
                child: Text(
                  '${total}\$',
                  style: theme.textTheme.titleMedium,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 16.v,
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: giftsList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 8.v),
              child: _giftItem(context, gift: giftsList[index], index: index),
            );
          },
        ),
        SizedBox(
          height: 16.v,
        ),
        if (giftsList[0].giftName.isNotEmpty && giftsList[0].price > 0)
          Container(
            margin: EdgeInsets.only(bottom: 16.h),
            child: CustomElevatedButton(
              text: 'Add more Gift',
              buttonTextStyle:
                  theme.textTheme.titleMedium?.copyWith(color: Colors.black),
              buttonStyle: CustomButtonStyles.outlinePrimaryTL8,
              onPressed: () {
                setState(() {
                  giftsList.add(Gift(giftName: '', price: 0));
                });
              },
            ),
          ),
        CustomElevatedButton(
          text: 'Done',
          isDisabled: !areAllFieldsFilled(),
          onPressed: () {
            EventModel event = EventModel(
                id: Uuid().v4(),
                name: nameController.value.text,
                date: pickedDate ?? DateTime.now(),
                willThereBeCelebration: willThereIndex == 0,
                gifts: giftsList,
                personIndex: widget.personList[selectedPersonIndex].id);

            widget.personList[selectedPersonIndex].eventsIndexes.add(event.id);
            DataManager.savePerson(widget.personList[selectedPersonIndex]);
            DataManager.saveEvent(event);
            NavigatorService.pushNamedAndRemoveUntil(AppRoutes.mainScreen);
          },
        )
      ],
    );
  }

  Widget _giftItem(BuildContext context, {required Gift gift, int index = -1}) {
    FocusNode focusNode = FocusNode();
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.v, horizontal: 12.h),
      decoration: AppDecoration.fillWhiteA
          .copyWith(borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            child: Text(
              'Gift ${index + 1}',
              style: CustomTextStyles.titleMediumOnPrimary,
            ),
          ),
          SizedBox(
            height: 10.v,
          ),
          CustomTextFormField(
            autofocus: true,
            hintText: 'Gift name',
            textInputAction: TextInputAction.done,
            hintStyle: CustomTextStyles.titleMediumGray700,
            textStyle: CustomTextStyles.titleMediumOnPrimary,
            initialValue: gift.giftName,
            onChanged: (value) {
              setState(() {
                gift.giftName = value;
              });
            },
          ),
          SizedBox(
            height: 10.v,
          ),
          CustomTextFormField(
            autofocus: true,
            textInputAction: TextInputAction.done,
            hintText: 'Price',
            initialValue: gift.price == 0 ? null : gift.price.toString(),
            textInputType: TextInputType.number,
            hintStyle: CustomTextStyles.titleMediumGray700,
            textStyle: CustomTextStyles.titleMediumOnPrimary,
            onChanged: (value) {
              setState(() {
                if (value.isEmpty) {
                  gift.price = 0;
                } else {
                  gift.price = double.parse(value) ?? 0;
                }
              });
            },
          ),
        ],
      ),
    );
  }

  setIndeed(Gift gift, double value) {}

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

  DateTime? pickedDate;

  onTapFunction(BuildContext context) async {
    pickedDate = await showDatePicker(
      context: context,
      lastDate: DateTime(2077),
      firstDate: DateTime.now(),
      initialDate: DateTime.now(),
    );
    if (pickedDate == null) {
      return;
    }
    dateController.text =
        DateFormat('MM/dd/yyyy').format(pickedDate ?? DateTime.now());
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 40.h,
      height: 90,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgArrowLeft,
        margin: EdgeInsets.only(left: 16.h),
        onTap: () {
          if (screenState > 0) {
            setState(() {
              screenState--;
            });
          } else {
            NavigatorService.goBack();
          }
        },
      ),
      title: AppbarSubtitle(
        text: 'Back',
        margin: EdgeInsets.only(left: 8.h),
        onTap: () {
          if (screenState > 0) {
            setState(() {
              screenState--;
            });
          } else {
            NavigatorService.goBack();
          }
        },
      ),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(30.0),
        child: Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text('New event', style: theme.textTheme.headlineLarge),
        ),
      ),
    );
  }
}
