import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gifting/core/app_export.dart';
import 'package:gifting/presentation/main_screen/main_bloc/main_bloc.dart';
import 'package:gifting/presentation/main_screen/widgets/event_widget_item.dart';
import 'package:gifting/presentation/main_screen/widgets/person_widget_item.dart';
import 'package:gifting/widgets/custom_elevated_button.dart';

import '../../widgets/app_bar/appbar_subtitle.dart';
import '../../widgets/app_bar/custom_app_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({key});

  static Widget builder(BuildContext context) {
    return BlocProvider<MainBloc>(
      create: (context) => MainBloc()..add(MainInitEvent()),
      child: MainScreen(),
    );
  }

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool isPersonListExpanded = false;
  bool isEventListExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: BlocBuilder<MainBloc, MainState>(
        builder: (context, state) {
          if (state is MainLoadedState) {
            return _buildContent(context, state);
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget _buildContent(BuildContext context, MainLoadedState state) {
    if (state.personList.isEmpty)
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 20.v),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 300.v,
              decoration: AppDecoration.surface.copyWith(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                //crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.h),
                    child: CustomImageView(
                      height: 180,
                      imagePath: ImageConstant.imgGroup,
                    ),
                  ),
                  Text(
                    'No person yet',
                    style: theme.textTheme.titleMedium,
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Text(
                    'Click on the button to create\na new person',
                    textAlign: TextAlign.center,
                    style: CustomTextStyles.titleMediumGray700,
                  ),
                ],
              ),
            ),
            CustomElevatedButton(
              text: 'Add Person',
              onPressed: () =>
                  NavigatorService.pushNamed(AppRoutes.addPersonScreen),
            )
          ],
        ),
      );
    else
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 20.v),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _buildPersonsList(context, state),
              SizedBox(
                height: 40.v,
              ),
              _buildEventList(context, state)
            ],
          ),
        ),
      );
  }

  //Persons
  Widget _buildPersonsList(BuildContext context, MainLoadedState state) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Persons',
              style: theme.textTheme.titleMedium
                  ?.copyWith(color: appTheme.gray700),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  isPersonListExpanded = !isPersonListExpanded;
                });
              },
              child: Text(
                'View All',
                style: theme.textTheme.titleMedium,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10.v,
        ),
        ListView.builder(
          shrinkWrap: true,
          physics:const  NeverScrollableScrollPhysics(),
          itemCount: isPersonListExpanded || state.personList.length < 5 ? state.personList.length : 5,
          itemBuilder: (context, index) {
            return PersonWidgetItem(
              persons: state.personList,
              events: state.eventList,
              index: index,

            );
          },
        ),
        SizedBox(
          height: 10.v,
        ),
        CustomElevatedButton(
          text: 'Add person',
          onPressed: () {
            NavigatorService.pushNamed(AppRoutes.addPersonScreen);
          },
        )
      ],
    );
  }

  //Events
  Widget _buildEventList(BuildContext context, MainLoadedState state) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Events',
              style: theme.textTheme.titleMedium
                  ?.copyWith(color: appTheme.gray700),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  isEventListExpanded = !isEventListExpanded;
                });
              },
              child: Text(
                'View All',
                style: theme.textTheme.titleMedium,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10.v,
        ),
        ListView.builder(
          physics:const  NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: isEventListExpanded || state.eventList.isEmpty || state.eventList.length < 5
              ? state.eventList.length
              : 5,
          itemBuilder: (context, index) {
            return EventWidgetItem(
              event: state.eventList,
              persons: state.personList,
              index:  index,
            );
          },
        ),
        SizedBox(
          height: 10.v,
        ),
        CustomElevatedButton(
          text: 'Add event',
          onPressed: () {
            NavigatorService.pushNamed(AppRoutes.addEventScreen,
                arguments: state.personList);
          },
        )
      ],
    );
  }

  File base64ToFile(String base64String, String fileName) {
    List<int> bytes = base64Decode(base64String);
    String dir =
        '/storage/emulated/0/'; // Путь к директории для сохранения файла
    File file = File('$dir$fileName');
    file.writeAsBytesSync(bytes);
    return file;
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 40.h,
      height: 90,
      title: AppbarSubtitle(
        text: 'Settings',
        margin: EdgeInsets.only(left: 16.h),
        onTap: () {
          NavigatorService.pushNamed(AppRoutes.settingsScreen);
        },
      ),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(30.0),
        child: Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text('Gifting', style: theme.textTheme.headlineLarge),
        ),
      ),
    );
  }
}
