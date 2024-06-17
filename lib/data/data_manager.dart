import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'models/eventModel/event_model.dart';
import 'models/personModel/person_model.dart';

class DataManager {
  static const String _personKeyPrefix = 'person_';
  static const String _eventKeyPrefix = 'event_';

  static Future<void> savePerson(Person person) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String key = _personKeyPrefix + person.id;

    // Check if person already exists
    if (prefs.containsKey(key)) {
      // If person exists, update it
      await prefs.setString(key, json.encode(person.toJson()));
    } else {
      // If person doesn't exist, save new person
      await prefs.setString(key, json.encode(person.toJson()));
    }
  }

  static Future<Person?> getPerson(String personId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String key = _personKeyPrefix + personId;
    final String? jsonString = prefs.getString(key);
    if (jsonString != null) {
      return Person.fromJson(json.decode(jsonString));
    }
    return null;
  }

  // Метод для удаления Person
  static Future<void> deletePerson(String personId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String key = _personKeyPrefix + personId;

    await prefs.remove(key);
  }

  static Future<void> saveEvent(EventModel event) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String key = _eventKeyPrefix + event.id;


    await prefs.setString(key, json.encode(event.toJson()));
  }

  // Метод для удаления EventModel
  static Future<void> deleteEvent(String eventId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String key = _eventKeyPrefix + eventId;

    await prefs.remove(key);
  }

  static Future<EventModel?> getEvent(String eventId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String key = _eventKeyPrefix + eventId;
    final String? jsonString = prefs.getString(key);
    if (jsonString != null) {
      return EventModel.fromJson(json.decode(jsonString));
    }
    return null;
  }

  static Future<List<Person>> getAllPersons() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> keys = prefs.getKeys().where((key) => key.startsWith(_personKeyPrefix)).toList();
    final List<Person> persons = [];
    for (String key in keys) {
      final String? jsonString = prefs.getString(key);
      if (jsonString != null) {
        persons.add(Person.fromJson(json.decode(jsonString)));
      }
    }
    return persons;
  }

  static Future<List<EventModel>> getAllEvents() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> keys = prefs.getKeys().where((key) => key.startsWith(_eventKeyPrefix)).toList();
    final List<EventModel> events = [];
    for (String key in keys) {
      final String? jsonString = prefs.getString(key);
      if (jsonString != null) {
        events.add(EventModel.fromJson(json.decode(jsonString)));
      }
    }
    return events;
  }
}