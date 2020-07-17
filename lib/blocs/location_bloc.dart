import 'dart:async';

import 'package:edelivery_driver/services/location_service.dart';
import 'package:edelivery_driver/models/user_location.dart';

class LocationBloc{

  LocationService locationService;
  final StreamController<UserLocation> _locationController = StreamController<UserLocation>();
  Stream<UserLocation> get locationStream => _locationController.stream;

  Future updateUserLocation() async{
    var userLocation= await locationService.updateLocation();
    _locationController.sink.add(userLocation);
  }

}
