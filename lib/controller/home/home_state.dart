part of 'home_bloc.dart';

class HomeState {
  final bool isLoading;
  final List<LawyerModel> lawyers;
  HomeState({this.lawyers = const [], this.isLoading = false});
}

class HomeInitial extends HomeState {}
