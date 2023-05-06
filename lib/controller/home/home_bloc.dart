import 'dart:developer';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:zaigo_test/model/lawyer_model.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<GetAllLawyers>((event, emit) async {
      emit(HomeState(isLoading: true));

      try {
        //  checking for internet connection

        final result = await InternetAddress.lookup('example.com');
        final List<LawyerModel> lawyers = [];
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          final prefs = await SharedPreferences.getInstance();
          final String token = prefs.getString('token') ?? '';

          // Getting data from server

          await Dio(BaseOptions())
              .get(
            'http://80.211.233.121/blacklight/blacklight/public/api/lawyers/index',
            options: Options(
              headers: {'Authorization': 'Bearer $token'},
            ),
          )
              .then((value) {
// Checking for error and converting to model class format

            if (value.data != null && !value.data!.containsKey('error')) {
              final List datas = value.data['data'];
              for (var element in datas) {
                lawyers.add(LawyerModel.fromJson(element));
              }
            } else {
              throw 'something went wrong';
            }
          });
        } else {
          throw 'something went wrong';
        }

        // Adding to local database

        final database = await openDatabase('lawyer.db', version: 1,
            onCreate: (Database db, int version) async {
          await db.execute(
            'CREATE TABLE lawyers (id INTEGER PRIMARY KEY, uuid TEXT, name TEXT, address TEXT, state TEXT, field_of_expertise TEXT, bio TEXT, level TEXT, hours_logged TEXT, phone_no TEXT, email TEXT, profile_picture TEXT, rating TEXT, ranking TEXT )',
          );
        });
        final datas = await database.rawQuery('SELECT * FROM lawyers');
        if (datas.length != lawyers.length) {
          for (var element in lawyers) {
            await database.rawQuery(
                'INSERT INTO lawyers(id, uuid, name, address, state, field_of_expertise, bio, level, hours_logged, phone_no, email, profile_picture, rating, ranking) values ( ${element.id}, "${element.uuid}", "${element.name}", "${element.address}", "${element.state}", "${element.fieldOfExpertise}", "${element.bio}", "${element.level}", "${element.hoursLogged}", "${element.phoneNo}", "${element.email}", "${element.profilePicture}", "${element.rating}", "${element.ranking}")');
          }
        }

        emit(HomeState(lawyers: lawyers));
      } catch (e) {
        // Getting from local database in case of any error

        final database = await openDatabase('lawyer.db', version: 1,
            onCreate: (Database db, int version) async {
          await db.execute(
              'CREATE TABLE lawyers (id INTEGER PRIMARY KEY, uuid TEXT, name TEXT, address TEXT, state TEXT, field_of_expertise TEXT, bio TEXT, level TEXT, hours_logged TEXT, phone_no TEXT, email TEXT, profile_picture TEXT, rating TEXT, ranking TEXT )');
        });
        final List<LawyerModel> lawyers = [];
        await database.rawQuery('SELECT * FROM lawyers').then((value) {
          for (var element in value) {
            lawyers.add(LawyerModel.fromJson(element));
          }
          emit(HomeState(lawyers: lawyers));
        });
      }
    });
  }
}
