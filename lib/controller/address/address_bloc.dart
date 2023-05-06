import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:meta/meta.dart';
import 'package:zaigo_test/services/geolocator_service.dart';

part 'address_event.dart';
part 'address_state.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  AddressBloc() : super(AddressInitial()) {
    on<GetAddress>((event, emit) async {
      emit(AddressState(address: state.address, isLoading: true));

      // Getting current positional latitude and longitude

      final position = await getPosition();

      if (position.runtimeType == String) {
        return emit(AddressState(address: state.address, isError: position));
      } else {
        // Retrives all the details from the latitude and longitude

        final List<Placemark> placemark = await placemarkFromCoordinates(
            position.latitude, position.longitude);
        final index = placemark.length > 1 ? 1 : 0;
        final address =
            " ${placemark[index].name}\n${placemark[index].street}\n${placemark[index].locality}, ${placemark[index].administrativeArea}\n${placemark[index].postalCode}\n${placemark[index].country}";
        emit(AddressState(address: address));
      }
    });
  }
}
