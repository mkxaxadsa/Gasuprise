import 'package:flutter/material.dart';
import 'package:gifting/core/app_export.dart';
import 'package:gifting/data/data_manager.dart';
import 'package:gifting/presentation/main_screen/widgets/event_widget_item.dart';
import 'package:gifting/presentation/main_screen/widgets/person_widget_item.dart';
import 'package:gifting/widgets/custom_elevated_button.dart';

import '../../../data/models/eventModel/event_model.dart';
import '../../../data/models/personModel/person_model.dart';
import '../../../widgets/app_bar/appbar_leading_image.dart';
import '../../../widgets/app_bar/appbar_subtitle.dart';
import '../../../widgets/app_bar/custom_app_bar.dart';

class PersonInfoScreen extends StatefulWidget {
  final List<Person> persons;
  final List<EventModel> events;
  final int index;

  const PersonInfoScreen(
      {key, required this.persons, required this.events, required this.index});

  static Widget builder(BuildContext context, List<Person> persons,
      List<EventModel> events, int index) {
    return PersonInfoScreen(
      persons: persons,
      events: events,
      index: index,
    );
  }

  @override
  State<PersonInfoScreen> createState() => _PersonInfoScreenState();
}

class _PersonInfoScreenState extends State<PersonInfoScreen> {
  List<EventModel> currModels = [];
  late Person currentPerson;

  @override
  void initState() {
    currentPerson = widget.persons[widget.index];
    currModels = widget.events
        .where((element) => element.personIndex == currentPerson.id)
        .toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      floatingActionButton: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 20.v),
        child: CustomElevatedButton(
          text: 'Delete',
          onPressed: () {
            List<EventModel> currentEvents = widget.events
                .where((element) => element.personIndex == currentPerson.id)
                .toList();
            if (currentEvents.isNotEmpty)
              for (int i = 0; i < currentEvents.length; i++) {
                DataManager.deleteEvent(currentEvents[i].id);
              }
            DataManager.deletePerson(currentPerson.id);
            NavigatorService.pushNamedAndRemoveUntil(AppRoutes.mainScreen);
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 20.v),
        child: SingleChildScrollView(
          child: Column(
            children: [
              PersonWidgetItem(
                persons: widget.persons,
                events: widget.events,
                isDisabled: true,
                index: widget.index,
              ),
              SizedBox(
                height: 30.v,
              ),
              Container(
                width: double.infinity,
                child: Text(
                  'Events',
                  style: theme.textTheme.titleMedium
                      ?.copyWith(color: appTheme.gray700),
                ),
              ),
              SizedBox(
                height: 10.v,
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: currModels.length,
                itemBuilder: (context, index) {
                  /*int mainIndex =  currModels.indexWhere((element) =>
                 element.personIndex == currentPerson.id, index);*/

                  return EventWidgetItem(
                    event: widget.events,
                    persons: widget.persons,
                    index: widget.events.indexWhere(
                        (element) => currModels[index].id == element.id),
                  );
                },
              ),
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
          child: Text('Person', style: theme.textTheme.headlineLarge),
        ),
      ),
    );
  }
}
