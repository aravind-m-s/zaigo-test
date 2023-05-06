part of 'login_bloc.dart';

class LoginState {
  final bool isLoading;
  final bool isError;
  final bool isSucces;
  LoginState(
      {this.isError = false, this.isLoading = false, this.isSucces = false});
}

class LoginInitial extends LoginState {}
