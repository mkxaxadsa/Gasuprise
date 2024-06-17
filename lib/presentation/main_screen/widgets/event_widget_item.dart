import 'package:flutter/material.dart';
import 'package:gifting/core/app_export.dart';
import 'package:gifting/data/models/eventModel/event_model.dart';
import 'package:intl/intl.dart';

import '../../../data/models/personModel/person_model.dart';
import '../../../widgets/custom_elevated_button.dart';

class EventWidgetItem extends StatelessWidget {
  final List<EventModel> event;
  final List<Person> persons;
  final bool isDisabled;
  final int index;

  const EventWidgetItem(
      {key,
      required this.event,
      required this.persons,
      this.isDisabled = false, required this.index});

  @override
  Widget build(BuildContext context) {
    double total = event[index].gifts
        .fold(0, (previousValue, gift) => previousValue + gift.price);
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.v),
      height: 120.h,
      // padding: EdgeInsets.all(10.h),
      decoration: AppDecoration.surface.copyWith(
        borderRadius: BorderRadius.circular(8.h),
      ),
      child: CustomElevatedButton(
        onPressed: () {
          NavigatorService.pushNamed(AppRoutes.eventInfoScreen,
              arguments: [persons, event, index]);
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
            child: Column(
              //crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Text(
                              event[index].name,
                              style: theme.textTheme.headlineSmall,
                            ),
                          ),
                          Container(
                            child: Text(
                              DateFormat('dd.MM.yyyy').format(event[index].date),
                              style: theme.textTheme.bodyMedium,
                            ),
                          ),
                        ],
                      ),
                      !isDisabled
                          ? Padding(
                              padding: EdgeInsets.all(10.h),
                              child: CustomImageView(
                                imagePath: ImageConstant.imgArrowRight,
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.v,
                ),
                Container(
                  padding: EdgeInsets.only(top: 10.v),
                  decoration: AppDecoration.seconrady,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        event[index].gifts.length.toString() + ' gift',
                        style: theme.textTheme.bodyMedium,
                      ),
                      Text(
                        total.toString() + '\$',
                        style: theme.textTheme.bodyMedium
                            ?.copyWith(color: theme.colorScheme.primary),
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
  }
}
