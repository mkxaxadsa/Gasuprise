import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gifting/core/app_export.dart';
import 'package:gifting/data/models/eventModel/event_model.dart';

import '../../../data/models/personModel/person_model.dart';
import '../../../widgets/custom_elevated_button.dart';

class PersonWidgetItem extends StatelessWidget {
  final List<Person> persons;
  final List<EventModel> events;
  final int index;
  final bool isDisabled;

  const PersonWidgetItem(
      {key,
      required this.persons,
      required this.events,
      this.isDisabled = false, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.v),
      height: 80.h,
      // padding: EdgeInsets.all(10.h),
      decoration: AppDecoration.surface.copyWith(
        borderRadius: BorderRadius.circular(8.h),
      ),
      child: CustomElevatedButton(
        onPressed: () {
          NavigatorService.pushNamed(AppRoutes.personInfoScreen,
              arguments: [persons, events, index]);
        },
        isDisabled: isDisabled,
        buttonStyle: CustomButtonStyles.fillGray,
        decoration: AppDecoration.surface.copyWith(
          borderRadius: BorderRadius.circular(8.h),
        ),
        text: '',
        leftIcon: Expanded(
          child: Padding(
            padding: EdgeInsets.all(10.h),
            child: Row(
              //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  width: 60.h,
                  height: 60.v,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.h),
                    child: persons[index].photo != null && persons[index].photo != ''
                        ? Image.memory(
                            base64Decode(persons[index].photo ?? ''),
                            fit: BoxFit.fitWidth,
                          )
                        : Container(
                            padding: EdgeInsets.all(15),
                            decoration: AppDecoration.fillBlueGray,
                            child: CustomImageView(
                              imagePath: ImageConstant.imgMaterialSymbol,
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
                          persons[index].name,
                          style: theme.textTheme.headlineSmall,
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            child: Text(
                              persons[index].whoIsForYou,
//                                  textAlign: TextAlign.end,
                              style: theme.textTheme.titleMedium,
                            ),
                          ),
                          Container(
                            child: Text(
                              '  |  ${persons[index].age} y.o.',
//                                  textAlign: TextAlign.end,
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
        rightIcon: !isDisabled
            ? Padding(
                padding: EdgeInsets.all(10.h),
                child: CustomImageView(
                  imagePath: ImageConstant.imgArrowRight,
                ),
              )
            : Container(),
      ),
    );
  }
}
