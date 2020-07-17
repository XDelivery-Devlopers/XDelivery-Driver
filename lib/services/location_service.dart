import 'package:location/location.dart';
import 'package:edelivery_driver/models/user_location.dart';

class LocationService{
  UserLocation currentLocation;
  var location = Location();
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData _locationData;

  LocationService(){
    updateLocation();
  }

  Future<UserLocation> getLocation() async {
    try {
      var userLocation = await location.getLocation();
      currentLocation = UserLocation(
        latitude: userLocation.latitude,
        longitude: userLocation.longitude,
      );
    } on Exception catch (e) {
      print('Could not get location: ${e.toString()}');
    }
    return currentLocation;
  }

  Future<UserLocation> updateLocation() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
    }
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted != PermissionStatus.granted) {
      _permissionGranted = await location.requestPermission();
    }
    location.onLocationChanged.listen((LocationData currLoc) {
      currentLocation = UserLocation( latitude: currLoc.latitude, longitude: currLoc.longitude) ;
    });
    return currentLocation;
  }




}
