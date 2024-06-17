part of 'main_bloc.dart';

@immutable
abstract class MainState {}

class MainInitial extends MainState {}

class MainLoadingState extends MainState {}

class MainLoadedState extends MainState {
  final List<Person> personList;
  final List<EventModel> eventList;

  MainLoadedState({required this.personList, required this.eventList});
}
