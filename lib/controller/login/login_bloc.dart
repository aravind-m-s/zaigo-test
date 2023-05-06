import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<Login>((event, emit) async {
      emit(LoginState(isLoading: true));
      final phoneNumber = event.phoneNumber;
      final password = event.password;
      const url =
          'http://80.211.233.121/blacklight/blacklight/public/api/auth/login';
      try {
        await Dio(BaseOptions()).post(
          url,
          queryParameters: {
            'phone_no': phoneNumber,
            'password': password,
          },
        ).then((value) async {
          final data = value.data;
          if (data.containsKey('error') == true) {
            emit(LoginState(isError: true, isLoading: false));
          } else {
            final prefs = await SharedPreferences.getInstance();
            prefs.setString('token', data['access_token']);
            emit(LoginState(isLoading: false, isError: false, isSucces: true));
          }
        });
      } catch (e) {
        emit(LoginState(isError: true, isLoading: false));
      }
    });
    on<Reset>((event, emit) {
      emit(LoginState());
    });
  }
}
