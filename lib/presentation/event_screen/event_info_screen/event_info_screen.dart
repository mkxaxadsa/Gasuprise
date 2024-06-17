import 'package:flutter/material.dart';
import 'package:gifting/core/app_export.dart';
import 'package:gifting/presentation/main_screen/widgets/event_widget_item.dart';

import '../../../data/data_manager.dart';
import '../../../data/models/eventModel/event_model.dart';
import '../../../data/models/personModel/person_model.dart';
import '../../../widgets/app_bar/appbar_leading_image.dart';
import '../../../widgets/app_bar/appbar_subtitle.dart';
import '../../../widgets/app_bar/custom_app_bar.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../../main_screen/widgets/person_widget_item.dart';

class EventInfoScreen extends StatefulWidget {
  final List<Person> persons;
  final List<EventModel> events;
  final int index;

  const EventInfoScreen(
      {key, required this.persons, required this.events, required this.index});

  static Widget builder(BuildContext context, List<Person> persons,
      List<EventModel> events, int index) {
    return EventInfoScreen(
      persons: persons,
      events: events,
      index: index,
    );
  }

  @override
  State<EventInfoScreen> createState() => _EventInfoScreenState();
}

class _EventInfoScreenState extends State<EventInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      floatingActionButton: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 20.v),
        child: CustomElevatedButton(
          text: 'Delete',
          onPressed: () {
            DataManager.deleteEvent(widget.events[widget.index].id);
            NavigatorService.pushNamedAndRemoveUntil(AppRoutes.mainScreen);
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 20.v),
        child: Column(
          children: [
            EventWidgetItem(
              event: widget.events,
              persons: widget.persons,
              isDisabled: true,
              index: widget.index,
            ),
            SizedBox(
              height: 30.v,
            ),
            Container(
              width: double.infinity,
              child: Text(
                'Gift',
                style: theme.textTheme.titleMedium
                    ?.copyWith(color: appTheme.gray700),
              ),
            ),
            SizedBox(
              height: 10.v,
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: widget.events[widget.index].gifts.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 4.v),
                  height: 35.h,
                  padding: EdgeInsets.all(10.h),
                  decoration: AppDecoration.surface.copyWith(
                    borderRadius: BorderRadius.circular(8.h),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.events[widget.index].gifts[index].giftName,
                        style: theme.textTheme.bodyMedium,
                      ),
                      Text(
                        widget.events[widget.index].gifts[index].price
                                .toString() +
                            '\$',
                        style: theme.textTheme.bodyMedium
                            ?.copyWith(color: theme.colorScheme.primary),
                      ),
                    ],
                  ),
                );
              },
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 4.v),
              height: 35.h,
              padding: EdgeInsets.all(10.h),
              decoration: AppDecoration.surface.copyWith(
                borderRadius: BorderRadius.circular(8.h),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Cost amount',
                    style: theme.textTheme.bodyMedium
                        ?.copyWith(color: theme.colorScheme.primary),
                  ),
                  Text(
                    getCostAmount() + '\$',
                    style: theme.textTheme.bodyMedium
                        ?.copyWith(color: theme.colorScheme.primary),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30.v,
            ),
            Container(
              width: double.infinity,
              child: Text(
                'Person',
                style: theme.textTheme.titleMedium
                    ?.copyWith(color: appTheme.gray700),
              ),
            ),
            PersonWidgetItem(
              index: widget.persons.indexWhere(
                (element) =>
                    element.id == widget.events[widget.index].personIndex,
              ),
              events: widget.events,
              persons: widget.persons,
            ),
          ],
        ),
      ),
    );
  }

  String getCostAmount() {
    double total = widget.events[widget.index].gifts
        .fold(0, (previousValue, element) => previousValue + element.price);

    return total.toString();
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
          child: Text('Event', style: theme.textTheme.headlineLarge),
        ),
      ),
    );
  }
}
