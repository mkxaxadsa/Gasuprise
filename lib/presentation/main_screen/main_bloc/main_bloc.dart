import 'package:bloc/bloc.dart';
import 'package:gifting/data/data_manager.dart';
import 'package:meta/meta.dart';

import '../../../data/models/eventModel/event_model.dart';
import '../../../data/models/personModel/person_model.dart';

part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc() : super(MainInitial()) {
    on<MainInitEvent>(_onGetAllData);
  }

  _onGetAllData(MainInitEvent event, Emitter<MainState> emit) async {
    emit(MainLoadingState());

    List<Person> personList;
    List<EventModel> eventList;

    personList = await DataManager.getAllPersons();
    eventList = await DataManager.getAllEvents();

    emit(MainLoadedState(personList: personList, eventList: eventList));
  }
}
