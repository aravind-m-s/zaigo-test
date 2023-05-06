part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class Login extends LoginEvent {
  final String phoneNumber;
  final String password;
  Login({required this.phoneNumber, required this.password});
}

class Reset extends LoginEvent {}
