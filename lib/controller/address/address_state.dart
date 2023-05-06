part of 'address_bloc.dart';

class AddressState {
  final String address;
  final bool isLoading;
  final String isError;
  AddressState(
      {required this.address, this.isError = '', this.isLoading = false});
}

class AddressInitial extends AddressState {
  AddressInitial() : super(address: '');
}
