import 'package:flutter/material.dart';
import 'package:gifting/data/models/eventModel/event_model.dart';
import 'package:gifting/data/models/personModel/person_model.dart';
import 'package:gifting/presentation/event_screen/add_event_screen.dart';
import 'package:gifting/presentation/event_screen/event_info_screen/event_info_screen.dart';
import 'package:gifting/presentation/main_screen/main_screen.dart';
import 'package:gifting/presentation/onboarding_screen/onboarding_screen.dart';
import 'package:gifting/presentation/onboarding_screen/welcome_screen/welcome_screen.dart';
import 'package:gifting/presentation/person_screen/add_person_screen.dart';
import 'package:gifting/presentation/person_screen/person_info_screen/person_info_screen.dart';
import 'package:gifting/presentation/settings_screen/settings_screen.dart';

class AppRoutes {
  static const String onboardingScreen = '/onboarding_screen';
  static const String welcomeScreen = '/welcome_screen';
  static const String mainScreen = '/main_screen';
  static const String settingsScreen = '/settings_screen';
  static const String addPersonScreen = '/add_person_screen';
  static const String personInfoScreen = '/person_info_screen';
  static const String eventInfoScreen = '/event_info_screen';
  static const String addEventScreen = '/add_event_screen';
  static const String initialRoute = '/initialRoute';

  static Map<String, WidgetBuilder> get routes => {
        onboardingScreen: OnboardingScreen.builder,
        welcomeScreen: WelcomeScreen.builder,
        mainScreen: MainScreen.builder,
        settingsScreen: SettingsScreen.builder,
        addPersonScreen: AddPersonScreen.builder,
        addEventScreen: (context) {
          final arguments =
              ModalRoute.of(context)!.settings.arguments as List<Person>;
          return AddEventScreen.builder(context, arguments);
        },
        personInfoScreen: (context) {
          // Retrieve the arguments as a Map<String, int>
          final args =
              ModalRoute.of(context)!.settings.arguments as List<Object>;

          // Extract the values using the keys
          final List<Person> person = args[0] as List<Person>;
          final List<EventModel> events = args[1] as List<EventModel>;
          final int index = args[2] as int;

          // Pass the values to the TestResultScreen widget
          return PersonInfoScreen.builder(
            context,
            person,
            events,
            index
          );
        },
        eventInfoScreen: (context) {
          // Retrieve the arguments as a Map<String, int>
          final args =
              ModalRoute.of(context)!.settings.arguments as List<Object>;

          // Extract the values using the keys

          final List<Person> persons = args[0] as List<Person>;
          final List<EventModel> events = args[1] as List<EventModel>;
          final int index = args[2] as int;

          // Pass the values to the TestResultScreen widget
          return EventInfoScreen.builder(context, persons, events, index);
        },
      };
}
